using System;
using System.Collections.Generic;
using Unity.Collections;
using UnityEngine;
using UnityEngine.Experimental.Rendering;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace URPGameViewOverdraw;

public sealed class URPGameViewOverdrawFeature : ScriptableRendererFeature
{
	public enum DisplayMode
	{
		Overlay,
		Isolate
	}

	public enum CameraFilter
	{
		GameOnly,
		GameAndSceneView,
		All
	}

	[Serializable]
	public sealed class Settings
	{
		public CameraFilter cameraFilter;

		public DisplayMode displayMode;

		public RenderPassEvent injectionPoint = RenderPassEvent.ScreenShotPass;

		public LayerMask layerMask = -1;

		public bool includeOpaque = true;

		public bool includeTransparent = true;

		public bool includeReflectionAndPreviewCameras;

		[Tooltip("Logs particle fallback candidates and baked vertex counts every 120 frames.")]
		public bool logParticleDiagnostics;

		[Range(0.005f, 0.25f)]
		public float countStep = 0.045f;

		[Tooltip("Eye-space distance allowed between a transparent fragment and the final opaque depth.")]
		[Min(0f)]
		public float depthTolerance = 0.05f;

		[Range(0.25f, 8f)]
		public float heatIntensity = 2.2f;

		[Range(0f, 1f)]
		public float overlayOpacity = 0.78f;

		[Range(1f, 64f)]
		public float maxVisualizedLayers = 16f;
	}

	private sealed class OverdrawPass : ScriptableRenderPass
	{
		private static readonly int OverdrawTextureId = Shader.PropertyToID("_GameViewOverdrawTexture");

		private static readonly int OverdrawDepthTextureId = Shader.PropertyToID("_GameViewOverdrawDepthTexture");

		private static readonly int OverdrawRasterDepthId = Shader.PropertyToID("_GameViewOverdrawRasterDepth");

		private static readonly int OverdrawStencilTextureId = Shader.PropertyToID("_GameViewOverdrawStencilTexture");

		private static readonly int ParticleCountTextureId = Shader.PropertyToID("_GameViewOverdrawParticleCountTexture");

		private static readonly int GeometryCountTextureId = Shader.PropertyToID("_GameViewOverdrawGeometryCountTexture");

		private static readonly int ParticleDepthTextureId = Shader.PropertyToID("_GameViewOverdrawParticleDepthTexture");

		private static readonly int ScaleBiasRtId = Shader.PropertyToID("_ScaleBiasRt");

		private static readonly ProfilingSampler OverdrawSampler = new ProfilingSampler("Game View Overdraw");

		private static readonly ShaderTagId[] ShaderTagIds = new ShaderTagId[16]
		{
			new ShaderTagId("UniversalForward"),
			new ShaderTagId("UniversalForward2"),
			new ShaderTagId("UniversalForward3"),
			new ShaderTagId("UniversalForwardOnly"),
			new ShaderTagId("UniversalGBuffer"),
			new ShaderTagId("Forward2"),
			new ShaderTagId("ForwardOutline"),
			new ShaderTagId("ForwardOnly2"),
			new ShaderTagId("ForwardOnlyOutline"),
			new ShaderTagId("ForwardOnlyHairShadow"),
			new ShaderTagId("SRPDefaultUnlit"),
			new ShaderTagId("LightweightForward"),
			new ShaderTagId("TransBehind"),
			new ShaderTagId("Water"),
			new ShaderTagId("ACT3DUI"),
			new ShaderTagId("Universal2D")
		};

		private static GraphicsFormat s_OverdrawFormat = GraphicsFormat.None;

		private static GraphicsFormat s_DepthStencilFormat = GraphicsFormat.None;

		private Settings _settings;

		private Material _countMaterial;

		private Material _countBackMaterial;

		private Material _countFrontMaterial;

		private Material _depthCopyMaterial;

		private Material _compositeMaterial;

		private RenderStateBlock _transparentCountState;

		private readonly Plane[] _frustumPlanes = new Plane[6];

		private readonly Dictionary<ParticleSystemRenderer, Mesh> _particleMeshes = new Dictionary<ParticleSystemRenderer, Mesh>();

		private readonly List<Material> _sharedMaterials = new List<Material>(8);

		private int _lastParticleDiagnosticFrame = -120;

		private RenderTexture _particleCountTexture;

