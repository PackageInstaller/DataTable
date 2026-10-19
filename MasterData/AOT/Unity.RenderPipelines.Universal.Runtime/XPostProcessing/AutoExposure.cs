using UnityEngine;
using UnityEngine.Rendering;

namespace XPostProcessing;

[VolumeComponentMenu("X-Post-processing/图像处理 (Image Processing)/自动曝光(Auto Exposure)")]
public class AutoExposure : VolumeSetting
{
	private const int CurrentParameterVersion = 2;

	private const float MinimumLuminance = 0.001f;

	private const float DefaultExposureMin = 0.5f;

	public static bool s_Enable = true;

	public BoolParameter enable = new BoolParameter(value: false);

	public Vector2Parameter filtering = new Vector2Parameter(new Vector2(0f, 100f));

	public ClampedFloatParameter ExposureSpeed = new ClampedFloatParameter(2f, 0f, 20f);

	public ClampedFloatParameter ExposureMin = new ClampedFloatParameter(0.5f, 0f, 5f);

	public ClampedFloatParameter ExposureMax = new ClampedFloatParameter(15f, 0f, 200f);

	public MinIntParameter HistogramBinCount = new MinIntParameter(64, 64);

	public MinFloatParameter GlobalScale = new MinFloatParameter(3.5f, 0f);

	public MinFloatParameter powY = new MinFloatParameter(3f, 0f);

	[SerializeField]
	[HideInInspector]
	private ClampedFloatParameter m_LegacyExposureMin = new ClampedFloatParameter(-1f, -1f, 5f);

	[HideInInspector]
	[SerializeField]
	private ClampedFloatParameter m_LegacyExposureMax = new ClampedFloatParameter(-1f, -1f, 200f);

	[HideInInspector]
	[SerializeField]
	private ClampedFloatParameter HistogramLogMin = new ClampedFloatParameter(-6.643856f, -16f, 16f);

	[HideInInspector]
	[SerializeField]
	private ClampedFloatParameter HistogramLogMax = new ClampedFloatParameter(3.906891f, -16f, 16f);

	[HideInInspector]
	[SerializeField]
	private int m_ParameterVersion;

	protected override void OnEnable()
	{
		bool flag = ExposureMin.overrideState || ExposureMax.overrideState || !Mathf.Approximately(ExposureMin.value, 0.5f) || !Mathf.Approximately(ExposureMax.value, 15f);
		bool flag2 = HistogramLogMin.overrideState || HistogramLogMax.overrideState || !Mathf.Approximately(HistogramLogMin.value, -6.643856f) || !Mathf.Approximately(HistogramLogMax.value, 3.906891f);
		if (m_ParameterVersion == 1)
		{
			if (m_LegacyExposureMin != null && m_LegacyExposureMin.value >= 0f)
			{
				ExposureMin.value = m_LegacyExposureMin.value;
				ExposureMin.overrideState = m_LegacyExposureMin.overrideState;
			}
			else
			{
				ExposureMin.value = Mathf.Pow(2f, HistogramLogMin.value);
				ExposureMin.overrideState = HistogramLogMin.overrideState;
			}
			if (m_LegacyExposureMax != null && m_LegacyExposureMax.value >= 0f)
			{
				ExposureMax.value = m_LegacyExposureMax.value;
				ExposureMax.overrideState = m_LegacyExposureMax.overrideState;
			}
			else
			{
				ExposureMax.value = Mathf.Pow(2f, HistogramLogMax.value);
				ExposureMax.overrideState = HistogramLogMax.overrideState;
			}
		}
		else if ((m_ParameterVersion == 0 && !flag) & flag2)
		{
			ExposureMin.value = Mathf.Pow(2f, HistogramLogMin.value);
			ExposureMin.overrideState = HistogramLogMin.overrideState;
			ExposureMax.value = Mathf.Pow(2f, HistogramLogMax.value);
			ExposureMax.overrideState = HistogramLogMax.overrideState;
		}
		ExposureMin.value = Mathf.Max(0.001f, ExposureMin.value);
		ExposureMax.value = Mathf.Max(ExposureMin.value, ExposureMax.value);
		m_ParameterVersion = 2;
		base.OnEnable();
	}

	public override bool IsActive()
	{
		if (s_Enable)
		{
			return enable.value;
		}
		return false;
	}
}
