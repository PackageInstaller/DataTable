using Unity.Collections;
using Unity.Mathematics;

namespace UnityEngine.Rendering.Universal.Internal;

public class ForwardLights
{
	private static class LightConstantBuffer
	{
		public static int _MainLightPosition;

		public static int _MainLightColor;

		public static int _MainLightLayerMask;

		public static int _MainLightACTData;

		public static int _MainLightACTData2;

		public static int _MainLightACTData3;

		public static int _AdditionalLightsCount;

		public static int _AdditionalLightsPosition;

		public static int _AdditionalLightsColor;

		public static int _AdditionalLightsAttenuation;

		public static int _AdditionalLightsSpotDir;

		public static int _AdditionalLightsLayerMasks;

		public static int _AdditionalLightsACTData;

		public static int _AdditionalLightsACTData2;

		public static int _AdditionalLightsACTData3;
	}

	private const string k_ForwardLightsSetup = "Forward Lights Setup";

	private static readonly ProfilingSampler m_ProfilingSampler = new ProfilingSampler("Forward Lights Setup");

	private Vector4[] m_AdditionalLightPositions;

	private Vector4[] m_AdditionalLightColors;

	private Vector4[] m_AdditionalLightAttenuations;

	private Vector4[] m_AdditionalLightSpotDirections;

	private Vector4[] m_AdditionalLightACTData;

	private Vector4[] m_AdditionalLightACTData2;

	private Vector4[] m_AdditionalLightACTData3;

	private float[] m_AdditionalLightsLayerMasks;

	private ushort m_MainLightIndex;

	private Vector4 m_MainLightPosition;

	private Vector4 m_MainLightColor;

	private Vector4 m_MainLightAttenuation;

	private Vector4 m_MainLightSpotDirection;

	private int m_MainLightLayerMask;

	private Vector4 m_MainLightACTLightData;

	private Vector4 m_MainLightACTLightData2;

	private Vector4 m_MainLightACTLightData3;

	private bool m_Initialized;

	public ForwardLights()
	{
		LightConstantBuffer._MainLightPosition = Shader.PropertyToID("_MainLightPosition");
		LightConstantBuffer._MainLightColor = Shader.PropertyToID("_MainLightColor");
		LightConstantBuffer._MainLightLayerMask = Shader.PropertyToID("_MainLightLayerMask");
		LightConstantBuffer._AdditionalLightsCount = Shader.PropertyToID("_AdditionalLightsCount");
		LightConstantBuffer._MainLightACTData = Shader.PropertyToID("_MainLightACTData");
		LightConstantBuffer._MainLightACTData2 = Shader.PropertyToID("_MainLightACTData2");
		LightConstantBuffer._MainLightACTData3 = Shader.PropertyToID("_MainLightACTData3");
		LightConstantBuffer._AdditionalLightsPosition = Shader.PropertyToID("_AdditionalLightsPosition");
		LightConstantBuffer._AdditionalLightsColor = Shader.PropertyToID("_AdditionalLightsColor");
		LightConstantBuffer._AdditionalLightsAttenuation = Shader.PropertyToID("_AdditionalLightsAttenuation");
		LightConstantBuffer._AdditionalLightsSpotDir = Shader.PropertyToID("_AdditionalLightsSpotDir");
		LightConstantBuffer._AdditionalLightsLayerMasks = Shader.PropertyToID("_AdditionalLightsLayerMasks");
		LightConstantBuffer._AdditionalLightsACTData = Shader.PropertyToID("_AdditionalLightsACTData");
		LightConstantBuffer._AdditionalLightsACTData2 = Shader.PropertyToID("_AdditionalLightsACTData2");
		LightConstantBuffer._AdditionalLightsACTData3 = Shader.PropertyToID("_AdditionalLightsACTData3");
		int maxVisibleAdditionalLights = UniversalRenderPipeline.maxVisibleAdditionalLights;
		m_AdditionalLightPositions = new Vector4[maxVisibleAdditionalLights];
		m_AdditionalLightColors = new Vector4[maxVisibleAdditionalLights];
		m_AdditionalLightACTData = new Vector4[maxVisibleAdditionalLights];
		m_AdditionalLightACTData2 = new Vector4[maxVisibleAdditionalLights];
		m_AdditionalLightACTData3 = new Vector4[maxVisibleAdditionalLights];
		m_AdditionalLightAttenuations = new Vector4[maxVisibleAdditionalLights];
		m_AdditionalLightSpotDirections = new Vector4[maxVisibleAdditionalLights];
		m_AdditionalLightsLayerMasks = new float[maxVisibleAdditionalLights];
	}

