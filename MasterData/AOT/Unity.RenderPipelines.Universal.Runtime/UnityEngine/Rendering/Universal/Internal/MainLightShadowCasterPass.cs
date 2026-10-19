using System.Collections.Generic;
using ACT_Instance;

namespace UnityEngine.Rendering.Universal.Internal;

public class MainLightShadowCasterPass : ScriptableRenderPass
{
	private static class MainLightShadowConstantBuffer
	{
		public static int _WorldToShadow;

		public static int _ShadowParams;

		public static int _CascadeCount;

		public static int _CascadeShadowSplitSpheres0;

		public static int _CascadeShadowSplitSpheres1;

		public static int _CascadeShadowSplitSpheres2;

		public static int _CascadeShadowSplitSpheres3;

		public static int _CascadeShadowSplitSphereRadii;

		public static int _ShadowOffset0;

		public static int _ShadowOffset1;

		public static int _ShadowOffset2;

		public static int _ShadowOffset3;

		public static int _ShadowmapSize;
	}

	private const int k_MaxCascades = 4;

	private const int k_ShadowmapBufferBits = 16;

	private float m_CascadeBorder;

	private float m_MaxShadowDistanceSq;

	private int m_ShadowCasterCascadesCount;

	public static RenderTargetIdentifier s_ShadowMapID;

	private RenderTargetHandle m_ShadowMapHandle;

	private Matrix4x4[] m_MainLightShadowMatrices;

	private ShadowSliceData[] m_CascadeSlices;

	private Vector4[] m_CascadeSplitDistances;

	private bool m_CreateEmptyShadowmap;

	private ProfilingSampler m_ProfilingSetupSampler = new ProfilingSampler("Setup Main Shadowmap");

	private static GlobalKeyword instanceKeyword;

	public static List<HDShadow> s_HDShadow;

	private static Matrix4x4 s_noOpShadowMatrix;

	private static Vector3[] s_Loop;

	private bool needShadowParam;

	static MainLightShadowCasterPass()
	{
		s_HDShadow = new List<HDShadow>();
		s_Loop = new Vector3[8]
		{
			new Vector3(1f, 1f, 1f),
			new Vector3(1f, -1f, 1f),
			new Vector3(1f, 1f, -1f),
			new Vector3(1f, -1f, -1f),
			new Vector3(-1f, 1f, 1f),
			new Vector3(-1f, -1f, 1f),
			new Vector3(-1f, 1f, -1f),
			new Vector3(-1f, -1f, -1f)
		};
		MainLightShadowConstantBuffer._WorldToShadow = Shader.PropertyToID("_MainLightWorldToShadow");
		MainLightShadowConstantBuffer._ShadowParams = Shader.PropertyToID("_MainLightShadowParams");
		MainLightShadowConstantBuffer._CascadeCount = Shader.PropertyToID("_MainLightShadowCascadeCount");
		MainLightShadowConstantBuffer._CascadeShadowSplitSpheres0 = Shader.PropertyToID("_CascadeShadowSplitSpheres0");
		MainLightShadowConstantBuffer._CascadeShadowSplitSpheres1 = Shader.PropertyToID("_CascadeShadowSplitSpheres1");
		MainLightShadowConstantBuffer._CascadeShadowSplitSpheres2 = Shader.PropertyToID("_CascadeShadowSplitSpheres2");
		MainLightShadowConstantBuffer._CascadeShadowSplitSpheres3 = Shader.PropertyToID("_CascadeShadowSplitSpheres3");
		MainLightShadowConstantBuffer._CascadeShadowSplitSphereRadii = Shader.PropertyToID("_CascadeShadowSplitSphereRadii");
		MainLightShadowConstantBuffer._ShadowOffset0 = Shader.PropertyToID("_MainLightShadowOffset0");
		MainLightShadowConstantBuffer._ShadowOffset1 = Shader.PropertyToID("_MainLightShadowOffset1");
		MainLightShadowConstantBuffer._ShadowOffset2 = Shader.PropertyToID("_MainLightShadowOffset2");
		MainLightShadowConstantBuffer._ShadowOffset3 = Shader.PropertyToID("_MainLightShadowOffset3");
		MainLightShadowConstantBuffer._ShadowmapSize = Shader.PropertyToID("_MainLightShadowmapSize");
		s_noOpShadowMatrix = Matrix4x4.zero;
		s_noOpShadowMatrix.m22 = (RenderingUtils.UsesReversedZBuffer ? 1f : 0f);
		instanceKeyword = GlobalKeyword.Create("_ACT_INSTANCE_OBJECT");
	}

