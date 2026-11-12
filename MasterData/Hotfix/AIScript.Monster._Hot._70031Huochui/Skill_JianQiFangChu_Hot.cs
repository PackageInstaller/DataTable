using System.Collections;
using TrueSync;

namespace AIScript.Monster._Hot._70031Huochui;

public class Skill_JianQiFangChu_Hot : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.I,
		ComboInputBuffer.ActionKey._2
	};

	private static readonly string StopAttack_Event = "StopAttack";

	private static readonly string EndPostRock_Event = "EndPostRock";

	private LogicEntity AttackTarget;

	private readonly ComboInputBuffer.ActionKey[] _actionKey3 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.L,
		ComboInputBuffer.ActionKey._2
	};

	private DeterministicShape TargetFan;

	private FP TargetDis;

	private FP OneseDis;

	private TSVector2 OneselfPos;

	private static readonly FP DashTime = 0.6;

	private static readonly string Dash_Event = "Dash";

	private static readonly string BackDash_Event = "BackDash";

	private static readonly string TeleportStart_Event = "TeleportStart";

	private static readonly string StartTurn_Event = "StartTurn";

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKey1, flushInputedKeys: true);
		BeginLookAt_NotWait(AttackTarget, 8, 200);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		for (int i = 0; i < 2; i++)
		{
			yield return WaitCustomEvent(StopAttack_Event);
		}
		CancelAttack();
		yield return WaitCustomEvent(EndPostRock_Event);
		BeginAttack(3, _actionKey3, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(AttackTarget, 5, 540);
		yield return WaitCustomEvent(BackDash_Event);
		Skill_JianQiFangChu_Hot skill_JianQiFangChu_Hot = this;
		Skill_JianQiFangChu_Hot skill_JianQiFangChu_Hot2 = this;
		TSVector2 position = GetPosition();
		FP radius = 7;
		FP innerRadius = 7;
		FP angle = 20;
		FP rotation = -GetRotation();
		skill_JianQiFangChu_Hot.TargetFan = skill_JianQiFangChu_Hot2.GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, rotation);
		OneselfPos = GetShapeRandomPoint(TargetFan, _actor, isReachable: true);
		OneseDis = Distance(GetPosition(), OneselfPos);
		TSVector2 tSVector = TransLocalPosToWorldPos(GetPosition(), GetPosition() - GetEntityPosition(GetAttackTarget(isUpToDate: true)), TSVector2.up * OneseDis);
		BeginDash(1, tSVector - GetPosition(), OneseDis / DashTime, OneseDis, 999, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		yield return WaitCustomEvent(Dash_Event);
		TargetDis = GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true);
		SetCloseBlockEnable();
		StopLookAt();
		BeginDashActorForward(2, TargetDis / DashTime, TargetDis, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		SetCloseBlockDisable();
		yield return WaitCustomEvent(TeleportStart_Event);
		TSVector2 entityPosition = GetEntityPosition(GetAttackTarget(isUpToDate: true));
		Teleport(entityPosition);
		yield return WaitCustomEvent(StartTurn_Event);
		BeginLookAt_NotWait(AttackTarget, 1, 540);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnSkillDisable()
	{
		SetCloseBlockDisable();
	}
}
