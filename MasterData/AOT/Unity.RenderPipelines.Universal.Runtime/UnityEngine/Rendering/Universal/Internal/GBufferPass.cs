using System;
using System.Collections.Generic;
using ACT_Instance;

namespace UnityEngine.Rendering.Universal.Internal;

internal class GBufferPass : ScriptableRenderPass, IDisposable
{
	internal static readonly int s_CameraNormalsTextureID = Shader.PropertyToID("_CameraNormalsTexture");

	private static readonly Color s_MotionFeatureClearColor = new Color(0.5f, 0.5f, 0f, 0f);

	private readonly DeferredLights m_DeferredLights;

	private readonly PassStencilStateOverride m_PureOuterOutlineStencilOverride;

	private readonly List<ShaderTagId> m_LightModeTags = new List<ShaderTagId>();

	private readonly List<ShaderTagId> m_SpecialLightModeTags = new List<ShaderTagId>();

	private FilteringSettings m_FilteringSettings;

	private int m_SpecialCharacterLayerMask;

	private GlobalKeyword instanceKeyWord;

	private bool m_HasExtraTagState;

	private bool m_CharacterOutlineEnabled = true;

	private bool m_HairShadowEnabled = true;

	private bool m_ForcePureOuterOutline;

	private static readonly ShaderTagId[] GbufferShaderTagIdsOutlineAndHairShadow = new ShaderTagId[7]
	{
		ShaderPassTags.UniversalGBuffer,
		ShaderPassTags.SceneGBuffer,
		ShaderPassTags.PlantGBuffer,
		ShaderPassTags.CharacterGBuffer,
		ShaderPassTags.GBufferHair,
		ShaderPassTags.GBufferHairOverEye,
		ShaderPassTags.CharacterGBufferOutline
	};

	private static readonly ShaderTagId[] GbufferShaderTagIdsHairShadow = new ShaderTagId[6]
	{
		ShaderPassTags.UniversalGBuffer,
		ShaderPassTags.SceneGBuffer,
		ShaderPassTags.PlantGBuffer,
		ShaderPassTags.CharacterGBuffer,
		ShaderPassTags.GBufferHair,
		ShaderPassTags.GBufferHairOverEye
	};

	private static readonly ShaderTagId[] GbufferShaderTagIdsOutline = new ShaderTagId[6]
	{
		ShaderPassTags.UniversalGBuffer,
		ShaderPassTags.SceneGBuffer,
		ShaderPassTags.PlantGBuffer,
		ShaderPassTags.CharacterGBuffer,
		ShaderPassTags.GBufferHairOpaque,
		ShaderPassTags.CharacterGBufferOutline
	};

	private static readonly ShaderTagId[] GbufferShaderTagIdsBase = new ShaderTagId[5]
	{
		ShaderPassTags.UniversalGBuffer,
		ShaderPassTags.SceneGBuffer,
		ShaderPassTags.PlantGBuffer,
		ShaderPassTags.CharacterGBuffer,
		ShaderPassTags.GBufferHairOpaque
	};

	private void ReplaceShaderTagList(ShaderTagId[] shaderTagIds)
	{
		m_LightModeTags.Clear();
		foreach (ShaderTagId item in shaderTagIds)
		{
			m_LightModeTags.Add(item);
		}
	}

	private void RefreshShaderTagList()
	{
		if (m_CharacterOutlineEnabled && m_HairShadowEnabled)
		{
			ReplaceShaderTagList(GbufferShaderTagIdsOutlineAndHairShadow);
		}
		else if (m_HairShadowEnabled)
		{
			ReplaceShaderTagList(GbufferShaderTagIdsHairShadow);
		}
		else if (m_CharacterOutlineEnabled)
		{
			ReplaceShaderTagList(GbufferShaderTagIdsOutline);
		}
		else
		{
			ReplaceShaderTagList(GbufferShaderTagIdsBase);
		}
	}

	public void SetCharacterOutlineAndHairShadowEnable(bool enableCharacterOutline, bool enableHairShadow, bool forcePureOuterOutline)
	{
		if (!m_HasExtraTagState || m_CharacterOutlineEnabled != enableCharacterOutline || m_HairShadowEnabled != enableHairShadow || m_ForcePureOuterOutline != forcePureOuterOutline)
		{
			m_CharacterOutlineEnabled = enableCharacterOutline;
			m_HairShadowEnabled = enableHairShadow;
			m_ForcePureOuterOutline = forcePureOuterOutline;
			m_HasExtraTagState = true;
			RefreshShaderTagList();
		}
	}

	internal void SetSpecialCharacterLayerMask(LayerMask layerMask)
	{
		m_SpecialCharacterLayerMask = layerMask;
	}

	public GBufferPass(RenderPassEvent evt, RenderQueueRange renderQueueRange, LayerMask layerMask, LayerMask specialCharacterLayerMask, DeferredLights deferredLights)
	{
		profilingSampler = new ProfilingSampler("GBufferPass");
		renderPassEvent = evt;
		RefreshShaderTagList();
		for (int i = 0; i < GbufferShaderTagIdsOutlineAndHairShadow.Length; i++)
		{
			m_SpecialLightModeTags.Add(GbufferShaderTagIdsOutlineAndHairShadow[i]);
		}
		m_DeferredLights = deferredLights;
		m_PureOuterOutlineStencilOverride = new PassStencilStateOverride(ShaderPassTags.CharacterGBufferOutline, CharacterOutlineStencil.CreatePureGreaterGBufferOverride(), new RenderStateBlock(RenderStateMask.Nothing));
		m_FilteringSettings = new FilteringSettings(renderQueueRange, layerMask);
		m_SpecialCharacterLayerMask = specialCharacterLayerMask;
		instanceKeyWord = GlobalKeyword.Create("_ACT_INSTANCE_OBJECT");
	}

