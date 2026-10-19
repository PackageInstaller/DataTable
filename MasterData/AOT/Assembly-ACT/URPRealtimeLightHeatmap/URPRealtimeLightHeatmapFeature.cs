using System;
using Unity.Collections;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace URPRealtimeLightHeatmap;

public sealed class URPRealtimeLightHeatmapFeature : ScriptableRendererFeature
{
	private sealed class RealtimeLightVolumePass : ScriptableRenderPass
	{
		private const int SphereLatitudeSegments = 12;

		private const int SphereLongitudeSegments = 20;

		private const int SpotLatitudeSegments = 4;

		private const int SpotLongitudeSegments = 16;

		private const float StencilShapeGuard = 1.06067f;

		public static readonly int LightVolumeCountTextureId = Shader.PropertyToID("_RealtimeLightVolumeCountTexture");

		public static readonly int SourceDepthTextureId = Shader.PropertyToID("_RealtimeLightHeatmapSourceDepth");

		private static readonly int SpotLightScaleId = Shader.PropertyToID("_SpotLightScale");

		private static readonly int SpotLightBiasId = Shader.PropertyToID("_SpotLightBias");

		private static readonly int SpotLightGuardId = Shader.PropertyToID("_SpotLightGuard");

		private static readonly ProfilingSampler HeatmapSampler = new ProfilingSampler("Realtime Light Volume Stencil Count");

		private static GraphicsFormat s_CountFormat = GraphicsFormat.None;

		private static GraphicsFormat s_DepthStencilFormat = GraphicsFormat.None;

		private ScriptableRenderer _renderer;

		private Material _heatmapMaterial;

		private Mesh _sphereMesh;

		private Mesh _spotLightMesh;

		private RenderTexture _countTexture;

		private RenderTexture _depthStencilTexture;

		private int _preparedCameraId = int.MinValue;

		private int _preparedFrame = -1;

		private readonly MaterialPropertyBlock _spotLightProperties = new MaterialPropertyBlock();

		public RenderTexture CountTexture => _countTexture;

		public RealtimeLightVolumePass()
		{
			profilingSampler = HeatmapSampler;
			renderPassEvent = (RenderPassEvent)236;
			nativeRenderPassType = NativeRenderPassType.None;
			targetCount = 0u;
		}

		public bool IsPreparedFor(Camera camera)
		{
			if (camera != null && _preparedCameraId == camera.GetInstanceID())
			{
				return _preparedFrame == Time.frameCount;
			}
			return false;
		}

		public void Setup(ScriptableRenderer renderer, Material heatmapMaterial)
		{
			_renderer = renderer;
			_heatmapMaterial = heatmapMaterial;
		}

		public override void Configure(ref RenderingData renderingData)
		{
			nativeRenderPassType = NativeRenderPassType.None;
			targetCount = 0u;
		}

