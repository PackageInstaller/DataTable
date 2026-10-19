using System;
using System.Collections.Generic;
using System.Diagnostics;

namespace UnityEngine.Rendering.Universal;

public abstract class ScriptableRenderer : IDisposable
{
	private static class Profiling
	{
		public static class RenderBlock
		{
			private const string k_Name = "RenderPassBlock";

			public static readonly ProfilingSampler beforeRendering = new ProfilingSampler("BeforeRender");

			public static readonly ProfilingSampler mainRenderingOpaque = new ProfilingSampler("RenderOpaque");

			public static readonly ProfilingSampler mainRenderingTransparent = new ProfilingSampler("RenderTransparent");

			public static readonly ProfilingSampler afterRendering = new ProfilingSampler("AfterRender");
		}

		public static class RenderPass
		{
			private const string k_Name = "ScriptableRenderPass";

			public static readonly ProfilingSampler configure = new ProfilingSampler("ScriptableRenderPass.Configure");

			public static readonly ProfilingSampler setRT = new ProfilingSampler("ScriptableRenderPass.SetRenderPassAttachments");
		}

		private const string k_Name = "ScriptableRenderer";

		public static readonly ProfilingSampler setPerCameraShaderVariables = new ProfilingSampler("ScriptableRenderer.SetPerCameraShaderVariables");

		public static readonly ProfilingSampler sortRenderPasses = new ProfilingSampler("Sort Render Passes");

		public static readonly ProfilingSampler setupLights = new ProfilingSampler("ScriptableRenderer.SetupLights");

		public static readonly ProfilingSampler setupCamera = new ProfilingSampler("Setup Camera");

		public static readonly ProfilingSampler addFeaturePasses = new ProfilingSampler("ScriptableRenderer.AddFeaturePasses");

		public static readonly ProfilingSampler internalStartRendering = new ProfilingSampler("ScriptableRenderer.InternalStartRendering");

		public static readonly ProfilingSampler internalFinishRendering = new ProfilingSampler("ScriptableRenderer.InternalFinishRendering");

		public static readonly ProfilingSampler drawGizmos = new ProfilingSampler("DrawGizmos");
	}

	private static class RenderPassBlock
	{
		public const int BeforeRender = 0;

		public const int RenderOpaque = 1;

		public const int RenderTransparent = 2;

		public const int AfterRender = 3;
	}

	internal struct RenderBlocks : IDisposable
	{
		public struct BlockRange : IDisposable
		{
			private int m_Current;

			private int m_End;

			public int Current => m_Current;

			public BlockRange(int begin, int end)
			{
				m_Current = ((begin < end) ? begin : end);
				m_End = ((end >= begin) ? end : begin);
				m_Current--;
			}

			public BlockRange GetEnumerator()
			{
				return this;
			}

			public bool MoveNext()
			{
				return ++m_Current < m_End;
			}

			public void Dispose()
			{
			}
		}

		private int m_BeforeRenderEnd;

		private int m_RenderOpaqueEnd;

		private int m_RenderTransparentEnd;

		private int m_AfterRenderEnd;

		public RenderBlocks(List<ScriptableRenderPass> activeRenderPassQueue)
		{
			int currRenderPass = 0;
			m_BeforeRenderEnd = FindBlockEnd(activeRenderPassQueue, RenderPassEvent.RenderBlockBeforeRenderEnd, ref currRenderPass);
			m_RenderOpaqueEnd = FindBlockEnd(activeRenderPassQueue, RenderPassEvent.RenderBlockOpaqueEnd, ref currRenderPass);
			m_RenderTransparentEnd = FindBlockEnd(activeRenderPassQueue, RenderPassEvent.RenderBlockTransparentEnd, ref currRenderPass);
			m_AfterRenderEnd = activeRenderPassQueue.Count;
		}

		public void Dispose()
		{
		}

		private static int FindBlockEnd(List<ScriptableRenderPass> activeRenderPassQueue, RenderPassEvent blockEventLimit, ref int currRenderPass)
		{
			while (currRenderPass < activeRenderPassQueue.Count && activeRenderPassQueue[currRenderPass].renderPassEvent < blockEventLimit)
			{
				currRenderPass++;
			}
			return currRenderPass;
		}

		public int GetLength(int index)
		{
			return index switch
			{
				0 => m_BeforeRenderEnd, 
				1 => m_RenderOpaqueEnd - m_BeforeRenderEnd, 
				2 => m_RenderTransparentEnd - m_RenderOpaqueEnd, 
				3 => m_AfterRenderEnd - m_RenderTransparentEnd, 
				_ => 0, 
			};
		}