	public MainLightShadowCasterPass(RenderPassEvent evt)
	{
		profilingSampler = new ProfilingSampler("MainLightShadowCasterPass");
		renderPassEvent = evt;
		m_MainLightShadowMatrices = new Matrix4x4[5];
		m_CascadeSlices = new ShadowSliceData[4];
		m_CascadeSplitDistances = new Vector4[4];
		m_ShadowMapHandle.Init("_MainLightShadowmapTexture");
		s_ShadowMapID = m_ShadowMapHandle.Identifier();
		ConfigureTarget(s_ShadowMapID, ShadowUtils.shadowTexDes.depthStencilFormat, depth: true);
		ConfigureDepthAttachment(RenderBufferLoadAction.DontCare, RenderBufferStoreAction.Store, ClearFlag.Depth, Color.black);
	}

	public bool Setup(CommandBuffer cmd, ref RenderingData renderingData, bool forceEmptyShadowmap = false)
	{
		using (new ProfilingScope(null, m_ProfilingSetupSampler))
		{
			if (forceEmptyShadowmap)
			{
				needShadowParam = false;
				return SetupForEmptyRendering(cmd);
			}
			if (!renderingData.shadowData.supportsMainLightShadows)
			{
				needShadowParam = false;
				return SetupForEmptyRendering(cmd);
			}
			Clear();
			int mainLightIndex = renderingData.lightData.mainLightIndex;
			if (mainLightIndex == -1)
			{
				needShadowParam = false;
				return SetupForEmptyRendering(cmd);
			}
			Light light = renderingData.lightData.visibleLights[mainLightIndex].light;
			if (light.shadows == LightShadows.None)
			{
				needShadowParam = false;
				return SetupForEmptyRendering(cmd);
			}
			if (!renderingData.cullResults.GetShadowCasterBounds(mainLightIndex, out var _))
			{
				needShadowParam = true;
				return SetupForEmptyRendering(cmd);
			}
			_ = light.transform.worldToLocalMatrix;
			m_ShadowCasterCascadesCount = renderingData.shadowData.mainLightShadowCascadesCount;
			int maxTileResolutionInAtlas = ShadowUtils.GetMaxTileResolutionInAtlas(renderingData.shadowData.mainLightShadowmapWidth, renderingData.shadowData.mainLightShadowmapHeight, m_ShadowCasterCascadesCount);
			renderTargetWidth = renderingData.shadowData.mainLightShadowmapWidth;
			renderTargetHeight = ((m_ShadowCasterCascadesCount == 2) ? (renderingData.shadowData.mainLightShadowmapHeight >> 1) : renderingData.shadowData.mainLightShadowmapHeight);
			for (int i = 0; i < m_ShadowCasterCascadesCount; i++)
			{
				if (!ShadowUtils.ExtractDirectionalLightMatrix(ref renderingData.cullResults, ref renderingData.shadowData, mainLightIndex, i, renderTargetWidth, renderTargetHeight, maxTileResolutionInAtlas, light.shadowNearPlane, out m_CascadeSplitDistances[i], out m_CascadeSlices[i]))
				{
					return SetupForEmptyRendering(cmd);
				}
			}
			ShadowUtils.GetRT(cmd, renderTargetWidth, renderTargetHeight, m_ShadowMapHandle.id);
			m_MaxShadowDistanceSq = renderingData.cameraData.maxShadowDistance * renderingData.cameraData.maxShadowDistance;
			m_CascadeBorder = renderingData.shadowData.mainLightShadowCascadeBorder;
			m_CreateEmptyShadowmap = false;
			return true;
		}
	}