		public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
		{
			_preparedCameraId = int.MinValue;
			_preparedFrame = -1;
			if (_renderer == null || _heatmapMaterial == null)
			{
				return;
			}
			EnsureVolumeMeshes();
			if (_sphereMesh == null || _spotLightMesh == null)
			{
				return;
			}
			Camera camera = renderingData.cameraData.camera;
			RenderTextureDescriptor cameraTargetDescriptor = renderingData.cameraData.cameraTargetDescriptor;
			cameraTargetDescriptor.width = Mathf.Max(1, camera.pixelWidth);
			cameraTargetDescriptor.height = Mathf.Max(1, camera.pixelHeight);
			cameraTargetDescriptor.depthBufferBits = 0;
			cameraTargetDescriptor.depthStencilFormat = GraphicsFormat.None;
			cameraTargetDescriptor.msaaSamples = 1;
			cameraTargetDescriptor.graphicsFormat = ResolveCountFormat();
			cameraTargetDescriptor.useMipMap = false;
			cameraTargetDescriptor.autoGenerateMips = false;
			cameraTargetDescriptor.enableRandomWrite = false;
			cameraTargetDescriptor.useDynamicScale = false;
			RenderTextureDescriptor depthStencilDescriptor = cameraTargetDescriptor;
			depthStencilDescriptor.graphicsFormat = GraphicsFormat.None;
			depthStencilDescriptor.depthStencilFormat = ResolveDepthStencilFormat();
			EnsureRenderTargets(cameraTargetDescriptor, depthStencilDescriptor);
			if (!(_countTexture == null) && !(_depthStencilTexture == null))
			{
				CommandBuffer commandBuffer = CommandBufferPool.Get("Realtime Light Volume Stencil Count");
				using (new ProfilingScope(commandBuffer, profilingSampler))
				{
					RenderTargetIdentifier colorBuffer = new RenderTargetIdentifier(_countTexture);
					RenderTargetIdentifier depthBuffer = new RenderTargetIdentifier(_depthStencilTexture);
					CoreUtils.SetRenderTarget(commandBuffer, colorBuffer, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store, depthBuffer, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store, ClearFlag.All, Color.clear);
					commandBuffer.SetViewport(new Rect(0f, 0f, cameraTargetDescriptor.width, cameraTargetDescriptor.height));
					commandBuffer.SetGlobalTexture(SourceDepthTextureId, _renderer.cameraDepthTarget);
					RenderingUtils.DrawProcedural(commandBuffer, _heatmapMaterial, 0, new Vector4(1f, 1f, 0f, 0f));
					commandBuffer.SetViewProjectionMatrices(renderingData.cameraData.GetViewMatrix(), renderingData.cameraData.GetProjectionMatrix());
					DrawVisibleLightVolumes(commandBuffer, ref renderingData);
					CoreUtils.SetRenderTarget(commandBuffer, _renderer.cameraColorTarget, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, _renderer.cameraDepthTarget, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, ClearFlag.None, Color.black);
					commandBuffer.SetViewport(new Rect(0f, 0f, cameraTargetDescriptor.width, cameraTargetDescriptor.height));
				}
				_preparedCameraId = camera.GetInstanceID();
				_preparedFrame = Time.frameCount;
				context.ExecuteCommandBuffer(commandBuffer);
				CommandBufferPool.Release(commandBuffer);
			}
		}

		public void ReleaseResources()
		{
			CoreUtils.Destroy(_sphereMesh);
			CoreUtils.Destroy(_spotLightMesh);
			CoreUtils.Destroy(_countTexture);
			CoreUtils.Destroy(_depthStencilTexture);
			_sphereMesh = null;
			_spotLightMesh = null;
			_countTexture = null;
			_depthStencilTexture = null;
			_preparedCameraId = int.MinValue;
			_preparedFrame = -1;
		}

		private void DrawVisibleLightVolumes(CommandBuffer cmd, ref RenderingData renderingData)
		{
			NativeArray<VisibleLight> visibleLights = renderingData.lightData.visibleLights;
			int mainLightIndex = renderingData.lightData.mainLightIndex;
			for (int i = 0; i < visibleLights.Length; i++)
			{
				if (i == mainLightIndex)
				{
					continue;
				}
				VisibleLight visibleLight = visibleLights[i];
				if (IsRealtimeLight(visibleLight.light))
				{
					switch (visibleLight.lightType)
					{
					case LightType.Point:
						DrawPointLightVolume(cmd, visibleLight);
						break;
					case LightType.Spot:
						DrawSpotLightVolume(cmd, visibleLight);
						break;
					}
				}
			}
		}

		private void DrawPointLightVolume(CommandBuffer cmd, VisibleLight visibleLight)
		{
			Vector4 column = visibleLight.localToWorldMatrix.GetColumn(3);
			Vector3 pos = new Vector3(column.x, column.y, column.z);
			float num = Mathf.Max(0.001f, visibleLight.range);
			Matrix4x4 matrix = Matrix4x4.TRS(pos, Quaternion.identity, Vector3.one * (num * 1.06067f));
			cmd.DrawMesh(_sphereMesh, matrix, _heatmapMaterial, 0, 1);
			cmd.DrawMesh(_sphereMesh, matrix, _heatmapMaterial, 0, 2);
		}

