namespace UnityEngine.Rendering.Universal;

public class LightHaloPass : ScriptableRenderPass
{
	private struct VisibleBufferStruct
	{
		public Vector4 positionAndVisible;

		public Vector4 lightTypeAndDepth;
	}

	private static class ShaderConstants
	{
		internal static readonly int _CurrentLightIndex = Shader.PropertyToID("_CurrentLightIndex");

		internal static readonly int _CheckData = Shader.PropertyToID("_CheckData");

		internal static readonly int _ControlColor = Shader.PropertyToID("_ControlColor");

		internal static readonly int _ControlAlpha = Shader.PropertyToID("_ControlAlpha");

		internal static readonly int _MainLightVisIndex = Shader.PropertyToID("_MainLightVisIndex");

		internal static readonly int _HaloSize = Shader.PropertyToID("_HaloSize");

		internal static readonly int _HaloRotation = Shader.PropertyToID("_BoardRotation");

		internal static readonly int _HaloOffset = Shader.PropertyToID("_HaloOffset");

		internal static readonly int _AdditionalLightHaloScreenScale = Shader.PropertyToID("_AdditionalLightHaloScreenScale");

		internal static readonly int _LightVisibleBuffer = Shader.PropertyToID("_LightVisibleBuffer");

		internal static readonly int _LightVisibleCount = Shader.PropertyToID("_LightVisibleCount");
	}

	private ComputeBuffer m_VisibleBuffer;

	private readonly VisibleBufferStruct[] m_VisibleData;

	private readonly ComputeShader m_VisibleShader;

	private readonly int m_VisibilityKernel;

	private LightHaloCandidate[] m_Candidates;

	private int m_CandidateCount;

	private int m_MainDispatchIndex;

	private Vector3 m_CameraPosition;

	public float searchRadius = 2f;

	public Vector2 additionalLightHaloScaleRange = new Vector2(0f, 100f);

	public float additionalLightHaloDistanceDecay = 0.3f;

	public float additionalLightHaloFadeDistance = 20f;

	public LightHaloPass(ComputeShader shader)
		: this(shader, null)
	{
	}

	internal LightHaloPass(ComputeShader shader, LightHaloFeature.Settings settings)
	{
		int num = UniversalRenderPipeline.maxVisibleAdditionalLights + 1;
		m_VisibleData = new VisibleBufferStruct[num];
		m_VisibleShader = shader;
		m_VisibilityKernel = ((shader != null) ? shader.FindKernel("SunVisibility") : (-1));
		if (settings != null)
		{
			setData(settings);
		}
		if (shader != null)
		{
			m_VisibleBuffer = new ComputeBuffer(num, 32);
		}
		profilingSampler = new ProfilingSampler("LightHaloPass");
		renderPassEvent = RenderPassEvent.LightHaloPass;
		targetCount = 1u;
	}

	internal bool Setup(LightHaloFeature.Settings settings)
	{
		setData(settings);
		if (m_VisibleShader != null && m_VisibleBuffer != null)
		{
			return m_VisibilityKernel >= 0;
		}
		return false;
	}

	private bool PrepareCandidates(ref RenderingData renderingData)
	{
		PreparedLightFrameData preparedLights = renderingData.lightData.preparedLights;
		m_Candidates = preparedLights?.haloCandidates;
		m_CandidateCount = preparedLights?.haloCandidateCount ?? 0;
		m_MainDispatchIndex = -1;
		if (m_VisibleShader == null || m_VisibleBuffer == null || m_VisibilityKernel < 0 || m_Candidates == null || m_CandidateCount == 0)
		{
			m_CandidateCount = 0;
			return false;
		}
		Camera camera = renderingData.cameraData.camera;
		m_CameraPosition = camera.transform.position;
		int mainLightIndex = renderingData.lightData.mainLightIndex;
		for (int i = 0; i < m_CandidateCount; i++)
		{
			LightHaloCandidate lightHaloCandidate = m_Candidates[i];
			Vector3 vector;
			if (lightHaloCandidate.visibleLightIndex == mainLightIndex)
			{
				vector = m_CameraPosition - lightHaloCandidate.forward * 5000f;
				m_MainDispatchIndex = i;
			}
			else
			{
				vector = lightHaloCandidate.position;
			}
			m_VisibleData[i].positionAndVisible = new Vector4(vector.x, vector.y, vector.z, 0f);
			m_VisibleData[i].lightTypeAndDepth = new Vector4((lightHaloCandidate.lightType == LightType.Directional) ? 1f : 0f, lightHaloCandidate.haloData.DepthOffset, 0f, 0f);
		}
		return true;
	}

	public void setData(LightHaloFeature.Settings settings)
	{
		searchRadius = settings.searchWidth;
		additionalLightHaloScaleRange = settings.additionalLightHaloScaleRange;
		additionalLightHaloDistanceDecay = Mathf.Max(0f, settings.additionalLightHaloDistanceDecay);
		additionalLightHaloFadeDistance = Mathf.Max(0f, settings.additionalLightHaloFadeDistance);
	}

	public void Release()
	{
		if (m_VisibleBuffer != null)
		{
			m_VisibleBuffer.Release();
			m_VisibleBuffer = null;
		}
	}