		private bool _requestParticleReadback;

		public OverdrawPass()
		{
			profilingSampler = OverdrawSampler;
			nativeRenderPassType = NativeRenderPassType.None;
			targetCount = 0u;
			BlendState defaultValue = BlendState.defaultValue;
			defaultValue.blendState0 = new RenderTargetBlendState((ColorWriteMask)0);
			StencilState defaultValue2 = StencilState.defaultValue;
			defaultValue2.enabled = true;
			defaultValue2.SetCompareFunction(CompareFunction.Always);
			defaultValue2.SetPassOperation(StencilOp.IncrementSaturate);
			defaultValue2.SetFailOperation(StencilOp.Keep);
			defaultValue2.SetZFailOperation(StencilOp.Keep);
			_transparentCountState = new RenderStateBlock(RenderStateMask.Blend | RenderStateMask.Depth | RenderStateMask.Stencil)
			{
				blendState = defaultValue,
				depthState = new DepthState(writeEnabled: false, CompareFunction.LessEqual),
				stencilReference = 0,
				stencilState = defaultValue2
			};
		}

		public void Setup(Settings settings, Material countMaterial, Material countBackMaterial, Material countFrontMaterial, Material depthCopyMaterial, Material compositeMaterial)
		{
			_settings = settings;
			_countMaterial = countMaterial;
			_countBackMaterial = countBackMaterial;
			_countFrontMaterial = countFrontMaterial;
			_depthCopyMaterial = depthCopyMaterial;
			_compositeMaterial = compositeMaterial;
		}

		public override void Configure(ref RenderingData renderingData)
		{
			nativeRenderPassType = NativeRenderPassType.None;
			targetCount = 0u;
		}