		private void DrawSpotLightVolume(CommandBuffer cmd, VisibleLight visibleLight)
		{
			float f = MathF.PI / 180f * Mathf.Min(179f, visibleLight.spotAngle) * 0.5f;
			float num = Mathf.Cos(f);
			float num2 = Mathf.Sin(f);
			float num3 = Mathf.Max(0.001f, visibleLight.range);
			float num4 = Mathf.Lerp(1f, 1.06067f, num2);
			_spotLightProperties.Clear();
			_spotLightProperties.SetVector(SpotLightScaleId, new Vector4(num2, num2, 1f - num, num3));
			_spotLightProperties.SetVector(SpotLightBiasId, new Vector4(0f, 0f, num, 0f));
			_spotLightProperties.SetVector(SpotLightGuardId, new Vector4(num4, num4, num4, num * num3));
			cmd.DrawMesh(_spotLightMesh, visibleLight.localToWorldMatrix, _heatmapMaterial, 0, 3, _spotLightProperties);
			cmd.DrawMesh(_spotLightMesh, visibleLight.localToWorldMatrix, _heatmapMaterial, 0, 4, _spotLightProperties);
		}

		private static bool IsRealtimeLight(Light light)
		{
			if (light != null && light.enabled && light.gameObject.activeInHierarchy)
			{
				return light.bakingOutput.lightmapBakeType != LightmapBakeType.Baked;
			}
			return false;
		}

		private void EnsureVolumeMeshes()
		{
			if (_sphereMesh == null)
			{
				_sphereMesh = CreateSphereMesh();
			}
			if (_spotLightMesh == null)
			{
				_spotLightMesh = CreateSpotLightMesh();
			}
		}

		private static Mesh CreateSphereMesh()
		{
			int num = 21;
			Vector3[] array = new Vector3[13 * num];
			int[] array2 = new int[1440];
			int num2 = 0;
			for (int i = 0; i <= 12; i++)
			{
				float f = MathF.PI * (float)i / 12f;
				float num3 = Mathf.Sin(f);
				float y = Mathf.Cos(f);
				for (int j = 0; j <= 20; j++)
				{
					float f2 = MathF.PI * 2f * (float)j / 20f;
					array[num2++] = new Vector3(num3 * Mathf.Cos(f2), y, num3 * Mathf.Sin(f2));
				}
			}
			int num4 = 0;
			for (int k = 0; k < 12; k++)
			{
				for (int l = 0; l < 20; l++)
				{
					int num5 = k * num + l;
					int num6 = num5 + num;
					array2[num4++] = num5;
					array2[num4++] = num5 + 1;
					array2[num4++] = num6;
					array2[num4++] = num5 + 1;
					array2[num4++] = num6 + 1;
					array2[num4++] = num6;
				}
			}
			Mesh mesh = new Mesh();
			mesh.name = "RealtimeLightHeatmap_Sphere";
			mesh.vertices = array;
			mesh.triangles = array2;
			mesh.RecalculateBounds();
			return mesh;
		}

