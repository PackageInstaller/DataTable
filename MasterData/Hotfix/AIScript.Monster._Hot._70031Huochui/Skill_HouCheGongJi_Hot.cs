using System.Collections;
using TrueSync;

namespace AIScript.Monster._Hot._70031Huochui;

public class Skill_HouCheGongJi_Hot : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.R,
		ComboInputBuffer.ActionKey._1
	};

	private LogicEntity AttackTarget;

	private static readonly FP DashTime = 0.6;

	private DeterministicShape TargetFan;

	private FP OneseDis;

	private TSVector2 OneselfPos;

	private static readonly string BackDash_Event = "BackDash";

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
		BeginAttack(1, _actionKey1, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(AttackTarget, 5, 540);
		yield return WaitCustomEvent(BackDash_Event);
		Skill_HouCheGongJi_Hot skill_HouCheGongJi_Hot = this;
		Skill_HouCheGongJi_Hot skill_HouCheGongJi_Hot2 = this;
		TSVector2 position = GetPosition();
		FP radius = 8;
		FP innerRadius = 8;
		FP angle = 160;
		FP rotation = -GetRotation();
		skill_HouCheGongJi_Hot.TargetFan = skill_HouCheGongJi_Hot2.GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, rotation);
		OneselfPos = GetShapeRandomPoint(TargetFan, _actor, isReachable: true);
		OneseDis = Distance(GetPosition(), OneselfPos);
		TSVector2 tSVector = TransLocalPosToWorldPos(GetPosition(), GetPosition() - GetEntityPosition(GetAttackTarget(isUpToDate: true)), TSVector2.up * OneseDis);
		BeginDash(1, tSVector - GetPosition(), OneseDis / DashTime, OneseDis, 999, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 1);
		yield return WaitDashFinish();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
