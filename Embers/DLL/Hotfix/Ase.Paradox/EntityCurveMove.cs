using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("实体曲线位移（英雄）", 0)]
[Description("在英雄实体上执行曲线位移动作。")]
[Category("✫ DragonLost/Transform")]
public class EntityCurveMove : ActionTaskBase
{
	public enum MoveDir
	{
		Z,
		XPositive,
		XMinus
	}

	[RequiredField]
	[Name("位移曲线", 0)]
	[Description("用于位移的曲线。")]
	public BBParameter<AnimationCurve> curve;

	[Name("移动时间", 0)]
	[Description("移动所需的时间。")]
	public BBParameter<float> moveTime;

	[Name("位移开始时间", 0)]
	[Description("位移开始的时间。")]
	public BBParameter<float> startTime;

	[Name("倍率", 0)]
	[Description("应用于位移的倍率。")]
	public BBParameter<float> multiple = 1f;

	[Name("是否等待完成", 0)]
	[Description("指示是否等待移动完成。")]
	public bool waitUntilFinish;

	[Name("是否打开碰撞取消位移", 0)]
	[Description("指示是否打开碰撞取消位移。")]
	public bool isSkillMoveCancel = true;

	private Vector2 stopAngle = new Vector2(-180f, 180f);

	[ShowIf("isSkillMoveCancel", 1)]
	[Name("检测距离", 0)]
	[Description("用于检测碰撞的距离。")]
	public BBParameter<float> checkDistance = new BBParameter<float>(2f);

	protected override void OnExecute()
	{
		base.OnExecute();
	}
}