	private bool SetupForEmptyRendering(CommandBuffer cmd)
	{
		ShadowUtils.GetRT(cmd, 1, 1, m_ShadowMapHandle.id);
		m_CreateEmptyShadowmap = true;
		return false;
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		if (m_CreateEmptyShadowmap)
		{
			SetEmptyMainLightCascadeShadowmap(renderingData.cmd);
			if (needShadowParam)
			{
				int mainLightIndex = renderingData.lightData.mainLightIndex;
				if (mainLightIndex != -1)
				{
					VisibleLight visibleLight = renderingData.lightData.visibleLights[mainLightIndex];
					ShadowUtils.GetScaleAndBiasForLinearDistanceFade(m_MaxShadowDistanceSq, m_CascadeBorder, out var scale, out var bias);
					renderingData.cmd.SetGlobalVector(MainLightShadowConstantBuffer._ShadowParams, new Vector4(visibleLight.light.shadowStrength, 1f, scale, bias));
				}
			}
		}
		else
		{
			RenderMainLightCascadeShadowmap(ref context, ref renderingData.cullResults, ref renderingData.lightData, ref renderingData.shadowData, renderingData);
		}
	}

	public override void OnCameraCleanup(CommandBuffer cmd)
	{
		cmd.ReleaseTemporaryRT(m_ShadowMapHandle.id);
	}

	private void Clear()
	{
		for (int i = 0; i < 4; i++)
		{
			m_CascadeSplitDistances[i] = new Vector4(0f, 0f, 0f, 0f);
		}
		for (int j = 0; j < m_CascadeSlices.Length; j++)
		{
			m_CascadeSlices[j].Clear();
		}
	}

	private void SetEmptyMainLightCascadeShadowmap(CommandBuffer cmd)
	{
		cmd.SetGlobalTexture(m_ShadowMapHandle.id, s_ShadowMapID);
		cmd.SetGlobalInteger(MainLightShadowConstantBuffer._CascadeCount, 0);
		cmd.SetGlobalVector(MainLightShadowConstantBuffer._ShadowParams, new Vector4(0f, 0f, 1f, 0f));
		cmd.SetGlobalVector(MainLightShadowConstantBuffer._ShadowmapSize, new Vector4(1f, 1f, 1f, 1f));
	}

	private void RenderMainLightCascadeShadowmap(ref ScriptableRenderContext context, ref CullingResults cullResults, ref LightData lightData, ref ShadowData shadowData, RenderingData data)
	{
		int mainLightIndex = lightData.mainLightIndex;
		if (mainLightIndex == -1)
		{
			return;
		}
		VisibleLight shadowLight = lightData.visibleLights[mainLightIndex];
		data.cullResults.GetShadowCasterBounds(mainLightIndex, out var outBounds);
		CommandBuffer cmd = data.cmd;
		using (new ProfilingScope(cmd, ProfilingSampler.Get(URPProfileId.MainLightShadow)))
		{
			ShadowDrawingSettings settings = new ShadowDrawingSettings(cullResults, mainLightIndex, BatchCullingProjectionType.Orthographic);
			settings.useRenderingLayerMaskTest = lightData.supportsLightLayers;
			ShadowUtils.SetupLightConstantBuffer(cmd, ref shadowLight);
			DrawInstanceObjectRendering.CullingShadow(cmd, outBounds);
			cmd.SetKeyword(in instanceKeyword, value: true);
			for (int i = 0; i < m_ShadowCasterCascadesCount; i++)
			{
				settings.splitData = m_CascadeSlices[i].splitData;
				cmd.SetGlobalVector(DeferredLights.ShaderConstants._ShadowBias, Vector4.zero);
				float num = shadowData.mainLightCascadeDepthBias[i];
				float slopeBias = shadowData.mainLightCascadeSlopeBias[i];
				ShadowUtils.RenderShadowSlice(cmd, ref context, ref m_CascadeSlices[i], ref settings, m_CascadeSlices[i].projectionMatrix, m_CascadeSlices[i].viewMatrix, num, slopeBias);
				cmd.SetGlobalDepthBias(num, slopeBias);
				DrawInstanceObjectRendering.RenderShadow(cmd, 2);
				cmd.SetGlobalDepthBias(0f, 0f);
			}
			cmd.SetKeyword(in instanceKeyword, value: false);
			SetupMainLightShadowReceiverConstants(cmd, shadowLight);
		}
	}