	public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData)
	{
		RenderTargetHandle[] gbufferAttachments = m_DeferredLights.GbufferAttachments;
		RenderTextureDescriptor cameraTargetDescriptor = renderingData.cameraData.cameraTargetDescriptor;
		cameraTargetDescriptor.depthBufferBits = 0;
		for (int i = 0; i < gbufferAttachments.Length; i++)
		{
			if (i != 3 && i != 2 && (i != 1 || !m_DeferredLights.HasNormalPrepass))
			{
				cameraTargetDescriptor.graphicsFormat = m_DeferredLights.GbufferFormats[i];
				cmd.GetTemporaryRT(m_DeferredLights.GbufferAttachments[i].id, cameraTargetDescriptor);
			}
		}
	}

	public override void Configure(ref RenderingData renderingData)
	{
		ConfigureTarget(m_DeferredLights.GbufferOutputAttachmentIdentifiers, m_DeferredLights.DepthAttachmentIdentifier);
		ConfigureClear((renderingData.nativeDeferredMode == NativeDeferredMode.None) ? ClearFlag.Color : ClearFlag.None, Color.clear);
	}

	public override void BeginSubPass(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		NativeRenderPassManager nativeRenderPassManager = renderingData.nativeRenderPassManager;
		if (nativeRenderPassManager.GBufferWritesDepthTexture)
		{
			nativeRenderPassManager.ConfigureTarget(1, 2, 3, 4, 5);
		}
		else
		{
			nativeRenderPassManager.ConfigureTarget(1, 2, 3, 4);
		}
		nativeRenderPassManager.BeginSubPass(ref context);
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		CommandBuffer cmd = renderingData.cmd;
		using (new ProfilingScope(cmd, profilingSampler))
		{
			if (renderingData.nativeDeferredMode == NativeDeferredMode.None)
			{
				cmd.SetRenderTarget(m_DeferredLights.GbufferAttachmentIdentifiers[2]);
				cmd.ClearRenderTarget(clearDepth: false, clearColor: true, s_MotionFeatureClearColor);
				cmd.SetRenderTarget(m_DeferredLights.GbufferOutputAttachmentIdentifiers, m_DeferredLights.DepthAttachmentIdentifier);
			}
			context.ExecuteCommandBuffer(cmd);
			cmd.Clear();
			DrawingSettings drawingSettings = CreateDrawingSettings(m_LightModeTags, ref renderingData, renderingData.cameraData.defaultOpaqueSortFlags);
			if (renderingData.postProcessingData.requiresMotionVectorOutput)
			{
				drawingSettings.perObjectData |= PerObjectData.MotionVectors;
			}
			int num = m_SpecialCharacterLayerMask & m_FilteringSettings.layerMask;
			if (num == 0)
			{
				if (m_CharacterOutlineEnabled && m_ForcePureOuterOutline)
				{
					m_PureOuterOutlineStencilOverride.DrawRenderers(ref context, renderingData.cullResults, ref drawingSettings, ref m_FilteringSettings);
				}
				else
				{
					context.DrawRenderers(renderingData.cullResults, ref drawingSettings, ref m_FilteringSettings);
				}
			}
			else
			{
				FilteringSettings filteringSettings = m_FilteringSettings;
				filteringSettings.layerMask &= ~num;
				if (filteringSettings.layerMask != 0)
				{
					if (m_CharacterOutlineEnabled && m_ForcePureOuterOutline)
					{
						m_PureOuterOutlineStencilOverride.DrawRenderers(ref context, renderingData.cullResults, ref drawingSettings, ref filteringSettings);
					}
					else
					{
						context.DrawRenderers(renderingData.cullResults, ref drawingSettings, ref filteringSettings);
					}
				}
				FilteringSettings filteringSettings2 = m_FilteringSettings;
				filteringSettings2.layerMask = num;
				DrawingSettings drawingSettings2 = CreateDrawingSettings(m_SpecialLightModeTags, ref renderingData, renderingData.cameraData.defaultOpaqueSortFlags);
				drawingSettings2.perObjectData = drawingSettings.perObjectData;
				context.DrawRenderers(renderingData.cullResults, ref drawingSettings2, ref filteringSettings2);
			}
			if (renderingData.cameraData.postProcessEnabled)
			{
				bool flag = GrassGroundMultiPass.GrassGroundList.Count > 0;
				bool flag2 = DrawInstanceObjectRendering.ObjectList.Count > 0;
				if (flag)
				{
					GrassGroundMultiPass.DrawGrassMultiLayer(cmd, 1);
					GrassGroundMultiPass.DrawGrassMultiLayer(cmd, 0);
				}
				if (flag2)
				{
					cmd.SetKeyword(in instanceKeyWord, value: true);
					DrawInstanceObjectRendering.RenderObject(cmd, 0, DrawInstanceObject.RenderType.GBuffer, renderingData.cameraData.camera);
					cmd.SetKeyword(in instanceKeyWord, value: false);
				}
			}
		}
	}

	public override void OnCameraCleanup(CommandBuffer cmd)
	{
		RenderTargetHandle[] gbufferAttachments = m_DeferredLights.GbufferAttachments;
		for (int i = 0; i < gbufferAttachments.Length; i++)
		{
			if (i != 3 && i != 2 && (i != 1 || !m_DeferredLights.HasNormalPrepass))
			{
				cmd.ReleaseTemporaryRT(gbufferAttachments[i].id);
			}
		}
	}

	public void Dispose()
	{
		m_PureOuterOutlineStencilOverride.Dispose();
	}
}