		public BlockRange GetRange(int index)
		{
			return index switch
			{
				0 => new BlockRange(0, m_BeforeRenderEnd), 
				1 => new BlockRange(m_BeforeRenderEnd, m_RenderOpaqueEnd), 
				2 => new BlockRange(m_RenderOpaqueEnd, m_RenderTransparentEnd), 
				3 => new BlockRange(m_RenderTransparentEnd, m_AfterRenderEnd), 
				_ => new BlockRange(0, 0), 
			};
		}
	}

	internal static ScriptableRenderer current = null;

	protected ClearFlag cameraClearFlag;

	private StoreActionsOptimization m_StoreActionsOptimizationSetting;

	private static bool m_UseOptimizedStoreActions = true;

	protected List<ScriptableRenderPass> m_ActiveRenderPassQueue = new List<ScriptableRenderPass>(32);

	private List<ScriptableRendererFeature> m_RendererFeatures = new List<ScriptableRendererFeature>(10);

	private bool m_FirstTimeCameraColorTargetIsBound = true;

	private bool m_FirstTimeCameraDepthTargetIsBound = true;

	protected static RenderTargetIdentifier s_ActiveColorAttachment;

	protected static RenderTargetIdentifier s_ActiveDepthAttachment;

	protected RenderTargetIdentifier m_CameraColorTarget;

	protected RenderTargetIdentifier m_CameraDepthTarget;

	private static RenderTargetIdentifier[][] m_TrimmedColorAttachmentCopies = new RenderTargetIdentifier[9][]
	{
		new RenderTargetIdentifier[0],
		new RenderTargetIdentifier[1] { 0 },
		new RenderTargetIdentifier[2] { 0, 0 },
		new RenderTargetIdentifier[3] { 0, 0, 0 },
		new RenderTargetIdentifier[4] { 0, 0, 0, 0 },
		new RenderTargetIdentifier[5] { 0, 0, 0, 0, 0 },
		new RenderTargetIdentifier[6] { 0, 0, 0, 0, 0, 0 },
		new RenderTargetIdentifier[7] { 0, 0, 0, 0, 0, 0, 0 },
		new RenderTargetIdentifier[8] { 0, 0, 0, 0, 0, 0, 0, 0 }
	};

	private static Plane[] s_Planes = new Plane[6];

	private static Vector4[] s_VectorPlanes = new Vector4[6];

	public static RenderBufferLoadAction s_DepthLoadAction;

	public static RenderBufferStoreAction s_DepthStoreAction;

	protected ProfilingSampler profilingExecute { get; set; }

	public RenderTargetIdentifier cameraColorTarget => m_CameraColorTarget;

	public RenderTargetIdentifier cameraDepthTarget => m_CameraDepthTarget;

	public List<ScriptableRendererFeature> rendererFeatures => m_RendererFeatures;

	internal ScriptableRendererData rendererData { get; }

	protected List<ScriptableRenderPass> activeRenderPassQueue => m_ActiveRenderPassQueue;

	public GraphicsDeviceType[] unsupportedGraphicsDeviceTypes { get; set; } = new GraphicsDeviceType[0];

	public virtual int SupportedCameraStackingTypes()
	{
		return 0;
	}

	public bool SupportsCameraStackingType(CameraRenderType cameraRenderType)
	{
		return (SupportedCameraStackingTypes() & (1 << (int)cameraRenderType)) != 0;
	}

	public static void SetCameraMatrices(CommandBuffer cmd, ref CameraData cameraData, bool setInverseMatrices)
	{
		Matrix4x4 viewMatrix = cameraData.GetViewMatrix();
		Matrix4x4 projectionMatrix = cameraData.GetProjectionMatrix();
		cmd.SetViewProjectionMatrices(viewMatrix, projectionMatrix);
		if (setInverseMatrices)
		{
			Matrix4x4 gPUProjectionMatrix = cameraData.GetGPUProjectionMatrix();
			Matrix4x4 matrix4x = Matrix4x4.Inverse(viewMatrix);
			Matrix4x4 matrix4x2 = Matrix4x4.Inverse(gPUProjectionMatrix);
			Matrix4x4 value = matrix4x * matrix4x2;
			Matrix4x4 value2 = Matrix4x4.Scale(new Vector3(1f, 1f, -1f)) * viewMatrix;
			Matrix4x4 inverse = value2.inverse;
			cmd.SetGlobalMatrix(ShaderPropertyId.worldToCameraMatrix, value2);
			cmd.SetGlobalMatrix(ShaderPropertyId.cameraToWorldMatrix, inverse);
			cmd.SetGlobalMatrix(ShaderPropertyId.inverseViewMatrix, matrix4x);
			cmd.SetGlobalMatrix(ShaderPropertyId.inverseProjectionMatrix, matrix4x2);
			cmd.SetGlobalMatrix(ShaderPropertyId.inverseViewAndProjectionMatrix, value);
		}
	}