	private bool TryGetAdditionalLightHaloData(Vector3 position, float minDistance, float maxDistance, float maxDistanceSqr, float fadeStartDistance, out float screenScale, out float fadeAlpha)
	{
		float sqrMagnitude = (position - m_CameraPosition).sqrMagnitude;
		if (sqrMagnitude >= maxDistanceSqr)
		{
			screenScale = 0f;
			fadeAlpha = 0f;
			return false;
		}
		float num = Mathf.Sqrt(sqrMagnitude);
		float num2 = Mathf.Max(0f, num - minDistance);
		screenScale = Mathf.Exp((0f - additionalLightHaloDistanceDecay) * num2);
		fadeAlpha = ((num <= fadeStartDistance) ? 1f : Mathf.InverseLerp(maxDistance, fadeStartDistance, num));
		return fadeAlpha > 0f;
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		if (!PrepareCandidates(ref renderingData))
		{
			return;
		}
		CommandBuffer cmd = renderingData.cmd;
		cmd.BeginSample("LightHaloPass");
		cmd.SetBufferData(m_VisibleBuffer, m_VisibleData, 0, 0, m_CandidateCount);
		cmd.SetGlobalFloat(ShaderConstants._LightVisibleCount, m_CandidateCount);
		cmd.SetComputeBufferParam(m_VisibleShader, m_VisibilityKernel, ShaderConstants._LightVisibleBuffer, m_VisibleBuffer);
		cmd.SetComputeFloatParam(m_VisibleShader, ShaderConstants._CheckData, searchRadius);
		cmd.SetComputeFloatParam(m_VisibleShader, ShaderConstants._MainLightVisIndex, m_MainDispatchIndex);
		cmd.DispatchCompute(m_VisibleShader, m_VisibilityKernel, m_CandidateCount, 1, 1);
		cmd.SetGlobalBuffer(ShaderConstants._LightVisibleBuffer, m_VisibleBuffer);
		float num = Mathf.Max(0f, Mathf.Min(additionalLightHaloScaleRange.x, additionalLightHaloScaleRange.y));
		float num2 = Mathf.Max(num, Mathf.Max(additionalLightHaloScaleRange.x, additionalLightHaloScaleRange.y));
		float maxDistanceSqr = num2 * num2;
		float fadeStartDistance = Mathf.Max(num, num2 - additionalLightHaloFadeDistance);
		for (int i = 0; i < m_CandidateCount; i++)
		{
			LightHaloCandidate lightHaloCandidate = m_Candidates[i];
			LightHalo haloData = lightHaloCandidate.haloData;
			Vector4 positionAndVisible = m_VisibleData[i].positionAndVisible;
			Vector3 vector = new Vector3(positionAndVisible.x, positionAndVisible.y, positionAndVisible.z);
			cmd.SetGlobalFloat(ShaderConstants._CurrentLightIndex, i);
			if (i != m_MainDispatchIndex || lightHaloCandidate.lightType != LightType.Directional)
			{
				if (!TryGetAdditionalLightHaloData(vector, num, num2, maxDistanceSqr, fadeStartDistance, out var screenScale, out var fadeAlpha))
				{
					continue;
				}
				cmd.SetGlobalFloat(ShaderConstants._ControlAlpha, haloData.Intensity * fadeAlpha);
				cmd.SetGlobalFloat(ShaderConstants._AdditionalLightHaloScreenScale, screenScale);
				Matrix4x4 o2WMatrix = Matrix4x4.TRS(vector, Quaternion.identity, Vector3.one);
				for (int j = 0; j < haloData.HaloData.Count; j++)
				{
					LightHalo.LightHaloData lightHaloData = haloData.HaloData[j];
					if (!(lightHaloData.material == null))
					{
						cmd.SetGlobalVector(ShaderConstants._ControlColor, lightHaloData.color);
						cmd.SetGlobalVector(ShaderConstants._HaloSize, lightHaloData.size);
						cmd.SetGlobalFloat(ShaderConstants._HaloRotation, lightHaloData.rotation);
						ACTRenderingFunction.ACT_DrawBoard(cmd, o2WMatrix, lightHaloData.material, 0);
					}
				}
				cmd.SetGlobalFloat(ShaderConstants._AdditionalLightHaloScreenScale, 0f);
				continue;
			}
			cmd.SetGlobalFloat(ShaderConstants._AdditionalLightHaloScreenScale, 0f);
			cmd.SetGlobalFloat(ShaderConstants._ControlAlpha, haloData.Intensity);
			for (int k = 0; k < haloData.HaloData.Count; k++)
			{
				LightHalo.LightHaloData lightHaloData2 = haloData.HaloData[k];
				if (!(lightHaloData2.material == null))
				{
					cmd.SetGlobalVector(ShaderConstants._ControlColor, lightHaloData2.color);
					cmd.SetGlobalFloat(ShaderConstants._HaloRotation, lightHaloData2.rotation);
					cmd.SetGlobalFloat(ShaderConstants._HaloOffset, lightHaloData2.offset);
					cmd.SetGlobalVector(ShaderConstants._HaloSize, lightHaloData2.size);
					ACTRenderingFunction.ACT_DrawBoard(cmd, Matrix4x4.identity, lightHaloData2.material, 0);
				}
			}
		}
		cmd.EndSample("LightHaloPass");
		m_CandidateCount = 0;
	}
}
