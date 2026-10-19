using UnityEngine;
using UnityEngine.Rendering;

namespace XPostProcessing;

[VolumeComponentMenu("X-Post-processing/环境后效 (Environment)/指数高度雾 (exp height fog)")]
public class ExpHeightFog : VolumeComponent
{
	[Tooltip("雾密度")]
	public MinFloatParameter fogDensity = new MinFloatParameter(0f, 0f);

	[Tooltip("海平高度")]
	public FloatParameter seaLevel = new FloatParameter(0f);

	[Tooltip("高度指数")]
	public MinFloatParameter heightFactor = new MinFloatParameter(0.5f, 0f);

	[Tooltip("高度颜色")]
	public ColorParameter heightFogColor = new ColorParameter(Color.white, hdr: true, showAlpha: true, showEyeDropper: true, overrideState: true);

	[Tooltip("净空范围")]
	public MinFloatParameter distanceFactor = new MinFloatParameter(1f, 0f);

	[Tooltip("距离钳制")]
	public MinFloatParameter distanceClamp = new MinFloatParameter(9999f, 0f);

	[Tooltip("阳光范围")]
	public ClampedFloatParameter SunFactor = new ClampedFloatParameter(1f, 0f, 2f);

	[Tooltip("阳光强度")]
	public MinFloatParameter SunIntensity = new MinFloatParameter(0f, 0f);
}