		private static Mesh CreateSpotLightMesh()
		{
			int num = 17;
			int num2 = 0;
			int num3 = 1 + 4 * num;
			Vector3[] array = new Vector3[num3 + 1];
			array[num2] = Vector3.zero;
			array[num3] = Vector3.forward;
			for (int i = 0; i < 4; i++)
			{
				float f = MathF.PI / 2f * (float)i / 4f;
				float num4 = Mathf.Cos(f);
				float z = Mathf.Sin(f);
				for (int j = 0; j <= 16; j++)
				{
					float f2 = MathF.PI * 2f * (float)j / 16f;
					array[1 + i * num + j] = new Vector3(num4 * Mathf.Cos(f2), num4 * Mathf.Sin(f2), z);
				}
			}
			int num5 = 48;
			int[] array2 = new int[48 + num5 * 6 + 48];
			int num6 = 0;
			for (int k = 0; k < 16; k++)
			{
				array2[num6++] = num2;
				array2[num6++] = 1 + k + 1;
				array2[num6++] = 1 + k;
			}
			for (int l = 0; l < 3; l++)
			{
				for (int m = 0; m < 16; m++)
				{
					int num7 = 1 + l * num + m;
					int num8 = num7 + num;
					array2[num6++] = num7;
					array2[num6++] = num7 + 1;
					array2[num6++] = num8;
					array2[num6++] = num7 + 1;
					array2[num6++] = num8 + 1;
					array2[num6++] = num8;
				}
			}
			int num9 = 1 + 3 * num;
			for (int n = 0; n < 16; n++)
			{
				array2[num6++] = num9 + n;
				array2[num6++] = num9 + n + 1;
				array2[num6++] = num3;
			}
			Mesh mesh = new Mesh();
			mesh.name = "RealtimeLightHeatmap_SpotVolume";
			mesh.vertices = array;
			mesh.triangles = array2;
			mesh.RecalculateBounds();
			return mesh;
		}

		private void EnsureRenderTargets(RenderTextureDescriptor countDescriptor, RenderTextureDescriptor depthStencilDescriptor)
		{
			bool num = _countTexture != null && _countTexture.width == countDescriptor.width && _countTexture.height == countDescriptor.height && _countTexture.graphicsFormat == countDescriptor.graphicsFormat;
			bool flag = _depthStencilTexture != null && _depthStencilTexture.width == depthStencilDescriptor.width && _depthStencilTexture.height == depthStencilDescriptor.height && _depthStencilTexture.depthStencilFormat == depthStencilDescriptor.depthStencilFormat;
			if (!(num & flag))
			{
				CoreUtils.Destroy(_countTexture);
				CoreUtils.Destroy(_depthStencilTexture);
				_countTexture = new RenderTexture(countDescriptor)
				{
					name = "Realtime Light Heatmap Count",
					filterMode = FilterMode.Point,
					wrapMode = TextureWrapMode.Clamp,
					hideFlags = HideFlags.HideAndDontSave
				};
				_depthStencilTexture = new RenderTexture(depthStencilDescriptor)
				{
					name = "Realtime Light Heatmap Private Depth Stencil",
					filterMode = FilterMode.Point,
					wrapMode = TextureWrapMode.Clamp,
					hideFlags = HideFlags.HideAndDontSave
				};
				_countTexture.Create();
				_depthStencilTexture.Create();
			}
		}

		private static GraphicsFormat ResolveCountFormat()
		{
			if (s_CountFormat != GraphicsFormat.None)
			{
				return s_CountFormat;
			}
			s_CountFormat = (SystemInfo.IsFormatSupported(GraphicsFormat.R16_SFloat, FormatUsage.Render) ? GraphicsFormat.R16_SFloat : GraphicsFormat.R32_SFloat);
			return s_CountFormat;
		}

		private static GraphicsFormat ResolveDepthStencilFormat()
		{
			if (s_DepthStencilFormat != GraphicsFormat.None)
			{
				return s_DepthStencilFormat;
			}
			s_DepthStencilFormat = SystemInfo.GetCompatibleFormat(GraphicsFormat.D24_UNorm_S8_UInt, FormatUsage.Render);
			return s_DepthStencilFormat;
		}
	}

	private sealed class RealtimeLightCompositePass : ScriptableRenderPass
	{
		private static readonly int HeatmapMaxLightsId = Shader.PropertyToID("_RealtimeLightHeatmapMaxLights");

		private static readonly int HeatmapOpacityId = Shader.PropertyToID("_RealtimeLightHeatmapOpacity");

		private static readonly ProfilingSampler CompositeSampler = new ProfilingSampler("Realtime Light Volume Heatmap Composite");

