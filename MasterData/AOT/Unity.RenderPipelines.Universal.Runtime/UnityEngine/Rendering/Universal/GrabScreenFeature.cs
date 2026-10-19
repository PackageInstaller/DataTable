using System;
using System.Collections.Generic;
using UnityEngine.Rendering.RendererUtils;
using XPostProcessing;

namespace UnityEngine.Rendering.Universal;

public class GrabScreenFeature : ScriptableRendererFeature
{
	[Serializable]
	public class Settings
	{
		public string shaderProperty = "_GrabPassTransparent";

		public Shader blitShader;

		public Settings Clone()
		{
			return (Settings)MemberwiseClone();
		}
	}

	private class GrabPass : ScriptableRenderPass
	{
		private enum GrabBlitPass
		{
			Copy,
			CopyCharacter,
			SceneTone,
			PerfectDodgePC,
			PerfectDodgeDepthOnly
		}

		private static class ShaderIDs
		{
			internal static readonly int SceneToneParams = Shader.PropertyToID("_SceneToneParams");

			internal static readonly int PerfectDodgeParams = Shader.PropertyToID("_PerfectDodgeParams");

			internal static readonly int PerfectDodgeProgress = Shader.PropertyToID("_PerfectDodgeProgress");

			internal static readonly int PerfectDodgeFlowColor = Shader.PropertyToID("_PerfectDodgeFlowColor");

			internal static readonly int PerfectDodgeLineColor = Shader.PropertyToID("_PerfectDodgeLineColor");

			internal static readonly int DeSaturate = Shader.PropertyToID("_DeSaturate");

			internal static readonly int Darken = Shader.PropertyToID("_Darken");

			internal static readonly int CharacterStencilRef = Shader.PropertyToID("_CharacterStencilRef");

			internal static readonly int CharacterStencilReadMask = Shader.PropertyToID("_CharacterStencilReadMask");
		}

		private const float ScanLineEndPosition = 1.02f;

		private const float ScanLineProgressExponent = 0.45f;

		private readonly int m_ShaderTexID;

		private readonly Material m_GrabBlitMaterial;

		private readonly RenderTargetIdentifier[] m_ColorAttachments = new RenderTargetIdentifier[2];

		private readonly ShaderTagId[] m_ShaderTagIds = new ShaderTagId[5]
		{
			ShaderPassTags.SRPDefaultUnlit,
			ShaderPassTags.UniversalForward,
			ShaderPassTags.UniversalForwardOnly,
			ShaderPassTags.ForwardOnlySecondary,
			new ShaderTagId("Water")
		};

		private readonly List<RendererList> m_RendererLists = new List<RendererList>(1);

		private int m_GrabPassLayerMask = -1;

		private bool m_SceneToneActive;

		private bool m_PerfectDodgeActive;

		private bool m_UseDepthOnlyOutline;

		private Vector4 m_SceneToneParams;

		private Vector4 m_PerfectDodgeParams;

		private float m_PerfectDodgeProgress;

		private Color m_PerfectDodgeFlowColor;

		private Color m_PerfectDodgeLineColor;

		internal override bool supportsNativePostDeferredPass => true;

		internal bool hasCompositeMaterial => m_GrabBlitMaterial != null;

		private int GrabPassLayerMask
		{
			get
			{
				if (m_GrabPassLayerMask != -1)
				{
					return m_GrabPassLayerMask;
				}
				int num = LayerMask.NameToLayer("GrabPass");
				m_GrabPassLayerMask = ((num >= 0) ? (1 << num) : 0);
				return m_GrabPassLayerMask;
			}
		}

		public GrabPass(Settings settings, Material grabBlitMaterial)
		{
			profilingSampler = new ProfilingSampler("GrabPass");
			m_GrabBlitMaterial = grabBlitMaterial;
			m_ShaderTexID = Shader.PropertyToID(settings.shaderProperty);
			ConfigureColorAttachment(RenderBufferLoadAction.DontCare);
			ConfigureDepthAttachment();
			renderPassEvent = RenderPassEvent.GrabPass;
			if (m_GrabBlitMaterial != null)
			{
				m_GrabBlitMaterial.SetFloat(ShaderIDs.CharacterStencilRef, 32f);
				m_GrabBlitMaterial.SetFloat(ShaderIDs.CharacterStencilReadMask, 96f);
			}
		}

