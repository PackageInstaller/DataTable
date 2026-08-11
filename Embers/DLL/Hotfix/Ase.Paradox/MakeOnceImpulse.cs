using Ase.ECS;
using GameFramework;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("制造一次脉冲", 0)]
[Category("✫ DragonLost/Camera")]
[Description("在游戏中创造一个脉冲，在范围内的脉冲监听会响应")]
public class MakeOnceImpulse : ActionTaskBase
{
	[Name("间隔时间", 0)]
	[Description("多次脉冲之间的时间间隔")]
	public float ImpulseInterval;

	[Name("脉冲次数", 0)]
	[Description("执行几次脉冲")]
	public float ImpulseNums;

	[Name("脉冲强度", 0)]
	[Description("脉冲强度")]
	public float ImpulseForce;

	[Name("脉冲强度曲线（扩散时用） 不可为空", 0)]
	[Description("脉冲强度曲线")]
	public AnimationCurve ImpulseForceCurve;

	[Name("脉冲强度方向", 0)]
	[Description(" 脉冲强度方向")]
	public BBParameter<Vector3> ImpulseDir;

	[Name("脉冲的速度", 0)]
	[Description("脉冲扩散的速度")]
	public float ImpulseSpeed = 343f;

	[Name("脉冲的范围", 0)]
	[Description("超出范围的脉冲监听无法响应")]
	public float ImpulseDistance;

	[Name("脉冲的位置", 0)]
	[Description("脉冲开始扩散的位置")]
	public BBParameter<Vector3> ImpulsePosition;

	[Name("脉冲位置-目标id", 0)]
	[Description("脉冲位置为实体ID的位置")]
	public BBParameter<int> ImpulsePosEntityId;

	[Name("脉冲位置-目标id绑点", 0)]
	[Description("脉冲位置为实体ID绑点的位置")]
	public string ImpulsePosPoint;

	[Name("脉冲的位置偏移量", 0)]
	[Description("脉冲的位置偏移量")]
	public Vector3 ImpulsePositionOffset;

	[Name("脉冲的优先级初始值", 0)]
	[Description("脉冲的优先级初始值")]
	public float ImpulsePriority;

	[Name("脉冲的优先级时间曲线", 0)]
	[Description("脉冲的优先级时间曲线")]
	public AnimationCurve ImpulsePriorityCurve;

	[Name("脉冲的优先级距离曲线", 0)]
	[Description("脉冲的优先级距离曲线")]
	public AnimationCurve ImpulsePriorityDisCurve;

	[ParadoxNotion.Design.Header("脉冲结果参数")]
	[Name("混合时间", 0)]
	[Description("脉冲与抖动混合时间")]
	public float BlendTime;

	[Name("抖动强度", 0)]
	[Description("抖动的强度，值越大抖动越剧烈。")]
	public float IntensityInit;

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

	[Name("强度范围衰减曲线名", 0)]
	[Description("默认为空，即不衰减。")]
	public string strengRangeCurveName = "";

	[Name("使用自定义强度范围衰减曲线", 0)]
	[Description("默认为false，开启后，忽略【强度范围衰减曲线名】，新增曲线可以编辑。")]
	public bool useCustomStrengRangeCurve;

	[Name("自定义强度范围衰减曲线", 0)]
	[Description("自定义强度范围衰减曲线")]
	[ShowIf("useCustomStrengRangeCurve", 1)]
	public AnimationCurve customStrengRangeCurve;

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

	[Name("噪音曲线名字", 0)]
	[Description("噪音曲线配置")]
	public string NoiseName;

	[Name("启用随机噪音起点", 0)]
	[Description("默认为空，即不勾选，也就是默认关闭随机噪音起点。勾选后，开启随机噪音起点")]
	public bool UseRandomNoise;

	[Name("是否随行为树结束而摧毁剩余次数", 0)]
	[Description("是否随行为树结束而摧毁剩余次数")]
	public bool FollowTree;

	private int impulseUniqueIndex;

	protected override void OnExecute()
	{
		base.OnExecute();
		VirtualCameraSystem system = ownerEntity.GetSystem<VirtualCameraSystem>();
		if (system == null)
		{
			OnActionFinish();
			return;
		}
		MakeImpulseSourceData makeImpulseSourceData = ReferencePool.Acquire<MakeImpulseSourceData>();
		makeImpulseSourceData.ImpulseInterval = ImpulseInterval;
		makeImpulseSourceData.ImpulseNums = ImpulseNums;
		makeImpulseSourceData._impulseForce = ImpulseForce;
		makeImpulseSourceData.ImpulseForceCurve = ImpulseForceCurve;
		makeImpulseSourceData.ImpulseDir = ImpulseDir.value;
		makeImpulseSourceData.ImpulseSpeed = ImpulseSpeed;
		makeImpulseSourceData.ImpulseDistance = ImpulseDistance;
		makeImpulseSourceData.ImpulsePosition = ImpulsePosition.value;
		makeImpulseSourceData.ImpulsePosEntityId = ImpulsePosEntityId.value;
		makeImpulseSourceData.ImpulsePosPoint = ImpulsePosPoint;
		makeImpulseSourceData.ImpulsePositionOffset = ImpulsePositionOffset;
		makeImpulseSourceData.BlendTime = BlendTime;
		makeImpulseSourceData.IntensityInit = IntensityInit;
		if (useCustomStrengCurve)
		{
			makeImpulseSourceData.StrengCurve = customStrengCurve;
		}
		else
		{
			AnimationCurve strengCurve = system.GetIntensityCurveData(strengCurveName)?.CurveValue;
			makeImpulseSourceData.StrengCurve = strengCurve;
		}
		if (useCustomFrequencyCurve)
		{
			makeImpulseSourceData.FrequencyCurve = customFrequencyCurve;
		}
		else
		{
			AnimationCurve frequencyCurve = system.GetFrequencyCurveData(frequencyCurveName)?.CurveValue;
			makeImpulseSourceData.FrequencyCurve = frequencyCurve;
		}
		if (useCustomStrengRangeCurve)
		{
			makeImpulseSourceData.DistanceStrengCurve = customStrengRangeCurve;
		}
		else
		{
			AnimationCurve distanceStrengCurve = system.GetImpulseRangeCurveData(strengRangeCurveName)?.CurveValue;
			makeImpulseSourceData.DistanceStrengCurve = distanceStrengCurve;
		}
		makeImpulseSourceData.frequency = frequency.value;
		makeImpulseSourceData.duration = duration.value;
		makeImpulseSourceData.NoiseName = NoiseName;
		makeImpulseSourceData.ImpulsePriorityInit = ImpulsePriority;
		makeImpulseSourceData.ImpulsePriorityCurve = ImpulsePriorityCurve;
		makeImpulseSourceData.ImpulsePriorityDisCurve = ImpulsePriorityDisCurve;
		makeImpulseSourceData.UseRandomNoise = UseRandomNoise;
		makeImpulseSourceData.ImpulseUniqueIndex = system.ImpulseUniqueIndex;
		impulseUniqueIndex = makeImpulseSourceData.ImpulseUniqueIndex;
		system.MakeImpulse(makeImpulseSourceData);
		OnActionFinish();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (ownerEntity != null && FollowTree)
		{
			ownerEntity.GetSystem<VirtualCameraSystem>()?.TreeStopRemoveImpulse(impulseUniqueIndex);
		}
	}
}