	private void SetPerCameraShaderVariables(CommandBuffer cmd, ref CameraData cameraData)
	{
		using (new ProfilingScope(null, Profiling.setPerCameraShaderVariables))
		{
			Camera camera = cameraData.camera;
			Rect pixelRect = cameraData.pixelRect;
			float num = (cameraData.isSceneViewCamera ? 1f : cameraData.renderScale);
			float num2 = (cameraData.temporalUpscalerActive ? ((float)cameraData.cameraTargetDescriptor.width) : (pixelRect.width * num));
			float num3 = (cameraData.temporalUpscalerActive ? ((float)cameraData.cameraTargetDescriptor.height) : (pixelRect.height * num));
			float num4 = pixelRect.width;
			float num5 = pixelRect.height;
			float nearClipPlane = camera.nearClipPlane;
			float farClipPlane = camera.farClipPlane;
			float num6 = (Mathf.Approximately(nearClipPlane, 0f) ? 0f : (1f / nearClipPlane));
			float num7 = (Mathf.Approximately(farClipPlane, 0f) ? 0f : (1f / farClipPlane));
			float num8 = 1f - farClipPlane * num6;
			float num9 = farClipPlane * num6;
			Vector4 value = new Vector4(num8, num9, num8 * num7, num9 * num7);
			if (RenderingUtils.UsesReversedZBuffer)
			{
				value.y += value.x;
				value.x = 0f - value.x;
				value.w += value.z;
				value.z = 0f - value.z;
			}
			float x = (cameraData.isCameraProjectionMatrixFlipped ? (-1f) : 1f);
			Vector4 value2 = new Vector4(x, nearClipPlane, farClipPlane, 1f * num7);
			cmd.SetGlobalVector(ShaderPropertyId.projectionParams, value2);
			float w = (camera.orthographic ? 1f : 0f);
			Vector4 value3 = new Vector4(camera.orthographicSize * cameraData.aspectRatio, camera.orthographicSize, 0f, w);
			cmd.SetGlobalVector(ShaderPropertyId.screenParams, new Vector4(num4, num5, 1f + 1f / num4, 1f + 1f / num5));
			cmd.SetGlobalVector(ShaderPropertyId.scaledScreenParams, new Vector4(num2, num3, 1f + 1f / num2, 1f + 1f / num3));
			cmd.SetGlobalVector(ShaderPropertyId.zBufferParams, value);
			cmd.SetGlobalVector(ShaderPropertyId.orthoParams, value3);
			cmd.SetGlobalVector(ShaderPropertyId.screenSize, new Vector4(num2, num3, 1f / num2, 1f / num3));
			float num10 = 0f;
			float y = 1f;
			if (num != 1f)
			{
				num10 = Math.Min((float)(0.0 - Math.Log(num4 / num2, 2.0)), 0f);
				y = Mathf.Pow(2f, num10);
			}
			cmd.SetGlobalVector(ShaderPropertyId.globalMipBias, new Vector2(num10, y));
			cmd.SetGlobalVector(ShaderPropertyId.worldSpaceCameraPos, cameraData.worldSpaceCameraPos);
			SetCameraMatrices(cmd, ref cameraData, cameraData.isBase);
		}
	}

	private static void CalculateBillboardProperties(in Matrix4x4 worldToCameraMatrix, out Vector3 billboardTangent, out Vector3 billboardNormal, out float cameraXZAngle)
	{
		Matrix4x4 transpose = worldToCameraMatrix.transpose;
		Vector3 vector = new Vector3(transpose.m00, transpose.m10, transpose.m20);
		Vector3 vector2 = new Vector3(transpose.m01, transpose.m11, transpose.m21);
		Vector3 lhs = new Vector3(transpose.m02, transpose.m12, transpose.m22);
		Vector3 up = Vector3.up;
		Vector3 vector3 = Vector3.Cross(lhs, up);
		billboardTangent = ((!Mathf.Approximately(vector3.sqrMagnitude, 0f)) ? vector3.normalized : vector);
		billboardNormal = Vector3.Cross(up, billboardTangent);
		billboardNormal = ((!Mathf.Approximately(billboardNormal.sqrMagnitude, 0f)) ? billboardNormal.normalized : vector2);
		Vector3 vector4 = new Vector3(0f, 0f, 1f);
		float y = vector4.x * billboardTangent.z - vector4.z * billboardTangent.x;
		float x = vector4.x * billboardTangent.x + vector4.z * billboardTangent.z;
		cameraXZAngle = Mathf.Atan2(y, x);
		if (cameraXZAngle < 0f)
		{
			cameraXZAngle += MathF.PI * 2f;
		}
	}