		internal void Setup(DeSaturate sceneTone, PerfectDodge perfectDodge, bool useDepthOnlyOutline)
		{
			m_SceneToneActive = sceneTone != null && sceneTone.IsActive() && m_GrabBlitMaterial != null;
			m_PerfectDodgeActive = perfectDodge != null && perfectDodge.IsActive() && m_GrabBlitMaterial != null;
			m_UseDepthOnlyOutline = useDepthOnlyOutline;
			m_SceneToneParams = (m_SceneToneActive ? new Vector4(sceneTone.deSaturate.value, sceneTone.darken.value, 0f, 0f) : Vector4.zero);
			if (m_PerfectDodgeActive)
			{
				float num = (m_PerfectDodgeProgress = perfectDodge.progress.value);
				float x = Mathf.Max(0f, perfectDodge.OffsetCurve.value.Evaluate(num) * perfectDodge.offsetIntensity.value);
				float z = 1.02f * Mathf.Pow(num, 0.45f);
				float y = Mathf.Clamp01(perfectDodge.DeSaturateCurve.value.Evaluate(num));
				float w = Mathf.Clamp01(perfectDodge.LineCurve.value.Evaluate(num));
				m_PerfectDodgeParams = new Vector4(x, y, z, w);
				m_PerfectDodgeFlowColor = perfectDodge.flowLightColor.value;
				m_PerfectDodgeLineColor = perfectDodge.lineColor.value;
			}
		}

		public override void Configure(ref RenderingData renderingData)
		{
			nativeRenderPassType = (renderingData.nativePostDeferredPass ? NativeRenderPassType.PostDeferred : NativeRenderPassType.None);
			ConfigureDepthAttachment();
			UniversalRenderer renderer = renderingData.cameraData.renderer;
			renderer.SwapColorBuffer();
			UniversalRenderer universalRenderer = renderer;
			if (renderingData.postProcessingData.motionFeature && universalRenderer != null && universalRenderer.gBuffer2TextureRT != null)
			{
				m_ColorAttachments[0] = renderer.cameraColorTarget;
				m_ColorAttachments[1] = universalRenderer.gBuffer2Texture;
				ConfigureTarget(m_ColorAttachments, renderer.cameraDepthTarget);
			}
			else
			{
				targetCount = 1u;
				ConfigureTarget(renderer.cameraColorTarget, renderer.cameraDepthTarget);
			}
		}

		public override void BeginSubPass(ref ScriptableRenderContext context, ref RenderingData renderingData)
		{
			NativeRenderPassManager nativeRenderPassManager = renderingData.nativeRenderPassManager;
			nativeRenderPassManager.ConfigureTarget(nativeRenderPassManager.CurrentCameraColorAttachment);
			nativeRenderPassManager.BeginSubPass(ref context);
		}

		public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
		{
			CommandBuffer cmd = renderingData.cmd;
			using (new ProfilingScope(cmd, profilingSampler))
			{
				context.ExecuteCommandBuffer(cmd);
				cmd.Clear();
				RenderTargetIdentifier cameraColorFrontBuffer = renderingData.cameraData.renderer.GetCameraColorFrontBuffer(cmd);
				cmd.SetGlobalTexture(ShaderPropertyId.sourceTex, cameraColorFrontBuffer);
				cmd.SetGlobalTexture(m_ShaderTexID, cameraColorFrontBuffer);
				if (m_SceneToneActive || m_PerfectDodgeActive)
				{
					m_GrabBlitMaterial.SetVector(ShaderIDs.SceneToneParams, m_SceneToneParams);
					if (m_PerfectDodgeActive)
					{
						m_GrabBlitMaterial.SetVector(ShaderIDs.PerfectDodgeParams, m_PerfectDodgeParams);
						m_GrabBlitMaterial.SetFloat(ShaderIDs.PerfectDodgeProgress, m_PerfectDodgeProgress);
						m_GrabBlitMaterial.SetColor(ShaderIDs.PerfectDodgeFlowColor, m_PerfectDodgeFlowColor);
						m_GrabBlitMaterial.SetColor(ShaderIDs.PerfectDodgeLineColor, m_PerfectDodgeLineColor);
					}
					RenderingUtils.DrawProcedural(cmd, m_GrabBlitMaterial, 1, Vector2.one);
					int passIndex = 2;
					if (m_PerfectDodgeActive)
					{
						passIndex = (m_UseDepthOnlyOutline ? 4 : 3);
					}
					RenderingUtils.DrawProcedural(cmd, m_GrabBlitMaterial, passIndex, Vector2.one);
					renderingData.preserveDepthStencilForGrabPass = false;
					cmd.SetGlobalFloat(ShaderIDs.DeSaturate, m_SceneToneParams.x);
					cmd.SetGlobalFloat(ShaderIDs.Darken, m_SceneToneParams.y);
				}
				else
				{
					RenderingUtils.DrawProcedural(cmd, m_GrabBlitMaterial, 0, Vector2.one);
				}
			}
		}

