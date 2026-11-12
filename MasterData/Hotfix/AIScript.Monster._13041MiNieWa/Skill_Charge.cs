using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._13041MiNieWa;

public class Skill_Charge : SkillSimpleBase
{
	protected readonly int startKeyIndex1 = 1;

	protected readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	protected readonly string TurnAround03 = "TurnAround03";

	protected readonly FP durationT = 99;

	protected readonly FP rotateSpeed = 540;

	protected readonly string StopTurn03 = "StopTurn03";

	protected readonly string Charge01 = "Charge01";

	protected readonly FP dash_dis = 5;

	protected readonly FP dash_time = 0.6;

	protected readonly FP dash_angleLimit = 60;

	protected override IEnumerator DoMainLogic()
	{
		yield return BeginLookAtMonsterTarget(0.5, 360);
		Skill_Charge skill_Charge = this;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		skill_Charge.PlayEarlyWarningEffect("fx_warning_dash_2x8", 0.5f, default, position, rotation);
		yield return WaitTime(0.5);
		BeginAttack(startKeyIndex1, startKey);
		yield return WaitCustomEvent(Charge01);
		doDash();
		yield return WaitDashFinish();
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int keyIndex, string eventName)
	{
		if (eventName.Equals(TurnAround03))
		{
			LogicEntity monsterTarget = _actor.monsterTarget;
			if (CommonUtils.CheckTargetIsValid(monsterTarget, 0L))
			{
				BeginLookAt_NotWait(monsterTarget, durationT, rotateSpeed);
			}
			else
			{
				InterruptSkill();
			}
		}
		else if (eventName.Equals(StopTurn03))
		{
			StopLookAt();
		}
	}

	private void doDash()
	{
		LogicEntity monsterTarget = _actor.monsterTarget;
		if (CommonUtils.CheckTargetIsValid(monsterTarget, 0L))
		{
			FP fP = TSVector2.Distance(monsterTarget.tsTransform.Position, _actor.tsTransform.Position);
			if (fP < dash_dis)
			{
				fP = dash_dis;
			}
			FP speed = fP / dash_time;
			BeginDashActorForward(1, speed, fP, dash_angleLimit, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		}
		else
		{
			InterruptSkill();
		}
	}
}