	private void SetPerCameraClippingPlaneProperties(CommandBuffer cmd, in CameraData cameraData)
	{
		Matrix4x4 gPUProjectionMatrix = cameraData.GetGPUProjectionMatrix();
		Matrix4x4 worldToCameraMatrix = cameraData.GetViewMatrix();
		Matrix4x4 worldToProjectionMatrix = CoreMatrixUtils.MultiplyProjectionMatrix(gPUProjectionMatrix, worldToCameraMatrix, cameraData.camera.orthographic);
		Plane[] array = s_Planes;
		GeometryUtility.CalculateFrustumPlanes(worldToProjectionMatrix, array);
		Vector4[] array2 = s_VectorPlanes;
		for (int i = 0; i < array.Length; i++)
		{
			array2[i] = new Vector4(array[i].normal.x, array[i].normal.y, array[i].normal.z, array[i].distance);
		}
		cmd.SetGlobalVectorArray(ShaderPropertyId.cameraWorldClipPlanes, array2);
		Vector3 worldSpaceCameraPos = cameraData.worldSpaceCameraPos;
		CalculateBillboardProperties(in worldToCameraMatrix, out var billboardTangent, out var billboardNormal, out var cameraXZAngle);
		cmd.SetGlobalVector(ShaderPropertyId.billboardNormal, new Vector4(billboardNormal.x, billboardNormal.y, billboardNormal.z, 0f));
		cmd.SetGlobalVector(ShaderPropertyId.billboardTangent, new Vector4(billboardTangent.x, billboardTangent.y, billboardTangent.z, 0f));
		cmd.SetGlobalVector(ShaderPropertyId.billboardCameraParams, new Vector4(worldSpaceCameraPos.x, worldSpaceCameraPos.y, worldSpaceCameraPos.z, cameraXZAngle));
	}

	public void SetShaderTimeValues(CommandBuffer cmd)
	{
		float time = Time.time;
		float deltaTime = Time.deltaTime;
		float smoothDeltaTime = Time.smoothDeltaTime;
		float f = time / 8f;
		float f2 = time / 4f;
		float f3 = time / 2f;
		float num = Mathf.Sin(time);
		float num2 = Mathf.Cos(time);
		Vector4 value = time * new Vector4(0.05f, 1f, 2f, 3f);
		Vector4 value2 = new Vector4(Mathf.Sin(f), Mathf.Sin(f2), Mathf.Sin(f3), num);
		Vector4 value3 = new Vector4(Mathf.Cos(f), Mathf.Cos(f2), Mathf.Cos(f3), num2);
		Vector4 value4 = new Vector4(deltaTime, 1f / deltaTime, smoothDeltaTime, 1f / smoothDeltaTime);
		Vector4 value5 = new Vector4(time, num, num2, 0f);
		cmd.SetGlobalVector(ShaderPropertyId.time, value);
		cmd.SetGlobalVector(ShaderPropertyId.sinTime, value2);
		cmd.SetGlobalVector(ShaderPropertyId.cosTime, value3);
		cmd.SetGlobalVector(ShaderPropertyId.deltaTime, value4);
		cmd.SetGlobalVector(ShaderPropertyId.timeParameters, value5);
	}

	internal virtual RenderTargetIdentifier GetCameraColorFrontBuffer(CommandBuffer cmd)
	{
		return default;
	}

	internal virtual RTHandle GetCameraColorBackBufferHandle()
	{
		return null;
	}

	public ScriptableRenderer(ScriptableRendererData data)
	{
		rendererData = data;
		profilingExecute = new ProfilingSampler("ScriptableRenderer.Execute: " + data.name);
		foreach (ScriptableRendererFeature rendererFeature in data.rendererFeatures)
		{
			if (!(rendererFeature == null))
			{
				rendererFeature.Create();
				m_RendererFeatures.Add(rendererFeature);
			}
		}
		Clear(CameraRenderType.Base);
		m_ActiveRenderPassQueue.Clear();
		if ((bool)UniversalRenderPipeline.asset)
		{
			m_StoreActionsOptimizationSetting = UniversalRenderPipeline.asset.storeActionsOptimization;
		}
		m_UseOptimizedStoreActions = m_StoreActionsOptimizationSetting != StoreActionsOptimization.Store;
	}