	private void SetupMainLightShadowReceiverConstants(CommandBuffer cmd, VisibleLight shadowLight)
	{
		Light light = shadowLight.light;
		int shadowCasterCascadesCount = m_ShadowCasterCascadesCount;
		for (int i = 0; i < shadowCasterCascadesCount; i++)
		{
			m_MainLightShadowMatrices[i] = m_CascadeSlices[i].shadowTransform;
		}
		for (int j = shadowCasterCascadesCount; j <= 4; j++)
		{
			m_MainLightShadowMatrices[j] = s_noOpShadowMatrix;
		}
		ShadowUtils.GetScaleAndBiasForLinearDistanceFade(m_MaxShadowDistanceSq, m_CascadeBorder, out var scale, out var bias);
		cmd.SetGlobalTexture(m_ShadowMapHandle.id, s_ShadowMapID);
		cmd.SetGlobalInteger(MainLightShadowConstantBuffer._CascadeCount, shadowCasterCascadesCount);
		cmd.SetGlobalMatrixArray(MainLightShadowConstantBuffer._WorldToShadow, m_MainLightShadowMatrices);
		cmd.SetGlobalVector(MainLightShadowConstantBuffer._ShadowParams, new Vector4(light.shadowStrength, 1f, scale, bias));
		if (m_ShadowCasterCascadesCount > 1)
		{
			cmd.SetGlobalVector(MainLightShadowConstantBuffer._CascadeShadowSplitSpheres0, m_CascadeSplitDistances[0]);
			cmd.SetGlobalVector(MainLightShadowConstantBuffer._CascadeShadowSplitSpheres1, m_CascadeSplitDistances[1]);
			cmd.SetGlobalVector(MainLightShadowConstantBuffer._CascadeShadowSplitSpheres2, m_CascadeSplitDistances[2]);
			cmd.SetGlobalVector(MainLightShadowConstantBuffer._CascadeShadowSplitSpheres3, m_CascadeSplitDistances[3]);
			cmd.SetGlobalVector(MainLightShadowConstantBuffer._CascadeShadowSplitSphereRadii, new Vector4(m_CascadeSplitDistances[0].w * m_CascadeSplitDistances[0].w, m_CascadeSplitDistances[1].w * m_CascadeSplitDistances[1].w, m_CascadeSplitDistances[2].w * m_CascadeSplitDistances[2].w, m_CascadeSplitDistances[3].w * m_CascadeSplitDistances[3].w));
		}
		else
		{
			cmd.SetGlobalVector(MainLightShadowConstantBuffer._CascadeShadowSplitSphereRadii, new Vector4(m_CascadeSplitDistances[0].w * m_CascadeSplitDistances[0].w, 0f, 0f, 0f));
		}
		float num = 1f / (float)renderTargetWidth;
		float num2 = 1f / (float)renderTargetHeight;
		cmd.SetGlobalVector(MainLightShadowConstantBuffer._ShadowmapSize, new Vector4(num, num2, renderTargetWidth, renderTargetHeight));
		float num3 = 0.5f * num;
		float num4 = 0.5f * num2;
		cmd.SetGlobalVector(MainLightShadowConstantBuffer._ShadowOffset0, new Vector4(0f - num3, 0f - num4, 0f, 0f));
		cmd.SetGlobalVector(MainLightShadowConstantBuffer._ShadowOffset1, new Vector4(num3, 0f - num4, 0f, 0f));
		cmd.SetGlobalVector(MainLightShadowConstantBuffer._ShadowOffset2, new Vector4(0f - num3, num4, 0f, 0f));
		cmd.SetGlobalVector(MainLightShadowConstantBuffer._ShadowOffset3, new Vector4(num3, num4, 0f, 0f));
	}
}
