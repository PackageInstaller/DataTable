using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.Serialization;

namespace Ase.Paradox;

[Name("相机抖动", 0)]
[Category("✫ DragonLost/Camera")]
[Description("使相机产生抖动效果")]
public class ShakeCamera : ActionTaskBase
{
	[RequiredField]
	[Name("抖动权重", 0)]
	[Description("权重大的会替换掉权重低的抖动数据")]
	public BBParameter<float> Weight;

	[FormerlySerializedAs("blendTime")]
	[RequiredField]
	[Name("混合时间", 0)]
	[Description("此节点震屏打断其他震屏时，振幅会根据混入时间平滑过渡到此震屏。")]
	public BBParameter<float> intensityBlendTime = 0f;

	[RequiredField]
	[Name("抖动强度", 0)]
	[Description("抖动的强度，值越大抖动越剧烈。")]
	public BBParameter<float> strength = 3f;

	[Name("强度衰减曲线名", 0)]
	[Description("默认为空，即不衰减。")]
	public string strengCurveName = "";

	[Name("使用自定义强度衰减曲线", 0)]
	[Description("默认为false，开启后，忽略【强度衰减曲线名】，新增曲线可以编辑。")]
	public bool useCustomStrengCurve;

	[Name("自定义强度衰减曲线", 0)]
	[Description("自定义强度衰减曲线")]
	[ShowIf("useCustomStrengCurve", 1)]
	public AnimationCurve customStrengCurve;

	[RequiredField]
	[Name("抖动速度", 0)]
	[Description("抖动的速度，值越大抖动越块。")]
	public BBParameter<float> frequency = 1f;

	[Name("速度衰减曲线名", 0)]
	[Description("默认为空，即不衰减。")]
	public string frequencyCurveName = "";

	[Name("使用自定义抖动速度衰减曲线", 0)]
	[Description("默认为false，开启后，忽略【速度衰减曲线名】，新增曲线可以编辑。")]
	public bool useCustomFrequencyCurve;

	[Name("自定义速度衰减曲线", 0)]
	[Description("自定义速度衰减曲线")]
	[ShowIf("useCustomFrequencyCurve", 1)]
	public AnimationCurve customFrequencyCurve;

	[RequiredField]
	[Name("持续时间", 0)]
	[Description("抖动的持续时间，单位为秒。")]
	public BBParameter<float> duration = 0.1f;

	[Name("是否是全局抖动", 0)]
	[Description("是否应用于全局相机。")]
	public bool IsGlobal;

	[Name("噪音曲线名字", 0)]
	[Description("噪音曲线配置")]
	public string NoiseName;

	[Name("启用随机噪音起点", 0)]
	[Description("默认为空，即不勾选，也就是默认关闭随机噪音起点。勾选后，开启随机噪音起点")]
	public bool UseRandomNoise;

	[Name("是否随行为树还原", 0)]
	public bool OnTreeEndReduction;

	private int cameraShakeIndex;

	protected override void OnExecute()
	{
		base.OnExecute();
		VirtualCameraSystem system = ownerEntity.GetSystem<VirtualCameraSystem>();
		if (system == null)
		{
			OnActionFinish();
			return;
		}
		cameraShakeIndex = system.GetCameraShakeIndex();
		if (!IsGlobal && ownerEntity.Id != ownerEntity.GetWorld().ActorId && !system.GetSummonedCanShake(ownerEntity))
		{
			OnActionFinish();
			cameraShakeIndex = 0;
			return;
		}
		AnimationCurve animationCurve = null;
		if (!useCustomStrengCurve)
		{
			animationCurve = system.GetIntensityCurveData(strengCurveName)?.CurveValue;
		}
		AnimationCurve animationCurve2 = null;
		if (!useCustomFrequencyCurve)
		{
			animationCurve2 = system.GetFrequencyCurveData(frequencyCurveName)?.CurveValue;
		}
		system.SetCameraShakeParam(Weight.value, duration.value, strength.value, frequency.value, NoiseName, useCustomStrengCurve ? customStrengCurve : animationCurve, useCustomFrequencyCurve ? customFrequencyCurve : animationCurve2, intensityBlendTime.value, UseRandomNoise, cameraShakeIndex);
		OnActionFinish();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (ownerEntity != null && OnTreeEndReduction && cameraShakeIndex != 0)
		{
			ownerEntity.GetSystem<VirtualCameraSystem>()?.ClearCameraShake(cameraShakeIndex);
		}
	}
}