	public void Dispose()
	{
		for (int i = 0; i < m_RendererFeatures.Count; i++)
		{
			if (!(rendererFeatures[i] == null))
			{
				rendererFeatures[i].Dispose();
			}
		}
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	protected virtual void Dispose(bool disposing)
	{
	}

	public void ConfigureCameraTarget(RenderTargetIdentifier colorTarget, RenderTargetIdentifier depthTarget)
	{
		m_CameraColorTarget = colorTarget;
		m_CameraDepthTarget = depthTarget;
	}

	internal void ConfigureCameraColorTarget(RenderTargetIdentifier colorTarget)
	{
		m_CameraColorTarget = colorTarget;
	}

	public void ConfigureCameraDepthTarget(RenderTargetIdentifier depthTarget)
	{
		m_CameraDepthTarget = depthTarget;
	}

	public void ManualSetColorAttachment(RenderTargetIdentifier colorAttachment)
	{
		m_CameraColorTarget = colorAttachment;
		s_ActiveColorAttachment = colorAttachment;
	}

	public void ManualSetDepthAttachment(RenderTargetIdentifier depthAttachment)
	{
		m_CameraDepthTarget = depthAttachment;
		s_ActiveDepthAttachment = depthAttachment;
	}

	public abstract void Setup(ref ScriptableRenderContext context, ref RenderingData renderingData);

	public virtual void SetupLights(CommandBuffer cmd, ref RenderingData renderingData)
	{
	}

	public virtual void SetupCullingParameters(ref ScriptableCullingParameters cullingParameters, ref CameraData cameraData)
	{
	}

	public virtual void FinishRendering(CommandBuffer cmd)
	{
	}

	public void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
	{
		ref CameraData cameraData = ref renderingData.cameraData;
		Camera camera = cameraData.camera;
		CommandBuffer cmd = renderingData.cmd;
		if (!renderingData.nativeRenderPass && renderingData.nativeRenderPassManager.CurrentPassType != NativeRenderPassType.None)
		{
			renderingData.nativeRenderPassManager.End(ref context, cmd);
		}
		using (new ProfilingScope(cmd, profilingExecute))
		{
			InternalStartRendering(context, ref renderingData);
			using (new ProfilingScope(null, Profiling.sortRenderPasses))
			{
				SortStable(m_ActiveRenderPassQueue);
			}
			using RenderBlocks renderBlocks = new RenderBlocks(m_ActiveRenderPassQueue);
			if (renderBlocks.GetLength(0) > 0)
			{
				ExecuteBlock(0, in renderBlocks, ref context, ref renderingData);
			}
			using (new ProfilingScope(null, Profiling.setupCamera))
			{
				if (cameraData.renderType == CameraRenderType.Base)
				{
					context.SetupCameraProperties(camera);
					SetShaderTimeValues(cmd);
					using (new ProfilingScope(null, Profiling.setupLights))
					{
						SetupLights(cmd, ref renderingData);
					}
				}
				SetPerCameraShaderVariables(cmd, ref cameraData);
			}
			context.ExecuteCommandBuffer(cmd);
			cmd.Clear();
			if (renderBlocks.GetLength(1) > 0)
			{
				ExecuteBlock(1, in renderBlocks, ref context, ref renderingData);
			}
			if (renderBlocks.GetLength(2) > 0)
			{
				ExecuteBlock(2, in renderBlocks, ref context, ref renderingData);
			}
			if (renderBlocks.GetLength(3) > 0)
			{
				ExecuteBlock(3, in renderBlocks, ref context, ref renderingData);
			}
			InternalFinishRendering(cameraData.lastCam, cmd);
		}
		context.ExecuteCommandBuffer(cmd);
		cmd.Clear();
	}

	public void EnqueuePass(ScriptableRenderPass pass)
	{
		m_ActiveRenderPassQueue.Add(pass);
	}

	protected static ClearFlag GetCameraClearFlag(ref CameraData cameraData)
	{
		CameraClearFlags clearFlags = cameraData.camera.clearFlags;
		if (cameraData.renderType == CameraRenderType.Overlay)
		{
			if (!cameraData.clearDepth)
			{
				return ClearFlag.None;
			}
			return ClearFlag.DepthStencil;
		}
		if ((clearFlags == CameraClearFlags.Skybox && RenderSettings.skybox != null) || clearFlags == CameraClearFlags.Nothing)
		{
			return ClearFlag.DepthStencil;
		}
		return ClearFlag.All;
	}

	internal void OnPreCullRenderPasses(in CameraData cameraData)
	{
		for (int i = 0; i < rendererFeatures.Count; i++)
		{
			if (rendererFeatures[i].isActive)
			{
				rendererFeatures[i].OnCameraPreCull(this, in cameraData);
			}
		}
	}

	protected void AddFeaturePasses(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		using (new ProfilingScope(null, Profiling.addFeaturePasses))
		{
			for (int i = 0; i < rendererFeatures.Count; i++)
			{
				if (rendererFeatures[i].isActive)
				{
					rendererFeatures[i].AddRenderPasses(this, ref context, ref renderingData);
				}
			}
		}
	}

	protected void ReconcileFeaturePersistentRenderResources(ref RenderingData renderingData)
	{
		List<ScriptableRendererFeature> list = rendererFeatures;
		CommandBuffer cmd = renderingData.cmd;
		for (int i = 0; i < list.Count; i++)
		{
			ScriptableRendererFeature scriptableRendererFeature = list[i];
			if (scriptableRendererFeature != null)
			{
				scriptableRendererFeature.ReconcilePersistentRenderResources(cmd, ref renderingData);
			}
		}
	}

	internal void Clear(CameraRenderType cameraType)
	{
		if (cameraType == CameraRenderType.Base)
		{
			s_ActiveColorAttachment = BuiltinRenderTextureType.None;
			s_ActiveDepthAttachment = BuiltinRenderTextureType.None;
			m_CameraColorTarget = BuiltinRenderTextureType.CameraTarget;
			m_CameraDepthTarget = BuiltinRenderTextureType.CameraTarget;
		}
		else
		{
			m_CameraColorTarget = s_ActiveColorAttachment;
			m_CameraDepthTarget = s_ActiveDepthAttachment;
		}
		m_FirstTimeCameraColorTargetIsBound = cameraType == CameraRenderType.Base;
		m_FirstTimeCameraDepthTargetIsBound = true;
	}

	private void ExecuteBlock(int blockIndex, in RenderBlocks renderBlocks, ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		foreach (int item in renderBlocks.GetRange(blockIndex))
		{
			ScriptableRenderPass renderPass = m_ActiveRenderPassQueue[item];
			ExecuteRenderPass(ref context, renderPass, ref renderingData);
		}
	}

	private void ExecuteRenderPass(ref ScriptableRenderContext context, ScriptableRenderPass renderPass, ref RenderingData renderingData)
	{
		using (new ProfilingScope(null, renderPass.profilingSampler))
		{
			ref CameraData cameraData = ref renderingData.cameraData;
			renderPass.Configure(ref renderingData);
			if (renderingData.nativeRenderPass)
			{
				if (renderPass.nativeRenderPassType != NativeRenderPassType.None)
				{
					renderingData.nativeRenderPassManager.Begin(renderPass.nativeRenderPassType, ref context, ref renderingData);
					renderPass.BeginSubPass(ref context, ref renderingData);
				}
				else
				{
					renderingData.nativeRenderPassManager.End(ref context, renderingData.cmd);
					SetRenderPassAttachments(ref context, renderPass, ref cameraData, renderingData.cmd, renderingData.preserveDepthStencilForGrabPass);
				}
			}
			else
			{
				SetRenderPassAttachments(ref context, renderPass, ref cameraData, renderingData.cmd, renderingData.preserveDepthStencilForGrabPass);
			}
			renderPass.Execute(ref context, ref renderingData);
			if (renderingData.cmd.sizeInBytes > 0)
			{
				context.ExecuteCommandBuffer(renderingData.cmd);
				renderingData.cmd.Clear();
			}
		}
	}

	private void SetRenderPassAttachments(ref ScriptableRenderContext context, ScriptableRenderPass renderPass, ref CameraData cameraData, CommandBuffer cmd, bool preserveDepthStencil)
	{
		uint targetCount = renderPass.targetCount;
		if (targetCount == 0)
		{
			return;
		}
		Camera camera = cameraData.camera;
		if (targetCount > 1)
		{
			bool flag = false;
			if (RenderingUtils.IndexOf(renderPass.colorAttachments, m_CameraColorTarget) != -1 && m_FirstTimeCameraColorTargetIsBound)
			{
				m_FirstTimeCameraColorTargetIsBound = false;
			}
			RenderTargetIdentifier renderTargetIdentifier = (renderPass.overrideCameraTarget ? renderPass.depthAttachment : m_CameraDepthTarget);
			bool flag2 = ConsumeFirstCameraDepthBinding(renderTargetIdentifier == m_CameraDepthTarget);
			ClearFlag clearFlag = ClearFlag.None;
			clearFlag |= (flag2 ? (cameraClearFlag & ClearFlag.DepthStencil) : (renderPass.clearFlag & ClearFlag.DepthStencil));
			clearFlag |= ((!flag) ? (renderPass.clearFlag & ClearFlag.Color) : ClearFlag.None);
			RenderTargetIdentifier[] array = m_TrimmedColorAttachmentCopies[targetCount];
			for (int i = 0; i < targetCount; i++)
			{
				array[i] = renderPass.colorAttachments[i];
			}
			SetRenderTarget(cmd, array, renderTargetIdentifier, clearFlag, renderPass.clearColor);
			context.ExecuteCommandBuffer(cmd);
			cmd.Clear();
			return;
		}
		RenderTargetIdentifier colorAttachment = renderPass.colorAttachment;
		RenderTargetIdentifier depthAttachment = renderPass.depthAttachment;
		if (!renderPass.overrideCameraTarget)
		{
			colorAttachment = m_CameraColorTarget;
			depthAttachment = m_CameraDepthTarget;
		}
		bool flag3 = depthAttachment == m_CameraDepthTarget || colorAttachment == m_CameraDepthTarget;
		bool flag4 = ConsumeFirstCameraDepthBinding(flag3);
		ClearFlag clearFlag2 = ClearFlag.None;
		Color clearColor;
		if (colorAttachment == m_CameraColorTarget && m_FirstTimeCameraColorTargetIsBound)
		{
			m_FirstTimeCameraColorTargetIsBound = false;
			clearFlag2 |= cameraClearFlag & ClearFlag.Color;
			clearColor = CoreUtils.ConvertSRGBToActiveColorSpace(camera.backgroundColor);
		}
		else
		{
			clearFlag2 |= renderPass.clearFlag & ClearFlag.Color;
			clearColor = renderPass.clearColor;
		}
		clearFlag2 |= (flag4 ? (cameraClearFlag & ClearFlag.DepthStencil) : (renderPass.clearFlag & ClearFlag.DepthStencil));
		if (!(colorAttachment == s_ActiveColorAttachment) || !(depthAttachment == s_ActiveDepthAttachment) || clearFlag2 != ClearFlag.None)
		{
			RenderBufferLoadAction colorLoadAction = renderPass.GetColorLoadAction();
			RenderBufferLoadAction depthLoadAction = renderPass.GetDepthLoadAction();
			if (flag3)
			{
				depthLoadAction = (((clearFlag2 & ClearFlag.DepthStencil) != 0) ? RenderBufferLoadAction.DontCare : RenderBufferLoadAction.Load);
			}
			RenderBufferStoreAction depthStoreAction = ((!(preserveDepthStencil & flag3)) ? renderPass.depthStoreAction : RenderBufferStoreAction.Store);
			SetRenderTarget(cmd, colorAttachment, colorLoadAction, renderPass.colorStoreAction, depthAttachment, depthLoadAction, depthStoreAction, clearFlag2, clearColor);
			context.ExecuteCommandBuffer(cmd);
			cmd.Clear();
		}
	}

	internal void MarkCameraTargetsInitialized()
	{
		m_FirstTimeCameraColorTargetIsBound = false;
		m_FirstTimeCameraDepthTargetIsBound = false;
	}

	private bool ConsumeFirstCameraDepthBinding(bool bindsCameraDepth)
	{
		if (!bindsCameraDepth || !m_FirstTimeCameraDepthTargetIsBound)
		{
			return false;
		}
		m_FirstTimeCameraDepthTargetIsBound = false;
		return true;
	}

	internal static void InvalidateActiveRenderTarget()
	{
		s_ActiveColorAttachment = BuiltinRenderTextureType.None;
		s_ActiveDepthAttachment = BuiltinRenderTextureType.None;
	}

	internal static void SetActiveColor(RenderTargetIdentifier colorAttachment)
	{
		s_ActiveColorAttachment = colorAttachment;
	}

	internal static void SetActiveRenderTarget(RenderTargetIdentifier colorAttachment, RenderTargetIdentifier depthAttachment)
	{
		s_ActiveColorAttachment = colorAttachment;
		s_ActiveDepthAttachment = depthAttachment;
	}

	internal static void SetRenderTarget(CommandBuffer cmd, RenderTargetIdentifier colorAttachment, RenderTargetIdentifier depthAttachment, ClearFlag clearFlag, Color clearColor)
	{
		SetRenderTarget(cmd, colorAttachment, depthAttachment, clearFlag, clearColor, RenderBufferStoreAction.Store, RenderBufferStoreAction.Store);
	}

	internal static void SetRenderTarget(CommandBuffer cmd, RenderTargetIdentifier colorAttachment, RenderTargetIdentifier depthAttachment, ClearFlag clearFlag, Color clearColor, RenderBufferStoreAction colorStoreAction, RenderBufferStoreAction depthStoreAction)
	{
		s_ActiveColorAttachment = colorAttachment;
		s_ActiveDepthAttachment = depthAttachment;
		RenderBufferLoadAction colorLoadAction = (((clearFlag & ClearFlag.Color) != 0) ? RenderBufferLoadAction.DontCare : RenderBufferLoadAction.Load);
		RenderBufferLoadAction depthLoadAction = (((clearFlag & ClearFlag.Depth) != 0) ? RenderBufferLoadAction.DontCare : RenderBufferLoadAction.Load);
		SetRenderTarget(cmd, colorAttachment, colorLoadAction, colorStoreAction, depthAttachment, depthLoadAction, depthStoreAction, clearFlag, clearColor);
	}

	internal static void SetRenderTarget(CommandBuffer cmd, RenderTargetIdentifier colorAttachment, RenderBufferLoadAction colorLoadAction, RenderBufferStoreAction colorStoreAction, RenderTargetIdentifier depthAttachment, RenderBufferLoadAction depthLoadAction, RenderBufferStoreAction depthStoreAction)
	{
		s_ActiveColorAttachment = colorAttachment;
		s_ActiveDepthAttachment = depthAttachment;
		SetRenderTarget(cmd, colorAttachment, colorLoadAction, colorStoreAction, depthAttachment, depthLoadAction, depthStoreAction, ClearFlag.None, Color.black);
	}

	private static void SetRenderTarget(CommandBuffer cmd, RenderTargetIdentifier colorAttachment, RenderBufferLoadAction colorLoadAction, RenderBufferStoreAction colorStoreAction, RenderTargetIdentifier depthAttachment, RenderBufferLoadAction depthLoadAction, RenderBufferStoreAction depthStoreAction, ClearFlag clearFlags, Color clearColor)
	{
		if (depthStoreAction == RenderBufferStoreAction.DontCare)
		{
			depthStoreAction = s_DepthStoreAction;
		}
		if (depthAttachment == BuiltinRenderTextureType.None)
		{
			CoreUtils.SetRenderTarget(cmd, colorAttachment, colorLoadAction, colorStoreAction, depthLoadAction, depthStoreAction, clearFlags, clearColor);
		}
		else
		{
			CoreUtils.SetRenderTarget(cmd, colorAttachment, colorLoadAction, colorStoreAction, depthAttachment, depthLoadAction, depthStoreAction, clearFlags, clearColor);
		}
	}

	private static void SetRenderTarget(CommandBuffer cmd, RenderTargetIdentifier[] colorAttachments, RenderTargetIdentifier depthAttachment, ClearFlag clearFlag, Color clearColor)
	{
		s_ActiveColorAttachment = colorAttachments[0];
		s_ActiveDepthAttachment = depthAttachment;
		CoreUtils.SetRenderTarget(cmd, colorAttachments, depthAttachment, clearFlag, clearColor);
	}

	internal virtual void SwapColorBuffer()
	{
	}

	[Conditional("UNITY_EDITOR")]
	private void DrawGizmos(ScriptableRenderContext context, Camera camera, GizmoSubset gizmoSubset, CommandBuffer cmd)
	{
	}

	[Conditional("UNITY_EDITOR")]
	private void DrawWireOverlay(ScriptableRenderContext context, Camera camera)
	{
		context.DrawWireOverlay(camera);
	}

	private void InternalStartRendering(ScriptableRenderContext context, ref RenderingData renderingData)
	{
		CommandBuffer cmd = renderingData.cmd;
		using (new ProfilingScope(null, Profiling.internalStartRendering))
		{
			for (int i = 0; i < m_ActiveRenderPassQueue.Count; i++)
			{
				m_ActiveRenderPassQueue[i].OnCameraSetup(cmd, ref renderingData);
			}
		}
	}

	private void InternalFinishRendering(bool lastCam, CommandBuffer cmd)
	{
		using (new ProfilingScope(null, Profiling.internalFinishRendering))
		{
			for (int i = 0; i < m_ActiveRenderPassQueue.Count; i++)
			{
				m_ActiveRenderPassQueue[i].OnCameraCleanup(cmd);
			}
			if (lastCam)
			{
				FinishRendering(cmd);
			}
		}
	}

	internal static void SortStable(List<ScriptableRenderPass> list)
	{
		for (int i = 1; i < list.Count; i++)
		{
			ScriptableRenderPass scriptableRenderPass = list[i];
			int num = i - 1;
			while (num >= 0 && scriptableRenderPass < list[num])
			{
				list[num + 1] = list[num];
				num--;
			}
			list[num + 1] = scriptableRenderPass;
		}
	}
}
