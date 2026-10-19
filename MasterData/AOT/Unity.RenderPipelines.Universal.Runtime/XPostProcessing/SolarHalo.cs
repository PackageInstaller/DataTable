using UnityEngine;
using UnityEngine.Rendering;

namespace XPostProcessing;

[VolumeComponentMenu("X-Post-processing/环境后效 (Environment)/太阳光晕(Solar Halo)")]
public class SolarHalo : VolumeSetting
{
	[Tooltip("天空辉光强度")]
	public MinFloatParameter SkyLightIntensity = new MinFloatParameter(0f, 0f, overrideState: true);

	[Tooltip("天空辉光阈值")]
	public ClampedFloatParameter SkyLightThreshold = new ClampedFloatParameter(0.45f, 0f, 5f);

	[Tooltip("天空辉光钳制")]
	public MinFloatParameter SkyLightClamp = new MinFloatParameter(2f, 0f, overrideState: true);

	[Tooltip("天空辉光半径")]
	public ClampedFloatParameter radius = new ClampedFloatParameter(0.2f, 0f, 1f, overrideState: true);

	[Tooltip("天空辉光步数")]
	public MinIntParameter Step = new MinIntParameter(8, 1, overrideState: true);

	[Tooltip("天空辉光循环")]
	public MinIntParameter Interate = new MinIntParameter(4, 1, overrideState: true);

	[Tooltip("天空辉光降采样")]
	public MinIntParameter downSample = new MinIntParameter(2, 1, overrideState: true);

	[Tooltip("启用后使用自定义屏幕坐标作为模糊中心")]
	public BoolParameter UseCustomBlurCenter = new BoolParameter(value: false);

	[Tooltip("自定义模糊中心，(0,0) 为左上角，(1,1) 为右下角")]
	public Vector2Parameter CustomBlurCenter = new Vector2Parameter(new Vector2(0.5f, 0.5f));

	[Tooltip("启用后不再过滤非天空像素，对全屏颜色进行后续处理")]
	public BoolParameter DisableSkyOnly = new BoolParameter(value: false);

	public override bool IsActive()
	{
		return SkyLightIntensity.value > 0f;
	}

	public override string GetShaderName()
	{
		return "Hidden/PostProcessing/SolarHalo";
	}
}