		public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
		{
			if (_settings == null || _countMaterial == null || _countBackMaterial == null || _countFrontMaterial == null || _depthCopyMaterial == null || _compositeMaterial == null)
			{
				return;
			}
			CommandBuffer commandBuffer = CommandBufferPool.Get("Game View Overdraw");
			using (new ProfilingScope(commandBuffer, profilingSampler))
			{
				RenderTextureDescriptor cameraTargetDescriptor;
				RenderTextureDescriptor renderTextureDescriptor = (cameraTargetDescriptor = renderingData.cameraData.cameraTargetDescriptor);
				Camera camera = renderingData.cameraData.camera;
				cameraTargetDescriptor.width = Mathf.Max(1, camera.pixelWidth);
				cameraTargetDescriptor.height = Mathf.Max(1, camera.pixelHeight);
				cameraTargetDescriptor.depthBufferBits = 0;
				cameraTargetDescriptor.depthStencilFormat = GraphicsFormat.None;
				cameraTargetDescriptor.msaaSamples = 1;
				cameraTargetDescriptor.graphicsFormat = ResolveOverdrawFormat();
				cameraTargetDescriptor.useMipMap = false;
				cameraTargetDescriptor.autoGenerateMips = false;
				cameraTargetDescriptor.enableRandomWrite = false;
				cameraTargetDescriptor.useDynamicScale = false;
				commandBuffer.GetTemporaryRT(OverdrawTextureId, cameraTargetDescriptor, FilterMode.Bilinear);
				RenderTextureDescriptor desc = renderTextureDescriptor;
				desc.depthBufferBits = 0;
				desc.depthStencilFormat = GraphicsFormat.None;
				desc.msaaSamples = 1;
				desc.graphicsFormat = ResolveOverdrawFormat();
				desc.useMipMap = false;
				desc.autoGenerateMips = false;
				desc.enableRandomWrite = false;
				desc.useDynamicScale = false;
				EnsureParticleCountTexture(desc);
				commandBuffer.GetTemporaryRT(GeometryCountTextureId, desc, FilterMode.Bilinear);
				RenderTextureDescriptor desc2 = cameraTargetDescriptor;
				desc2.graphicsFormat = GraphicsFormat.None;
				desc2.depthStencilFormat = ResolveDepthStencilFormat();
				commandBuffer.GetTemporaryRT(OverdrawRasterDepthId, desc2, FilterMode.Point);
				RenderTargetIdentifier renderTargetIdentifier = new RenderTargetIdentifier(OverdrawTextureId);
				RenderTargetIdentifier value = new RenderTargetIdentifier(OverdrawDepthTextureId);
				RenderTargetIdentifier renderTargetIdentifier2 = new RenderTargetIdentifier(OverdrawRasterDepthId);
				RenderTargetIdentifier colorBuffer = new RenderTargetIdentifier(_particleCountTexture);
				RenderTargetIdentifier renderTargetIdentifier3 = new RenderTargetIdentifier(GeometryCountTextureId);
				commandBuffer.SetGlobalTexture(OverdrawDepthTextureId, value);
				CoreUtils.SetRenderTarget(commandBuffer, renderTargetIdentifier, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store, renderTargetIdentifier2, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store, ClearFlag.All, Color.clear);
				commandBuffer.SetViewport(new Rect(0f, 0f, cameraTargetDescriptor.width, cameraTargetDescriptor.height));
				_countMaterial.SetFloat(OverdrawStepId, _settings.countStep);
				_countBackMaterial.SetFloat(OverdrawStepId, _settings.countStep);
				_countFrontMaterial.SetFloat(OverdrawStepId, _settings.countStep);
				_depthCopyMaterial.SetFloat(OverdrawStepId, _settings.countStep);
				_depthCopyMaterial.SetFloat(DepthToleranceId, _settings.depthTolerance);
				_depthCopyMaterial.SetFloat(IncludeOpaqueId, _settings.includeOpaque ? 1f : 0f);
				_depthCopyMaterial.SetVector(OutputSizeId, new Vector4(cameraTargetDescriptor.width, cameraTargetDescriptor.height, 1f / (float)cameraTargetDescriptor.width, 1f / (float)cameraTargetDescriptor.height));
				_compositeMaterial.SetFloat(OverdrawStepId, _settings.countStep);
				_compositeMaterial.SetFloat(HeatIntensityId, _settings.heatIntensity);
				_compositeMaterial.SetFloat(OverlayOpacityId, _settings.overlayOpacity);
				_compositeMaterial.SetFloat(DisplayModeId, (_settings.displayMode == DisplayMode.Isolate) ? 1f : 0f);
				_compositeMaterial.SetFloat(MaxLayersId, _settings.maxVisualizedLayers);
				RenderingUtils.DrawProcedural(commandBuffer, _depthCopyMaterial, 2, new Vector4(1f, 1f, 0f, 0f));
				commandBuffer.SetViewProjectionMatrices(renderingData.cameraData.GetViewMatrix(), renderingData.cameraData.GetProjectionMatrix());
				context.ExecuteCommandBuffer(commandBuffer);
				commandBuffer.Clear();
				if (_settings.includeTransparent)
				{
					DrawGeometryRange(context, ref renderingData);
				}
				CoreUtils.SetRenderTarget(commandBuffer, renderTargetIdentifier3, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store, new RenderTargetIdentifier(ParticleDepthTextureId), RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, ClearFlag.Color, Color.clear);
				commandBuffer.SetViewport(new Rect(0f, 0f, desc.width, desc.height));
				if (_settings.includeTransparent)
				{
					DrawCullAwareGeometry(commandBuffer, camera);
				}
				CoreUtils.SetRenderTarget(commandBuffer, colorBuffer, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store, new RenderTargetIdentifier(ParticleDepthTextureId), RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, ClearFlag.Color, Color.clear);
				commandBuffer.SetViewport(new Rect(0f, 0f, desc.width, desc.height));
				float num = (renderingData.cameraData.isCameraProjectionMatrixFlipped ? (-1f) : 1f);
				commandBuffer.SetGlobalVector(ScaleBiasRtId, (num < 0f) ? new Vector4(num, 1f, -1f, 1f) : new Vector4(num, 0f, 1f, 1f));
				if (_settings.includeTransparent)
				{
					DrawParticleGeometry(commandBuffer, camera);
				}
				if (_requestParticleReadback)
				{
					_requestParticleReadback = false;
					commandBuffer.RequestAsyncReadback(_particleCountTexture, 0, GraphicsFormat.R32_SFloat, OnParticleCountReadback);
				}
				commandBuffer.SetGlobalTexture(OverdrawStencilTextureId, renderTargetIdentifier2, RenderTextureSubElement.Stencil);
				commandBuffer.SetGlobalTexture(ParticleCountTextureId, _particleCountTexture);
				commandBuffer.SetGlobalTexture(GeometryCountTextureId, renderTargetIdentifier3);
				CoreUtils.SetRenderTarget(commandBuffer, renderTargetIdentifier, ClearFlag.None, Color.clear);
				commandBuffer.SetViewport(new Rect(0f, 0f, cameraTargetDescriptor.width, cameraTargetDescriptor.height));
				RenderingUtils.DrawProcedural(commandBuffer, _depthCopyMaterial, 3, new Vector4(1f, 1f, 0f, 0f));
				ScriptableRenderer renderer = renderingData.cameraData.renderer;
				commandBuffer.SetGlobalTexture(OverdrawTextureId, renderTargetIdentifier);
				CoreUtils.SetRenderTarget(commandBuffer, renderer.cameraColorTarget, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, renderer.cameraDepthTarget, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, (_settings.displayMode == DisplayMode.Isolate) ? ClearFlag.Color : ClearFlag.None, Color.black);
				RenderingUtils.DrawProcedural(commandBuffer, _compositeMaterial, 0, new Vector4(1f, 1f, 0f, 0f));
				commandBuffer.SetViewProjectionMatrices(renderingData.cameraData.GetViewMatrix(), renderingData.cameraData.GetProjectionMatrix());
				commandBuffer.ReleaseTemporaryRT(OverdrawTextureId);
				commandBuffer.ReleaseTemporaryRT(OverdrawRasterDepthId);
				commandBuffer.ReleaseTemporaryRT(GeometryCountTextureId);
				commandBuffer.ReleaseTemporaryRT(ParticleDepthTextureId);
				commandBuffer.ReleaseTemporaryRT(OverdrawDepthTextureId);
			}
			context.ExecuteCommandBuffer(commandBuffer);
			CommandBufferPool.Release(commandBuffer);
		}