		public bool HasVisibleGrabPassRenderers(ref ScriptableRenderContext context, ref RenderingData renderingData)
		{
			int grabPassLayerMask = GrabPassLayerMask;
			if (grabPassLayerMask == 0)
			{
				return true;
			}
			RendererListDesc rendererListDesc = new RendererListDesc(m_ShaderTagIds, renderingData.cullResults, renderingData.cameraData.camera);
			rendererListDesc.layerMask = grabPassLayerMask;
			rendererListDesc.renderQueueRange = RenderQueueRange.all;
			rendererListDesc.sortingCriteria = SortingCriteria.CommonTransparent;
			RendererListDesc desc = rendererListDesc;
			RendererList rendererList = context.CreateRendererList(desc);
			m_RendererLists.Clear();
			m_RendererLists.Add(rendererList);
			context.PrepareRendererListsAsync(m_RendererLists);
			return context.QueryRendererListStatus(rendererList) == RendererListStatus.kRendererListPopulated;
		}
	}

	private GrabPass grabPass;

	[NonSerialized]
	private Material m_GrabBlitMaterial;

	[SerializeField]
	public Settings settings = new Settings();

	[NonSerialized]
	private Settings m_RuntimeSettings;

	[NonSerialized]
	private bool m_RuntimeSettingsDirty;

	public Settings runtimeSettings
	{
		get
		{
			EnsureRuntimeSettings();
			return m_RuntimeSettings;
		}
	}

	private void EnsureRuntimeSettings()
	{
		if (m_RuntimeSettings == null)
		{
			m_RuntimeSettings = ((settings != null) ? settings.Clone() : new Settings());
		}
	}

	public override void ApplyRuntimeSettings()
	{
		m_RuntimeSettingsDirty = true;
	}

	public override void Create()
	{
		EnsureRuntimeSettings();
		RebuildRuntimeResources();
	}

	private void RebuildRuntimeResources()
	{
		m_RuntimeSettingsDirty = false;
		grabPass = null;
		CoreUtils.Destroy(m_GrabBlitMaterial);
		m_GrabBlitMaterial = null;
		Shader shader = ((runtimeSettings.blitShader != null) ? runtimeSettings.blitShader : Shader.Find("Hidden/Universal Render Pipeline/GrabPassBlit"));
		if (shader == null)
		{
			Debug.LogError("GrabScreenFeature requires its dedicated GrabPassBlit shader; the feature has been disabled.");
			return;
		}
		m_GrabBlitMaterial = CoreUtils.CreateEngineMaterial(shader);
		grabPass = new GrabPass(runtimeSettings, m_GrabBlitMaterial);
	}

	protected override void Dispose(bool disposing)
	{
		grabPass = null;
		CoreUtils.Destroy(m_GrabBlitMaterial);
		m_GrabBlitMaterial = null;
	}

	public override void AddRenderPasses(ScriptableRenderer renderer, ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		if (m_RuntimeSettingsDirty)
		{
			RebuildRuntimeResources();
		}
		if (renderingData.cameraData.cameraType <= CameraType.SceneView && grabPass != null)
		{
			UniversalRenderer universalRenderer = renderer as UniversalRenderer;
			PerfectDodge perfectDodge = universalRenderer?.volumeComponents.PerfectDodge;
			DeSaturate deSaturate = universalRenderer?.volumeComponents.DeSaturate;
			bool flag = renderingData.cameraData.isGameCamera && renderingData.cameraData.postProcessEnabled && deSaturate != null && deSaturate.IsActive() && grabPass.hasCompositeMaterial;
			bool flag2 = renderingData.cameraData.isGameCamera && renderingData.cameraData.postProcessEnabled && perfectDodge != null && perfectDodge.IsActive() && grabPass.hasCompositeMaterial;
			if ((flag | flag2) || grabPass.HasVisibleGrabPassRenderers(ref context, ref renderingData) || flag || flag2)
			{
				bool useDepthOnlyOutline = universalRenderer == null || universalRenderer.renderPassScheduleMode == RenderPassScheduleMode.Mobile || universalRenderer.actualRenderingMode != RenderingMode.Deferred;
				grabPass.Setup(flag ? deSaturate : null, flag2 ? perfectDodge : null, useDepthOnlyOutline);
				renderingData.preserveDepthStencilForGrabPass = flag | flag2;
				renderingData.sceneToneInGrabPass = flag;
				renderingData.doGrabPass = true;
				renderer.EnqueuePass(grabPass);
			}
		}
	}
}
