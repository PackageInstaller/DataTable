using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("创建预警圈（弃用）", 0)]
[Description("此操作已弃用，不再使用。根据指定的形状、类型和参数创建预警圈。")]
[Category("✫ DragonLost/Entity")]
public class MakeWarningIndicatorAction : ActionTaskBase
{
	[RequiredField]
	[Name("预警圈创建者ID", 0)]
	[Description("要创建预警圈的实体的ID")]
	public BBParameter<int> CreatorId;

	[Name("形状", 0)]
	[Description("预警圈的形状")]
	public WarningIndicatorFormType WarnRingShape;

	[Name("类型", 0)]
	[Description("预警圈的类型")]
	public WarnRingType WarnRingType;

	[HideIf("WarnRingType", 1)]
	[Name("出生位置", 0)]
	[Description("预警圈的初始位置")]
	public BBParameter<Vector3> InitPos;

	[Name("预警圈朝向,Halo为偏移角度", 0)]
	[Description("预警圈的朝向角度，对于Halo类型，表示偏移角度")]
	public BBParameter<float> Deg;

	[ShowIf("WarnRingType", 1)]
	[RequiredField]
	[Name("跟随的实体ID", 0)]
	[Description("预警圈跟随的实体的ID")]
	public BBParameter<int> FollowId;

	[ShowIf("WarnRingType", 2)]
	[Name("Track-移动速度", 0)]
	[Description("追踪类型预警圈的移动速度")]
	public BBParameter<float> moveSpeed;

	[ShowIf("WarnRingType", 2)]
	[Name("Track-移动时间", 0)]
	[Description("追踪类型预警圈的移动时间")]
	public BBParameter<float> MoveTimer;

	[ShowIf("WarnRingType", 2)]
	[Name("Track-追踪者ID", 0)]
	[Description("追踪类型预警圈的追踪者ID")]
	public BBParameter<int> targetID;

	[ShowIf("WarnRingShape", 1)]
	[Name("矩形的长", 0)]
	[Description("矩形预警圈的长")]
	public BBParameter<float> Length;

	[ShowIf("WarnRingShape", 1)]
	[Name("矩形的宽", 0)]
	[Description("矩形预警圈的宽")]
	public BBParameter<float> Width;

	[HideIf("WarnRingShape", 1)]
	[Name("圆形或环形的半径", 0)]
	[Description("圆形或环形预警圈的半径")]
	public float radius;

	[HideIf("WarnRingShape", 1)]
	[Name("圆形或环形的角度", 0)]
	[Description("圆形或环形预警圈的角度")]
	public float warnRingAngle;

	[ShowIf("WarnRingShape", 2)]
	[Name("环形的内圈半径", 0)]
	[Description("环形预警圈的内圈半径")]
	public BBParameter<float> ringRadius;

	[Name("延长生命周期", 0)]
	[Description("预警圈的延长生命周期时间")]
	public BBParameter<float> delayLifeTimer;

	[Name("底图填充满时间", 0)]
	[Description("预警圈底图填充满的时间")]
	public BBParameter<float> fillTimer;

	[Name("延时填充和追踪时间", 0)]
	[Description("预警圈的延时填充和追踪时间")]
	public BBParameter<float> delayDiffuseOrMoveTimer;

	[Name("扩散时间", 0)]
	[Description("预警圈的扩散时间")]
	public BBParameter<float> diffuseTimer;

	private WarningIndicatorData _indicatorData;

	protected override void OnExecute()
	{
		EndAction();
	}
}