	public void SetupLights(CommandBuffer cmd, ref RenderingData renderingData)
	{
		using (new ProfilingScope(null, m_ProfilingSampler))
		{
			SetupShaderLightConstants(cmd, ref renderingData);
			if (!m_Initialized)
			{
				bool supportsLightLayers = renderingData.lightData.supportsLightLayers;
				CoreUtils.SetKeyword(cmd, "_LIGHT_LAYERS", supportsLightLayers);
				m_Initialized = true;
			}
		}
	}

	private static bool TryGetPreparedLight(ref LightData lightData, int visibleLightIndex, out PreparedVisibleLight preparedLight)
	{
		PreparedVisibleLight[] array = lightData.preparedLights?.visibleLights;
		if (array != null && (uint)visibleLightIndex < (uint)array.Length)
		{
			preparedLight = array[visibleLightIndex];
			return true;
		}
		preparedLight = default;
		return false;
	}

	private void SetupShaderLightConstants(CommandBuffer cmd, ref RenderingData renderingData)
	{
		SetupMainLightConstants(cmd, ref renderingData.lightData);
		SetupAdditionalLightConstants(cmd, ref renderingData);
	}

	private void SetupMainLightConstants(CommandBuffer cmd, ref LightData lightData)
	{
		if (TryGetPreparedLight(ref lightData, lightData.mainLightIndex, out var preparedLight))
		{
			m_MainLightPosition = preparedLight.position;
			m_MainLightColor = preparedLight.color;
			m_MainLightAttenuation = preparedLight.attenuation;
			m_MainLightSpotDirection = preparedLight.spotDirection;
			m_MainLightLayerMask = preparedLight.layerMask;
			m_MainLightACTLightData = preparedLight.actData;
			m_MainLightACTLightData2 = preparedLight.actData2;
			m_MainLightACTLightData3 = preparedLight.actData3;
		}
		else
		{
			UniversalRenderPipeline.InitializeLightConstants_Common(lightData.visibleLights, -1, null, out m_MainLightPosition, out m_MainLightColor, out m_MainLightAttenuation, out m_MainLightSpotDirection, out m_MainLightACTLightData, out m_MainLightACTLightData2, out m_MainLightACTLightData3);
			m_MainLightLayerMask = 0;
		}
		cmd.SetGlobalVector(LightConstantBuffer._MainLightPosition, m_MainLightPosition);
		cmd.SetGlobalVector(LightConstantBuffer._MainLightColor, m_MainLightColor);
		cmd.SetGlobalInteger(LightConstantBuffer._MainLightLayerMask, m_MainLightLayerMask);
		cmd.SetGlobalVector(LightConstantBuffer._MainLightACTData, m_MainLightACTLightData);
		cmd.SetGlobalVector(LightConstantBuffer._MainLightACTData2, m_MainLightACTLightData2);
		cmd.SetGlobalVector(LightConstantBuffer._MainLightACTData3, m_MainLightACTLightData3);
	}