		private ScriptableRenderer _renderer;

		private Material _heatmapMaterial;

		private RealtimeLightVolumePass _volumePass;

		public RealtimeLightCompositePass()
		{
			profilingSampler = CompositeSampler;
			renderPassEvent = RenderPassEvent.ScreenShotPass;
			nativeRenderPassType = NativeRenderPassType.None;
			targetCount = 0u;
		}

		public void Setup(ScriptableRenderer renderer, Material heatmapMaterial, RealtimeLightVolumePass volumePass)
		{
			_renderer = renderer;
			_heatmapMaterial = heatmapMaterial;
			_volumePass = volumePass;
		}

		public override void Configure(ref RenderingData renderingData)
		{
			nativeRenderPassType = NativeRenderPassType.None;
			targetCount = 0u;
		}

		public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
		{
			RenderTexture renderTexture = _volumePass?.CountTexture;
			if (_renderer != null && !(_heatmapMaterial == null) && _volumePass != null && _volumePass.IsPreparedFor(renderingData.cameraData.camera) && !(renderTexture == null) && renderTexture.IsCreated())
			{
				CommandBuffer commandBuffer = CommandBufferPool.Get("Realtime Light Volume Heatmap Composite");
				using (new ProfilingScope(commandBuffer, profilingSampler))
				{
					commandBuffer.SetGlobalTexture(RealtimeLightVolumePass.LightVolumeCountTextureId, renderTexture);
					_heatmapMaterial.SetFloat(HeatmapMaxLightsId, 9f);
					_heatmapMaterial.SetFloat(HeatmapOpacityId, 0.72f);
					CoreUtils.SetRenderTarget(commandBuffer, _renderer.cameraColorTarget, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, _renderer.cameraDepthTarget, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, ClearFlag.None, Color.black);
					commandBuffer.SetViewport(new Rect(0f, 0f, renderTexture.width, renderTexture.height));
					RenderingUtils.DrawProcedural(commandBuffer, _heatmapMaterial, 5, new Vector4(1f, 1f, 0f, 0f));
				}
				context.ExecuteCommandBuffer(commandBuffer);
				CommandBufferPool.Release(commandBuffer);
			}
		}
	}

	private const string HeatmapShaderName = "Hidden/URPRealtimeLightHeatmap/Heatmap";

	private Material _heatmapMaterial;

	private RealtimeLightVolumePass _volumePass;

	private RealtimeLightCompositePass _compositePass;

	public override void Create()
	{
	}

	public override void AddRenderPasses(ScriptableRenderer renderer, ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		if (ShouldRender(ref renderingData))
		{
			if (_heatmapMaterial == null)
			{
				_heatmapMaterial = CoreUtils.CreateEngineMaterial("Hidden/URPRealtimeLightHeatmap/Heatmap");
			}
			if (!(_heatmapMaterial == null))
			{
				EnsurePasses();
				_volumePass.Setup(renderer, _heatmapMaterial);
				_compositePass.Setup(renderer, _heatmapMaterial, _volumePass);
				renderer.EnqueuePass(_volumePass);
				renderer.EnqueuePass(_compositePass);
			}
		}
	}

	protected override void Dispose(bool disposing)
	{
		_volumePass?.ReleaseResources();
		Shader.SetGlobalTexture(RealtimeLightVolumePass.LightVolumeCountTextureId, null);
		Shader.SetGlobalTexture(RealtimeLightVolumePass.SourceDepthTextureId, null);
		CoreUtils.Destroy(_heatmapMaterial);
		_heatmapMaterial = null;
		_volumePass = null;
		_compositePass = null;
	}

	private void EnsurePasses()
	{
		if (_volumePass == null)
		{
			_volumePass = new RealtimeLightVolumePass();
		}
		if (_compositePass == null)
		{
			_compositePass = new RealtimeLightCompositePass();
		}
	}

	private static bool ShouldRender(ref RenderingData renderingData)
	{
		return false;
	}
}
