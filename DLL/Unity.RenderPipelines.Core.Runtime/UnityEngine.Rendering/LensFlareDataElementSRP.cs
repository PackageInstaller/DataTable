using System;
using UnityEngine.Serialization;

namespace UnityEngine.Rendering;

[Serializable]
public sealed class LensFlareDataElementSRP
{
	public bool visible;

	public float position;

	public Vector2 positionOffset;

	public float angularOffset;

	public Vector2 translationScale;

	[Min(0f)]
	[SerializeField]
	[FormerlySerializedAs("localIntensity")]
	private float m_LocalIntensity;

	public Texture lensFlareTexture;

	public float uniformScale;

	public Vector2 sizeXY;

	public bool allowMultipleElement;

	[SerializeField]
	[FormerlySerializedAs("count")]
	[Min(1f)]
	private int m_Count;

	public bool preserveAspectRatio;

	public float rotation;

	public Color tint;

	public SRPLensFlareBlendMode blendMode;

	public bool autoRotate;

	public SRPLensFlareType flareType;

	public bool modulateByLightColor;

	[SerializeField]
	private bool isFoldOpened;

	public SRPLensFlareDistribution distribution;

	public float lengthSpread;

	public AnimationCurve positionCurve;

	public AnimationCurve scaleCurve;

	public int seed;

	public Gradient colorGradient;

	[SerializeField]
	[FormerlySerializedAs("intensityVariation")]
	[Range(0f, 1f)]
	private float m_IntensityVariation;

	public Vector2 positionVariation;

	public float scaleVariation;

	public float rotationVariation;

	public bool enableRadialDistortion;

	public Vector2 targetSizeDistortion;

	public AnimationCurve distortionCurve;

	public bool distortionRelativeToCenter;

	[SerializeField]
	[Range(0f, 1f)]
	[FormerlySerializedAs("fallOff")]
	private float m_FallOff;

	[FormerlySerializedAs("edgeOffset")]
	[Range(0f, 1f)]
	[SerializeField]
	private float m_EdgeOffset;

	[FormerlySerializedAs("sideCount")]
	[SerializeField]
	[Min(3f)]
	private int m_SideCount;

	[Range(0f, 1f)]
	[SerializeField]
	[FormerlySerializedAs("sdfRoundness")]
	private float m_SdfRoundness;

	public bool inverseSDF;

	public float uniformAngle;

	public AnimationCurve uniformAngleCurve;

	public float localIntensity
	{
		get
		{
			return m_LocalIntensity;
		}
		set
		{
			m_LocalIntensity = Mathf.Max(0f, value);
		}
	}

	public int count
	{
		get
		{
			return m_Count;
		}
		set
		{
			m_Count = Mathf.Max(1, value);
		}
	}

	public float intensityVariation
	{
		get
		{
			return m_IntensityVariation;
		}
		set
		{
			m_IntensityVariation = Mathf.Max(0f, value);
		}
	}

	public float fallOff
	{
		get
		{
			return m_FallOff;
		}
		set
		{
			m_FallOff = Mathf.Clamp01(value);
		}
	}

	public float edgeOffset
	{
		get
		{
			return m_EdgeOffset;
		}
		set
		{
			m_EdgeOffset = Mathf.Clamp01(value);
		}
	}

	public int sideCount
	{
		get
		{
			return m_SideCount;
		}
		set
		{
			m_SideCount = Mathf.Max(3, value);
		}
	}

	public float sdfRoundness
	{
		get
		{
			return m_SdfRoundness;
		}
		set
		{
			m_SdfRoundness = Mathf.Clamp01(value);
		}
	}

	public LensFlareDataElementSRP()
	{
		visible = true;
		localIntensity = 1f;
		position = 0f;
		positionOffset = new Vector2(0f, 0f);
		angularOffset = 0f;
		translationScale = new Vector2(1f, 1f);
		lensFlareTexture = null;
		uniformScale = 1f;
		sizeXY = Vector2.one;
		allowMultipleElement = false;
		count = 5;
		rotation = 0f;
		tint = new Color(1f, 1f, 1f, 0.5f);
		blendMode = SRPLensFlareBlendMode.Additive;
		autoRotate = false;
		isFoldOpened = true;
		flareType = SRPLensFlareType.Circle;
		distribution = SRPLensFlareDistribution.Uniform;
		lengthSpread = 1f;
		colorGradient = new Gradient();
		colorGradient.SetKeys(new GradientColorKey[2]
		{
			new GradientColorKey(Color.white, 0f),
			new GradientColorKey(Color.white, 1f)
		}, new GradientAlphaKey[2]
		{
			new GradientAlphaKey(1f, 0f),
			new GradientAlphaKey(1f, 1f)
		});
		positionCurve = new AnimationCurve(new Keyframe(0f, 0f, 1f, 1f), new Keyframe(1f, 1f, 1f, -1f));
		scaleCurve = new AnimationCurve(new Keyframe(0f, 1f), new Keyframe(1f, 1f));
		uniformAngleCurve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(1f, 0f));
		seed = 0;
		intensityVariation = 0.75f;
		positionVariation = new Vector2(1f, 0f);
		scaleVariation = 1f;
		rotationVariation = 180f;
		enableRadialDistortion = false;
		targetSizeDistortion = Vector2.one;
		distortionCurve = new AnimationCurve(new Keyframe(0f, 0f, 1f, 1f), new Keyframe(1f, 1f, 1f, -1f));
		distortionRelativeToCenter = false;
		fallOff = 1f;
		edgeOffset = 0.1f;
		sdfRoundness = 0f;
		sideCount = 6;
		inverseSDF = false;
	}
}