	private void SetupAdditionalLightConstants(CommandBuffer cmd, ref RenderingData renderingData)
	{
		ref LightData lightData = ref renderingData.lightData;
		PreparedLightFrameData preparedLights = lightData.preparedLights;
		PreparedVisibleLight[] array = preparedLights?.visibleLights;
		int maxVisibleAdditionalLights = UniversalRenderPipeline.maxVisibleAdditionalLights;
		int num = math.min(lightData.additionalLightsCount, maxVisibleAdditionalLights);
		if (lightData.mainLightIndex >= 0)
		{
			m_MainLightIndex = (ushort)lightData.mainLightIndex;
		}
		else
		{
			m_MainLightIndex = ushort.MaxValue;
		}
		if (num > 0 && array != null)
		{
			int i = 0;
			int num2 = 0;
			for (; i < preparedLights.visibleLightCount; i++)
			{
				if (num2 >= maxVisibleAdditionalLights)
				{
					break;
				}
				if (lightData.mainLightIndex != i)
				{
					ref PreparedVisibleLight reference = ref array[i];
					m_AdditionalLightPositions[num2] = reference.position;
					m_AdditionalLightColors[num2] = reference.color;
					m_AdditionalLightAttenuations[num2] = reference.attenuation;
					m_AdditionalLightSpotDirections[num2] = reference.spotDirection;
					m_AdditionalLightsLayerMasks[num2] = math.asfloat(reference.layerMask);
					m_AdditionalLightACTData[num2] = reference.actData;
					m_AdditionalLightACTData2[num2] = reference.actData2;
					m_AdditionalLightACTData3[num2] = reference.actData3;
					num2++;
				}
			}
			cmd.SetGlobalVectorArray(LightConstantBuffer._AdditionalLightsPosition, m_AdditionalLightPositions);
			cmd.SetGlobalVectorArray(LightConstantBuffer._AdditionalLightsColor, m_AdditionalLightColors);
			cmd.SetGlobalVectorArray(LightConstantBuffer._AdditionalLightsAttenuation, m_AdditionalLightAttenuations);
			cmd.SetGlobalVectorArray(LightConstantBuffer._AdditionalLightsSpotDir, m_AdditionalLightSpotDirections);
			cmd.SetGlobalFloatArray(LightConstantBuffer._AdditionalLightsLayerMasks, m_AdditionalLightsLayerMasks);
			cmd.SetGlobalVectorArray(LightConstantBuffer._AdditionalLightsACTData, m_AdditionalLightACTData);
			cmd.SetGlobalVectorArray(LightConstantBuffer._AdditionalLightsACTData2, m_AdditionalLightACTData2);
			cmd.SetGlobalVectorArray(LightConstantBuffer._AdditionalLightsACTData3, m_AdditionalLightACTData3);
			cmd.SetGlobalVector(LightConstantBuffer._AdditionalLightsCount, new Vector4(lightData.maxPerObjectAdditionalLightsCount, 0f, 0f, 0f));
		}
		else
		{
			cmd.SetGlobalVector(LightConstantBuffer._AdditionalLightsCount, Vector4.zero);
		}
	}

	public void GetMainLightData(out Vector4 lightPos, out Vector4 lightColor, out int lightLayerMask)
	{
		lightPos = m_MainLightPosition;
		lightColor = m_MainLightColor;
		lightLayerMask = m_MainLightLayerMask;
	}

	public void GetLightData(NativeArray<VisibleLight> visibleLights, ushort visLightIndex, out Vector4 lightPos, out Vector4 lightColor, out Vector4 lightAttenuation, out Vector4 lightSpotDir, out Vector4 lightOcclusionProbeChannel, out int lightLayerMask, out Vector4 lightACTData, out Vector4 lightACTData2, out Vector4 lightACTData3)
	{
		if (m_MainLightIndex < visLightIndex)
		{
			visLightIndex--;
		}
		if (visLightIndex < m_AdditionalLightPositions.Length)
		{
			lightPos = m_AdditionalLightPositions[visLightIndex];
			lightColor = m_AdditionalLightColors[visLightIndex];
			lightAttenuation = m_AdditionalLightAttenuations[visLightIndex];
			lightSpotDir = m_AdditionalLightSpotDirections[visLightIndex];
			lightOcclusionProbeChannel = Vector4.zero;
			lightLayerMask = math.asint(m_AdditionalLightsLayerMasks[visLightIndex]);
			lightACTData = m_AdditionalLightACTData[visLightIndex];
			lightACTData2 = m_AdditionalLightACTData2[visLightIndex];
			lightACTData3 = m_AdditionalLightACTData3[visLightIndex];
		}
		else
		{
			UniversalRenderPipeline.InitializeLightConstants_Common(visibleLights, visLightIndex, out lightPos, out lightColor, out lightAttenuation, out lightSpotDir, out lightOcclusionProbeChannel, out lightACTData, out lightACTData2, out lightACTData3);
			Light light = visibleLights[visLightIndex].light;
			lightLayerMask = (int)((light != null) ? light.GetUniversalAdditionalLightData().lightLayerMask : LightLayerEnum.Nothing);
		}
	}
}