		private static GraphicsFormat ResolveOverdrawFormat()
		{
			if (s_OverdrawFormat != GraphicsFormat.None)
			{
				return s_OverdrawFormat;
			}
			s_OverdrawFormat = (SystemInfo.IsFormatSupported(GraphicsFormat.R16_SFloat, FormatUsage.Render) ? GraphicsFormat.R16_SFloat : GraphicsFormat.R8_UNorm);
			return s_OverdrawFormat;
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

		private void EnsureParticleCountTexture(RenderTextureDescriptor desc)
		{
			if (!(_particleCountTexture != null) || _particleCountTexture.width != desc.width || _particleCountTexture.height != desc.height || _particleCountTexture.graphicsFormat != desc.graphicsFormat)
			{
				CoreUtils.Destroy(_particleCountTexture);
				_particleCountTexture = new RenderTexture(desc)
				{
					name = "Game View Overdraw Particle Count",
					filterMode = FilterMode.Bilinear,
					wrapMode = TextureWrapMode.Clamp,
					hideFlags = HideFlags.HideAndDontSave
				};
				_particleCountTexture.Create();
			}
		}

		private void DrawGeometryRange(ScriptableRenderContext context, ref RenderingData renderingData)
		{
			DrawingSettings drawingSettings = CreateDrawingSettings(ShaderTagIds, ref renderingData, SortingCriteria.CommonTransparent);
			FilteringSettings filteringSettings = new FilteringSettings(RenderQueueRange.transparent, _settings.layerMask);
			context.DrawRenderers(renderingData.cullResults, ref drawingSettings, ref filteringSettings, ref _transparentCountState);
		}

		private void DrawCullAwareGeometry(CommandBuffer cmd, Camera camera)
		{
			GeometryUtility.CalculateFrustumPlanes(camera, _frustumPlanes);
			Renderer[] array = UnityEngine.Object.FindObjectsOfType<Renderer>();
			foreach (Renderer renderer in array)
			{
				if (renderer is ParticleSystemRenderer || !ShouldDrawRenderer(renderer, camera))
				{
					continue;
				}
				_sharedMaterials.Clear();
				renderer.GetSharedMaterials(_sharedMaterials);
				for (int j = 0; j < _sharedMaterials.Count; j++)
				{
					Material material = _sharedMaterials[j];
					if (!(material == null) && material.renderQueue >= RenderQueueRange.transparent.lowerBound && material.renderQueue <= RenderQueueRange.transparent.upperBound)
					{
						cmd.DrawRenderer(renderer, GetCountMaterial(ResolveCullMode(material)), j, 0);
					}
				}
			}
		}

		private bool ShouldDrawRenderer(Renderer renderer, Camera camera)
		{
			if (renderer == null || !renderer.enabled || renderer.forceRenderingOff || !renderer.gameObject.activeInHierarchy || !renderer.gameObject.scene.IsValid())
			{
				return false;
			}
			int num = 1 << renderer.gameObject.layer;
			if ((_settings.layerMask.value & num) != 0 && (camera.cullingMask & num) != 0)
			{
				return GeometryUtility.TestPlanesAABB(_frustumPlanes, renderer.bounds);
			}
			return false;
		}

		private Material GetCountMaterial(CullMode cullMode)
		{
			return cullMode switch
			{
				CullMode.Off => _countMaterial, 
				CullMode.Front => _countFrontMaterial, 
				_ => _countBackMaterial, 
			};
		}

		private CullMode ResolveCullMode(Material material)
		{
			if (material.HasProperty("_Cull"))
			{
				return SanitizeCullMode(material.GetInt("_Cull"));
			}
			if (material.HasProperty("_CullMode"))
			{
				return SanitizeCullMode(material.GetInt("_CullMode"));
			}
			if (material.HasProperty("_CullModeForward"))
			{
				return SanitizeCullMode(material.GetInt("_CullModeForward"));
			}
			return CullMode.Back;
		}

		private static CullMode SanitizeCullMode(int value)
		{
			if (value != 0 && value != 1 && value != 2)
			{
				return CullMode.Back;
			}
			return (CullMode)value;
		}

		private void DrawParticleGeometry(CommandBuffer cmd, Camera camera)
		{
			GeometryUtility.CalculateFrustumPlanes(camera, _frustumPlanes);
			ParticleSystemRenderer[] array = UnityEngine.Object.FindObjectsOfType<ParticleSystemRenderer>();
			int num = 0;
			int num2 = 0;
			int num3 = 0;
			bool flag = _settings.logParticleDiagnostics && Time.frameCount - _lastParticleDiagnosticFrame >= 120;
			bool flag2 = false;
			foreach (ParticleSystemRenderer particleSystemRenderer in array)
			{
				if (!ShouldDrawParticleRenderer(particleSystemRenderer, camera))
				{
					continue;
				}
				num++;
				if (!_particleMeshes.TryGetValue(particleSystemRenderer, out var value) || value == null)
				{
					value = new Mesh
					{
						name = $"GameViewOverdraw_{particleSystemRenderer.GetInstanceID()}",
						hideFlags = HideFlags.HideAndDontSave
					};
					_particleMeshes[particleSystemRenderer] = value;
				}
				particleSystemRenderer.BakeMesh(value, camera);
				if (value.vertexCount > 0)
				{
					num2++;
					num3 += value.vertexCount;
					Matrix4x4 matrix = ResolveParticleDrawMatrix(particleSystemRenderer, value, out var matrixMode);
					cmd.DrawMesh(value, matrix, _countMaterial, 0, 0);
					if (flag && !flag2 && particleSystemRenderer.name.IndexOf("Fire", StringComparison.OrdinalIgnoreCase) >= 0)
					{
						flag2 = true;
						ParticleSystem component = particleSystemRenderer.GetComponent<ParticleSystem>();
						Vector3 position = matrix.MultiplyPoint3x4(value.bounds.center);
						Vector3 vector = camera.WorldToViewportPoint(position);
						Vector3 vector2 = camera.WorldToViewportPoint(particleSystemRenderer.bounds.center);
						Debug.Log("[Game View Overdraw] Particle mesh probe: name=" + particleSystemRenderer.name + ", " + $"simulationSpace={component.main.simulationSpace}, matrix={matrixMode}, " + $"vertices={value.vertexCount}, meshBounds={value.bounds}, " + $"bakedViewportCenter={vector}, " + $"rendererViewportCenter={vector2}.");
					}
				}
			}
			if (flag)
			{
				_lastParticleDiagnosticFrame = Time.frameCount;
				_requestParticleReadback = true;
				Debug.Log($"[Game View Overdraw] Particle fallback: found={array.Length}, " + $"candidates={num}, baked={num2}, vertices={num3}.");
			}
		}

		private static Matrix4x4 ResolveParticleDrawMatrix(ParticleSystemRenderer renderer, Mesh mesh, out string matrixMode)
		{
			Vector3 center = mesh.bounds.center;
			Vector3 center2 = renderer.bounds.center;
			Matrix4x4 result = Matrix4x4.identity;
			matrixMode = "World/Identity";
			float num = (center - center2).sqrMagnitude;
			Matrix4x4 localToWorldMatrix = renderer.localToWorldMatrix;
			float sqrMagnitude = (localToWorldMatrix.MultiplyPoint3x4(center) - center2).sqrMagnitude;
			if (sqrMagnitude < num)
			{
				num = sqrMagnitude;
				result = localToWorldMatrix;
				matrixMode = "Local/Renderer";
			}
			Transform customSimulationSpace = renderer.GetComponent<ParticleSystem>().main.customSimulationSpace;
			if (customSimulationSpace != null)
			{
				Matrix4x4 localToWorldMatrix2 = customSimulationSpace.localToWorldMatrix;
				if ((localToWorldMatrix2.MultiplyPoint3x4(center) - center2).sqrMagnitude < num)
				{
					result = localToWorldMatrix2;
					matrixMode = "Custom";
				}
			}
			return result;
		}

		private static void OnParticleCountReadback(AsyncGPUReadbackRequest request)
		{
			if (request.hasError)
			{
				Debug.LogWarning("[Game View Overdraw] Particle RT readback: GPU readback failed.");
				return;
			}
			NativeArray<float> data = request.GetData<float>();
			int num = 0;
			float num2 = 0f;
			for (int i = 0; i < data.Length; i++)
			{
				float num3 = data[i];
				if (!(num3 <= 1E-05f))
				{
					num++;
					num2 = Mathf.Max(num2, num3);
				}
			}
			Debug.Log($"[Game View Overdraw] Particle RT readback: pixels={data.Length}, " + $"nonZeroPixels={num}, maxValue={num2:F5}.");
		}

		private bool ShouldDrawParticleRenderer(ParticleSystemRenderer renderer, Camera camera)
		{
			if (renderer == null || !renderer.enabled || renderer.forceRenderingOff || !renderer.gameObject.activeInHierarchy || !renderer.gameObject.scene.IsValid())
			{
				return false;
			}
			int num = 1 << renderer.gameObject.layer;
			if ((_settings.layerMask.value & num) == 0 || (camera.cullingMask & num) == 0)
			{
				return false;
			}
			Material sharedMaterial = renderer.sharedMaterial;
			if (sharedMaterial != null && sharedMaterial.renderQueue >= RenderQueueRange.transparent.lowerBound)
			{
				return GeometryUtility.TestPlanesAABB(_frustumPlanes, renderer.bounds);
			}
			return false;
		}

		public void ReleaseResources()
		{
			foreach (Mesh value in _particleMeshes.Values)
			{
				CoreUtils.Destroy(value);
			}
			_particleMeshes.Clear();
			CoreUtils.Destroy(_particleCountTexture);
			_particleCountTexture = null;
		}
	}

