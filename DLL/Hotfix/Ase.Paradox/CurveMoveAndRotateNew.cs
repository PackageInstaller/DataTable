using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("实体曲线位移和旋转（可选碰撞暂时取消位移）", 0)]
[Description("实现实体的曲线位移和旋转动作。")]
[Category("✫ DragonLost/Transform")]
public class CurveMoveAndRotateNew : ActionTaskBase
{
	[ParadoxNotion.Design.Header("位移")]
	[Description("启用曲线位移功能。")]
	[Name("- 启动曲线位移", 0)]
	public bool useMovement = true;

	[Description("X轴位移的曲线。")]
	[Name("X轴位移曲线", 0)]
	[ShowIf("useMovement", 1)]
	public AnimationCurve curveX;

	[Description("Z轴位移的曲线。")]
	[Name("Z轴位移曲线", 0)]
	[ShowIf("useMovement", 1)]
	public AnimationCurve curveZ;

	[ParadoxNotion.Design.Header("旋转")]
	[Description("启用曲线旋转功能。")]
	[Name("- 启动曲线旋转", 0)]
	public bool useRotation = true;

	[Name("旋转参数类型", 0)]
	public CurveMoveAndRotate.RotateType rotateType;

	[Description("X轴旋转的曲线。")]
	[Name("X轴旋转曲线", 0)]
	[ShowIf("useRotation", 1)]
	public AnimationCurve curveRotX;

	[Description("Y轴旋转的曲线。")]
	[Name("Y轴旋转曲线", 0)]
	[ShowIf("useRotation", 1)]
	public AnimationCurve curveRotY;

	[Description("Z轴旋转的曲线。")]
	[Name("Z轴旋转曲线", 0)]
	[ShowIf("useRotation", 1)]
	public AnimationCurve curveRotZ;

	[Description("W轴旋转的曲线。")]
	[Name("W轴旋转曲线", 0)]
	[ShowIf("useRotation", 1)]
	[HideIf("rotateType", 1)]
	public AnimationCurve curveRotW;

	[Name("是否开启插值运动", 0)]
	public bool IsOpenInterpolation;

	[Name("是否启用动画运动", 0)]
	public bool IsOpenAnimator;

	[Name("时间类型", 0)]
	public MovementTimeType TimeType;

	[ParadoxNotion.Design.Header("参数")]
	[Description("移动的时间。")]
	[Name("移动时间", 0)]
	[ShowIf("TimeType", 0)]
	public BBParameter<float> moveTime = new BBParameter<float>();

	[ParadoxNotion.Design.Header("参数")]
	[Description("移动的帧号。")]
	[Name("移动帧号", 0)]
	[ShowIf("TimeType", 1)]
	public BBParameter<int> MoveTick = new BBParameter<int>();

	[Description("Z轴位移的倍率。")]
	[Name("倍率Z", 0)]
	public BBParameter<float> multiple = 1f;

	[Description("X轴位移的倍率。")]
	[Name("倍率X", 0)]
	public BBParameter<float> multiple_X = 1f;

	[Name("Z轴时间倍率", 0)]
	public BBParameter<float> timeScale_z = 1f;

	[Name("X轴时间倍率", 0)]
	public BBParameter<float> timeScale_x = 1f;

	[Description("是否等待移动完成。")]
	[Name("是否等待完成", 0)]
	public bool waitUntilFinish;

	[Name("冻帧时是否冻结位移", 0)]
	[Description("冻帧时是否冻结位移。")]
	public bool IsFrozenMovementCommand;

	[Description("碰撞期间位移倍率是否置0。")]
	[Name("碰撞期间位移倍率是否置0", 0)]
	public bool colliderPauseMove;

	[Name("X轴停止位移", 0)]
	[ShowIf("colliderPauseMove", 1)]
	public bool isSkillMoveCancelXMove = true;

	[Name("Z轴停止位移", 0)]
	[ShowIf("colliderPauseMove", 1)]
	public bool isSkillMoveCancelZMove = true;

	[ShowIf("colliderPauseMove", 1)]
	[Description("检测范围内的距离。")]
	[Name("检测距离", 0)]
	public BBParameter<float> checkDistance = new BBParameter<float>(2f);

	[Name("检测半径", 0)]
	[ShowIf("colliderPauseMove", 1)]
	public float CheckRadius;

	[ShowIf("colliderPauseMove", 1)]
	[Description("技能停止范围的角度。")]
	[Name("技能停止范围", 0)]
	private Vector2 stopAngle = new Vector2(-180f, 180f);

	private float waitFinishTime;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (!useMovement && !useRotation)
		{
			OnActionFail();
			return;
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId("节点开启曲线位移", ownerEntity);
		}
		CurveMovementComponent component = ownerEntity.GetComponent<CurveMovementComponent>();
		if (component == null)
		{
			OnActionFail();
			return;
		}
		AnimationCurve rotW = ((rotateType == CurveMoveAndRotate.RotateType.Quaternion) ? curveRotW : null);
		Vector2 vector = new Vector2(multiple_X.value, multiple.value);
		if (useMovement && useRotation)
		{
			component.CurveMove(GetTimeScaleCurve(curveX, timeScale_x.value), GetTimeScaleCurve(curveZ, timeScale_z.value), curveRotX, curveRotY, curveRotZ, rotW, moveTime.value, MoveTick.value, vector, moveDirByRotate: false, isSkillMoveCancel: false, isSkillMoveCancelXMove, isSkillMoveCancelZMove, stopAngle, checkDistance.value, CheckRadius, IsFrozenMovementCommand, TimeType, IsOpenInterpolation, IsOpenAnimator, colliderPauseMove);
		}
		else if (useMovement)
		{
			component.CurveMove(GetTimeScaleCurve(curveX, timeScale_x.value), GetTimeScaleCurve(curveZ, timeScale_z.value), moveTime.value, MoveTick.value, vector, !useRotation, isSkillMoveCancel: false, isSkillMoveCancelXMove, isSkillMoveCancelZMove, stopAngle, checkDistance.value, CheckRadius, IsFrozenMovementCommand, TimeType, IsOpenInterpolation, IsOpenAnimator, colliderPauseMove);
		}
		else
		{
			component.CurveMove(curveRotX, curveRotY, curveRotZ, rotW, moveTime.value, MoveTick.value, vector, isSkillMoveCancel: false, isSkillMoveCancelXMove, isSkillMoveCancelZMove, stopAngle, checkDistance.value, CheckRadius, IsFrozenMovementCommand, TimeType, IsOpenInterpolation, IsOpenAnimator, colliderPauseMove);
		}
		if (!waitUntilFinish)
		{
			OnActionFinish();
		}
		else if (TimeType == MovementTimeType.Tick)
		{
			waitFinishTime = (float)MoveTick.value * 0.033f;
		}
		else
		{
			waitFinishTime = moveTime.value;
		}
	}

	protected AnimationCurve GetTimeScaleCurve(AnimationCurve curve, float timeScale)
	{
		if (timeScale != 1f && curve.length > 0)
		{
			AnimationCurve animationCurve = new AnimationCurve(curve.keys);
			for (int num = animationCurve.length - 1; num >= 0; num--)
			{
				Keyframe key = animationCurve.keys[num];
				key.time *= timeScale;
				animationCurve.MoveKey(num, key);
			}
			return animationCurve;
		}
		return curve;
	}

	protected override void OnUpdate()
	{
		waitFinishTime -= ownerEntity.FinalDeltaTime;
		if (waitUntilFinish && waitFinishTime <= 0f)
		{
			OnActionFinish();
		}
	}
}
