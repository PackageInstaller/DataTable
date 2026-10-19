using UnityEngine;
using UnityEngine.Rendering;

[ExecuteAlways]
public class DirectLightControl : MonoBehaviour
{
	public bool AlwaysRefresh;

	[Range(0.001f, 3f)]
	public float m_LightIntensity = 1f;

	[Range(0.001f, 5f)]
	public float m_LightIntensityGeneric = 1f;

	[Range(0f, 5f)]
	public float m_GenericF0Multiplyer = 1f;

	[Range(0f, 1f)]
	public float m_F0Tint;

	public float m_AddLightIntensity = 0.3f;

	[Range(0f, 1f)]
	public float m_MainLightReduce = 1f;

	[Range(0f, 2f)]
	public float m_MainLightWeight = 1f;

	[Range(-1f, 1f)]
	public float m_CharMainLitControlH;

	[Range(0f, 3f)]
	public float m_CharMainLitControlS = 1f;

	[Range(0f, 3f)]
	public float m_CharAmbientIntensity = 0.1f;

	[Range(0f, 50f)]
	public float m_CharAddLightColorClamp = 10f;

	public Color m_CharShadowColor = Color.white;

	[Range(0f, 4f)]
	public float m_CharDepthLightWidth = 0.5f;

	[Range(0f, 10f)]
	public float m_CharDepthLightIntensity = 1f;

	[Range(0f, 10f)]
	public float m_CharDepthLightClamp = 3f;

	[Range(0f, 6f)]
	public float m_RimIntensity = 1f;

	[Range(0f, 2f)]
	public float m_RimWidth = 0.5f;

	public bool m_MainLightChange = true;

	[ColorUsage(true, true)]
	public Color m_shadowColorSky;

	[ColorUsage(true, true)]
	public Color m_shadowColorHorizon;

	[ColorUsage(true, true)]
	public Color m_shadowColorGround;

	[ColorUsage(false, true)]
	public Color m_halfShadowColorNew = Color.black;

	public float m_halfShadowCurve = 1f;

	[ColorUsage(false, true)]
	public Color m_AOColor = Color.black;

	public static float CharLightIntensity = 1f;

	public static float LightIntensity = 1f;

	public static float LightIntensityGeneric = 1f;

	public static float GenericF0Multiplyer = 2f;

	public static float F0Tint = 0f;

	public static float AddLightIntensity = 0.3f;

	public static float MainLightReduce = 1f;

	public static float MainLightWeight = 1f;

	public static float CharMainLitControlH = 0f;

	public static float CharMainLitControlS = 1f;

	public static float CharAmbientIntensity = 0.1f;

	public static float CharAddLightColorClamp = 10f;

	public static Color CharShadowColor = Color.white;

	public static float CharDepthLightWidth = 0.1f;

	public static float CharDepthLightIntensity = 1f;

	public static float CharDepthLightClamp = 3f;

	public static float RimIntensity = 1f;

	public static float RimWidth = 0.5f;

	public static bool MainLightChange = true;

	public static Vector4 halfShadowColor = new Vector3(1f, 1.4f, 1.5f);

	public static Vector4 AOColor = new Vector4(0f, 0f, 0f, 0f);

	public static Vector4 shadowColorGround;

	public static Vector4 shadowColorHorizon;

	public static Vector4 shadowColorSky;

	private static bool IsActive;

	private bool dirt;

	public static Light m_MainLight;

	private static readonly int ShadowColorGroundID = Shader.PropertyToID("_ShadowColorGround");

	private static readonly int ShadowColorHorizonID = Shader.PropertyToID("_ShadowColorHorizon");

	private static readonly int ShadowColorSkyID = Shader.PropertyToID("_ShadowColorSky");

	private static readonly int ToonLightDataID = Shader.PropertyToID("_Toon_LightData");

	private static readonly int ToonLightData2ID = Shader.PropertyToID("_Toon_LightData2");

	private static readonly int CharMainLitColorControlID = Shader.PropertyToID("_CharMainLitColorControl");

	private static readonly int CharShadowColorID = Shader.PropertyToID("_CharShadowColor");

	private static readonly int CharRimLightWidthID = Shader.PropertyToID("_CharRimLightWidth");

	private static readonly int RimIntensityID = Shader.PropertyToID("_RimIntensity");

	private static readonly int GenericRimWidthID = Shader.PropertyToID("_GenericRimWidth");

	private static readonly int SSSScatterID = Shader.PropertyToID("_SSSScatter");