	private sealed class DepthCapturePass : ScriptableRenderPass
	{
		private static readonly int CameraDepthAttachmentId = Shader.PropertyToID("_CameraDepthAttachment");

		private static readonly int OverdrawDepthTextureId = Shader.PropertyToID("_GameViewOverdrawDepthTexture");

		private static readonly int ParticleDepthTextureId = Shader.PropertyToID("_GameViewOverdrawParticleDepthTexture");

		private static readonly int ScaleBiasRtId = Shader.PropertyToID("_ScaleBiasRt");

		private static readonly ProfilingSampler DepthCaptureSampler = new ProfilingSampler("Game View Overdraw Depth Capture");

		private static GraphicsFormat s_DepthCopyFormat = GraphicsFormat.None;

		private Material _depthCopyMaterial;

		public DepthCapturePass()
		{
			profilingSampler = DepthCaptureSampler;
			renderPassEvent = RenderPassEvent.RenderObjectsAfterOpaquePass;
			nativeRenderPassType = NativeRenderPassType.None;
			targetCount = 0u;
		}

		public void Setup(Material depthCopyMaterial)
		{
			_depthCopyMaterial = depthCopyMaterial;
		}

		public override void Configure(ref RenderingData renderingData)
		{
			nativeRenderPassType = NativeRenderPassType.None;
			targetCount = 0u;
		}

