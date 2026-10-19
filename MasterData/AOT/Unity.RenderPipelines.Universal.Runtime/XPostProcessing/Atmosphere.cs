using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Serialization;

namespace XPostProcessing;

[VolumeComponentMenu("X-Post-processing/环境后效 (Environment)/大气 (Atmosphere)")]
public class Atmosphere : VolumeSetting
{
	[Tooltip("启用天空散射 LUT 更新。Procedural SkyBox 依赖此项。")]
	public BoolParameter RefreshActive = new BoolParameter(value: false);

	[Tooltip("太阳时间：0/24=午夜，6=日出，12=正午，18=日落。锁定主光后不生效。")]
	public ClampedFloatParameter TimeOfDay = new ClampedFloatParameter(8f, 0f, 24f);

	[Tooltip("启用后，太阳方向直接使用主平行光的 -transform.forward，并忽略 Time Of Day。")]
	public BoolParameter LockToMainLight = new BoolParameter(value: false);

	[Tooltip("米氏散射强度 [0, 0.05]：0.01~0.025 晴朗，0.025~0.04 薄雾，0.04 以上明显雾感。")]
	public ClampedFloatParameter MieIntensity = new ClampedFloatParameter(0.02f, 0f, 0.05f);

	[Tooltip("米氏前向散射系数 [0, 0.95]：0.6~0.8 自然，0.8~0.9 太阳光晕集中，接近 0.95 时高光非常尖锐。")]
	public ClampedFloatParameter MieFactor = new ClampedFloatParameter(0.7f, 0f, 0.95f);

	[Tooltip("米氏密度标高 [100, 5000] 米：800~1500 自然；越低越贴近地面，越高则高空雾感越明显。")]
	public ClampedFloatParameter MieHeight = new ClampedFloatParameter(1200f, 100f, 5000f);

	[Tooltip("瑞利散射强度 [0.5, 5]：0.8~1.3 为自然蓝天，1.3~2 更饱和，2 以上偏风格化。")]
	public ClampedFloatParameter RayleighIntensity = new ClampedFloatParameter(1f, 0.5f, 5f);

	[Tooltip("臭氧吸收强度 [0, 0.01]：0.001~0.004 为常用范围。使用静态 EXR 时，太阳入射透射仍由烘焙值决定。")]
	public ClampedFloatParameter OzoneIntensity = new ClampedFloatParameter(0.002f, 0f, 0.01f);

	[Tooltip("多重散射强度 [0, 1]：0 关闭；0.1~0.4 增加天空填充光；接近 1 时天空容易变平变亮。PC 调度动态计算，Mobile 调度使用静态 multiscatter.exr，不运行 MultiScatter Compute。")]
	public ClampedFloatParameter MultiScatterIntensity = new ClampedFloatParameter(0f, 0f, 1f);

	[Tooltip("天空散射使用的太阳 HDR 颜色，不读取主平行光颜色和强度。最终 HDR RGB 分量：自然晴天约 12~20，明亮卡通晴天约 18~30。这里指展开后的 RGB 数值，不是颜色窗口的 Intensity 滑条值。")]
	public ColorParameter SunColor = new ColorParameter(new Color(10f, 10f, 10f, 1f), hdr: true, showAlpha: true, showEyeDropper: true, overrideState: true);

	[Tooltip("月亮散射 HDR 颜色。白天建议黑色；夜景根据曝光使用约 0.1~2 的强度。")]
	public ColorParameter MoonColor = new ColorParameter(Color.black, hdr: true, showAlpha: true, showEyeDropper: true, overrideState: true);

	[FormerlySerializedAs("HorizonOffset")]
	[FormerlySerializedAs("HorizonExtension")]
	[Tooltip("垂直旋转天空球的采样方向，但不旋转实际相机。设置为 18 度时，天空效果等同于相机向上仰 18 度。")]
	public ClampedFloatParameter SkyVerticalRotation = new ClampedFloatParameter(0f, -45f, 45f, overrideState: true);

	[Tooltip("启用后运行时分帧生成透射 LUT；关闭时使用静态 Atmosphere.exr。")]
	public BoolParameter RefreshAtmosphereLUT = new BoolParameter(value: false);

	[Tooltip("启用场景空气透视。PC Schedule 的 Deferred 使用半分辨率 Ray March；Mobile Schedule 使用缓存的深度近似 LUT。")]
	public BoolParameter SceneScatter = new BoolParameter(value: false);

	[HideInInspector]
	public SceneScatterQualityParameter SceneScatterQuality = new SceneScatterQualityParameter(XPostProcessing.SceneScatterQuality.Automatic);

	[Tooltip("Mobile Schedule Depth LUT 来源。Runtime 在参数变化时重算 64x32 LUT；Precomputed 优先使用 Renderer Data 中配置的静态纹理，未配置时回退 Runtime。")]
	public SceneScatterDepthLutSourceParameter SceneScatterDepthLutSource = new SceneScatterDepthLutSourceParameter(XPostProcessing.SceneScatterDepthLutSource.Runtime);

	[Tooltip("播片实时场景散射模式。仅 Scene Scatter 开启时生效。")]
	public BoolParameter RealTimeSceneScatter = new BoolParameter(value: false);

	[Tooltip("场景散射追踪步数 [4, 300]：16~64 性能优先，64~128 高质量，128 以上成本很高。")]
	public ClampedIntParameter SceneScatterIteration = new ClampedIntParameter(50, 4, 300);

	[Tooltip("场景散射追踪距离 [10, 3000] 米：50~300 常规场景，300~1000 大型室外。")]
	public ClampedFloatParameter SceneScatterLength = new ClampedFloatParameter(100f, 10f, 3000f);

	[Tooltip("场景散射密度 [0, 0.05]：0.002~0.015 自然空气透视，0.015~0.03 薄雾，0.03 以上浓雾。")]
	public ClampedFloatParameter SceneScatterDensity = new ClampedFloatParameter(0.01f, 0f, 0.05f);

	[Tooltip("场景散射米氏前向系数 [0, 0.95]：0.6~0.8 自然，越高越集中在光源方向。")]
	public ClampedFloatParameter SceneMieScatterFactor = new ClampedFloatParameter(0.7f, 0f, 0.95f);

	[Tooltip("场景空气散射 HDR 色调。白色保持物理颜色，染色用于风格化天气。")]
	public ColorParameter AirScatterColor = new ColorParameter(Color.white, hdr: true, showAlpha: true, showEyeDropper: true);

	[Tooltip("场景散射最终强度。默认 5 用于兼容旧实现的五倍虚拟积分距离，但不再改变真实采样位置和高度。")]
	public ClampedFloatParameter SceneScatterIntensity = new ClampedFloatParameter(5f, 0f, 20f);

	[Tooltip("场景散射使用的相机大气海拔（米）。用于 Rayleigh/Mie 密度和太阳/月亮入射透射。")]
	public ClampedFloatParameter SceneScatterCameraHeight = new ClampedFloatParameter(1500f, 0f, 20000f);

	[Tooltip("Scene Scatter 中附加灯光的散射倍率 [0, 100]：0 关闭，0.5~2 自然，2~10 风格化，10 以上容易过曝。")]
	public ClampedFloatParameter AddLitIntensity = new ClampedFloatParameter(1f, 0f, 100f, overrideState: true);

	public override bool IsActive()
	{
		if (!RefreshActive.value && !RefreshAtmosphereLUT.value)
		{
			return SceneScatter.value;
		}
		return true;
	}
}