	private static readonly int GenericAOColorID = Shader.PropertyToID("_GenericAOColor");

	public static void VolumeReplaceShadowColor(Vector4 colorGround, Vector4 colorHorizon, Vector4 colorSky)
	{
		shadowColorGround = colorGround;
		shadowColorHorizon = colorHorizon;
		shadowColorSky = colorSky;
	}

	private void OnEnable()
	{
		if (!IsActive)
		{
			IsActive = true;
		}
		setDirt();
	}

	public static void RefreshGPUData(CommandBuffer cmd)
	{
		cmd.SetGlobalVector(ToonLightDataID, new Vector4(Mathf.Max(LightIntensity, 0f), LightIntensityGeneric, Mathf.Max(AddLightIntensity, 0f), CharAddLightColorClamp));
		cmd.SetGlobalVector(ToonLightData2ID, new Vector4(Mathf.Max(CharLightIntensity, 0f), F0Tint, GenericF0Multiplyer, MainLightWeight));
		cmd.SetGlobalVector(CharMainLitColorControlID, new Vector4(CharMainLitControlH, CharMainLitControlS, CharAmbientIntensity, MainLightReduce));
		cmd.SetGlobalColor(CharShadowColorID, Color.white - CharShadowColor);
		cmd.SetGlobalColor(ShadowColorGroundID, shadowColorGround);
		cmd.SetGlobalColor(ShadowColorHorizonID, shadowColorHorizon);
		cmd.SetGlobalColor(ShadowColorSkyID, shadowColorSky);
		cmd.SetGlobalVector(CharRimLightWidthID, new Vector4(CharDepthLightWidth, CharDepthLightIntensity, CharDepthLightClamp, 0f));
		cmd.SetGlobalFloat(RimIntensityID, RimIntensity);
		cmd.SetGlobalFloat(GenericRimWidthID, RimWidth);
		cmd.SetGlobalVector(SSSScatterID, halfShadowColor);
		cmd.SetGlobalVector(GenericAOColorID, AOColor);
	}

	public static void UpdateCharMainlightIntensity(Light mainLight)
	{
		if (mainLight != null)
		{
			float intensity = mainLight.intensity;
			float num = Mathf.Lerp(1f, 1.5f, Mathf.Clamp01((intensity - 1f) / 24f));
			if (intensity > 1f)
			{
				LightIntensity = 1f / (intensity / num);
			}
			else
			{
				LightIntensity = 1f;
			}
		}
		else
		{
			LightIntensity = 1f;
		}
	}

	private void RefreshScriptData()
	{
		CharLightIntensity = m_LightIntensity;
		if (m_MainLight != null)
		{
			UpdateCharMainlightIntensity(m_MainLight);
		}
		LightIntensityGeneric = m_LightIntensityGeneric;
		F0Tint = m_F0Tint;
		GenericF0Multiplyer = m_GenericF0Multiplyer;
		AddLightIntensity = m_AddLightIntensity;
		MainLightReduce = m_MainLightReduce;
		MainLightWeight = m_MainLightWeight;
		CharMainLitControlH = m_CharMainLitControlH;
		CharMainLitControlS = m_CharMainLitControlS;
		CharAmbientIntensity = m_CharAmbientIntensity;
		CharAddLightColorClamp = m_CharAddLightColorClamp;
		CharShadowColor = m_CharShadowColor;
		CharDepthLightWidth = m_CharDepthLightWidth;
		CharDepthLightIntensity = m_CharDepthLightIntensity;
		CharDepthLightClamp = m_CharDepthLightClamp;
		RimIntensity = m_RimIntensity;
		RimWidth = m_RimWidth;
		MainLightChange = m_MainLightChange;
		halfShadowColor = m_halfShadowColorNew;
		halfShadowColor.w = m_halfShadowCurve;
		AOColor = m_AOColor;
		shadowColorGround = m_shadowColorGround;
		shadowColorHorizon = m_shadowColorHorizon;
		shadowColorSky = m_shadowColorSky;
	}

	private void Update()
	{
		if (dirt || AlwaysRefresh)
		{
			RefreshScriptData();
			dirt = false;
		}
	}

	private void OnValidate()
	{
		setDirt();
	}

	public void setDirt()
	{
		dirt = true;
	}

	public static void SetSceneValue(float _LightIntensityChar, float _LightIntensityGeneric, Vector3 _halfShadowColor)
	{
		LightIntensity = _LightIntensityChar;
		LightIntensityGeneric = _LightIntensityGeneric;
	}
}