		public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
		{
			if (!(_depthCopyMaterial == null))
			{
				RenderTextureDescriptor cameraTargetDescriptor = renderingData.cameraData.cameraTargetDescriptor;
				RenderTextureDescriptor desc = cameraTargetDescriptor;
				cameraTargetDescriptor.depthBufferBits = 0;
				cameraTargetDescriptor.depthStencilFormat = GraphicsFormat.None;
				cameraTargetDescriptor.msaaSamples = 1;
				cameraTargetDescriptor.graphicsFormat = ResolveDepthCopyFormat();
				cameraTargetDescriptor.useMipMap = false;
				cameraTargetDescriptor.autoGenerateMips = false;
				cameraTargetDescriptor.enableRandomWrite = false;
				cameraTargetDescriptor.useDynamicScale = false;
				desc.graphicsFormat = GraphicsFormat.None;
				desc.depthBufferBits = 0;
				desc.depthStencilFormat = SystemInfo.GetCompatibleFormat(GraphicsFormat.D32_SFloat, FormatUsage.Render);
				desc.msaaSamples = 1;
				desc.useMipMap = false;
				desc.autoGenerateMips = false;
				desc.enableRandomWrite = false;
				desc.useDynamicScale = false;
				CommandBuffer commandBuffer = CommandBufferPool.Get("Game View Overdraw Depth Capture");
				using (new ProfilingScope(commandBuffer, profilingSampler))
				{
					commandBuffer.GetTemporaryRT(OverdrawDepthTextureId, cameraTargetDescriptor, FilterMode.Point);
					commandBuffer.GetTemporaryRT(ParticleDepthTextureId, desc, FilterMode.Point);
					commandBuffer.SetGlobalTexture(CameraDepthAttachmentId, renderingData.cameraData.renderer.cameraDepthTarget);
					CoreUtils.SetRenderTarget(commandBuffer, new RenderTargetIdentifier(OverdrawDepthTextureId), ClearFlag.Color, SystemInfo.usesReversedZBuffer ? Color.black : Color.white);
					commandBuffer.SetViewport(new Rect(0f, 0f, cameraTargetDescriptor.width, cameraTargetDescriptor.height));
					float num = (renderingData.cameraData.isCameraProjectionMatrixFlipped ? (-1f) : 1f);
					Vector4 value = ((num < 0f) ? new Vector4(num, 1f, -1f, 1f) : new Vector4(num, 0f, 1f, 1f));
					commandBuffer.SetGlobalVector(ScaleBiasRtId, value);
					commandBuffer.DrawMesh(RenderingUtils.fullscreenMesh, Matrix4x4.identity, _depthCopyMaterial, 0, 0);
					CoreUtils.SetRenderTarget(commandBuffer, new RenderTargetIdentifier(ParticleDepthTextureId), ClearFlag.DepthStencil, Color.clear);
					commandBuffer.SetViewport(new Rect(0f, 0f, desc.width, desc.height));
					commandBuffer.DrawMesh(RenderingUtils.fullscreenMesh, Matrix4x4.identity, _depthCopyMaterial, 0, 1);
				}
				context.ExecuteCommandBuffer(commandBuffer);
				CommandBufferPool.Release(commandBuffer);
			}
		}

		private static GraphicsFormat ResolveDepthCopyFormat()
		{
			if (s_DepthCopyFormat != GraphicsFormat.None)
			{
				return s_DepthCopyFormat;
			}
			s_DepthCopyFormat = (SystemInfo.IsFormatSupported(GraphicsFormat.R32_SFloat, FormatUsage.Render) ? GraphicsFormat.R32_SFloat : GraphicsFormat.R16_SFloat);
			return s_DepthCopyFormat;
		}
	}

	[SerializeField]
	public Settings settings = new Settings();

	private const string CountShaderName = "Hidden/URPGameViewOverdraw/Count";

	private const string DepthCopyShaderName = "Hidden/URPGameViewOverdraw/DepthCopy";

	private const string CompositeShaderName = "Hidden/URPGameViewOverdraw/Composite";

	private const string UrpDepthCopyShaderName = "Hidden/Universal Render Pipeline/CopyDepth";

	private static readonly int OverdrawStepId = Shader.PropertyToID("_GameViewOverdrawStep");

	private static readonly int DepthToleranceId = Shader.PropertyToID("_GameViewOverdrawDepthTolerance");

	private static readonly int OutputSizeId = Shader.PropertyToID("_GameViewOverdrawOutputSize");

	private static readonly int IncludeOpaqueId = Shader.PropertyToID("_GameViewOverdrawIncludeOpaque");

	private static readonly int HeatIntensityId = Shader.PropertyToID("_GameViewOverdrawHeatIntensity");

	private static readonly int OverlayOpacityId = Shader.PropertyToID("_GameViewOverdrawOpacity");

	private static readonly int DisplayModeId = Shader.PropertyToID("_GameViewOverdrawDisplayMode");

	private static readonly int MaxLayersId = Shader.PropertyToID("_GameViewOverdrawMaxLayers");

	private Material _countMaterial;

	private Material _countBackMaterial;

	private Material _countFrontMaterial;

	private Material _depthCopyMaterial;

	private Material _urpDepthCopyMaterial;

	private Material _compositeMaterial;

	private DepthCapturePass _depthCapturePass;

	private OverdrawPass _pass;

	public override void Create()
	{
	}

	public override void AddRenderPasses(ScriptableRenderer renderer, ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		if (!ShouldRender(ref renderingData))
		{
			return;
		}
		EnsureMaterials();
		if (!(_countMaterial == null) && !(_countBackMaterial == null) && !(_countFrontMaterial == null) && !(_depthCopyMaterial == null) && !(_urpDepthCopyMaterial == null) && !(_compositeMaterial == null))
		{
			if (renderer is UniversalRenderer universalRenderer)
			{
				universalRenderer.CurrentFrameNeedTemporalDepth = true;
			}
			if (_pass == null)
			{
				_pass = new OverdrawPass();
			}
			if (_depthCapturePass == null)
			{
				_depthCapturePass = new DepthCapturePass();
			}
			_depthCapturePass.Setup(_urpDepthCopyMaterial);
			_pass.renderPassEvent = settings.injectionPoint;
			_pass.Setup(settings, _countMaterial, _countBackMaterial, _countFrontMaterial, _depthCopyMaterial, _compositeMaterial);
			renderer.EnqueuePass(_depthCapturePass);
			renderer.EnqueuePass(_pass);
		}
	}

	protected override void Dispose(bool disposing)
	{
		_pass?.ReleaseResources();
		CoreUtils.Destroy(_countMaterial);
		CoreUtils.Destroy(_countBackMaterial);
		CoreUtils.Destroy(_countFrontMaterial);
		CoreUtils.Destroy(_depthCopyMaterial);
		CoreUtils.Destroy(_urpDepthCopyMaterial);
		CoreUtils.Destroy(_compositeMaterial);
		_countMaterial = null;
		_countBackMaterial = null;
		_countFrontMaterial = null;
		_depthCopyMaterial = null;
		_urpDepthCopyMaterial = null;
		_compositeMaterial = null;
		_pass = null;
	}

	private void EnsureMaterials()
	{
		if (_countMaterial == null)
		{
			_countMaterial = CoreUtils.CreateEngineMaterial("Hidden/URPGameViewOverdraw/Count");
			if (_countMaterial != null)
			{
				_countMaterial.SetInt("_GameViewOverdrawCull", 0);
			}
		}
		if (_countBackMaterial == null)
		{
			_countBackMaterial = CoreUtils.CreateEngineMaterial("Hidden/URPGameViewOverdraw/Count");
			if (_countBackMaterial != null)
			{
				_countBackMaterial.SetInt("_GameViewOverdrawCull", 2);
			}
		}
		if (_countFrontMaterial == null)
		{
			_countFrontMaterial = CoreUtils.CreateEngineMaterial("Hidden/URPGameViewOverdraw/Count");
			if (_countFrontMaterial != null)
			{
				_countFrontMaterial.SetInt("_GameViewOverdrawCull", 1);
			}
		}
		if (_depthCopyMaterial == null)
		{
			_depthCopyMaterial = CoreUtils.CreateEngineMaterial("Hidden/URPGameViewOverdraw/DepthCopy");
		}
		if (_urpDepthCopyMaterial == null)
		{
			_urpDepthCopyMaterial = CoreUtils.CreateEngineMaterial("Hidden/Universal Render Pipeline/CopyDepth");
		}
		if (_compositeMaterial == null)
		{
			_compositeMaterial = CoreUtils.CreateEngineMaterial("Hidden/URPGameViewOverdraw/Composite");
		}
	}

	private bool ShouldRender(ref RenderingData renderingData)
	{
		return false;
	}
}
