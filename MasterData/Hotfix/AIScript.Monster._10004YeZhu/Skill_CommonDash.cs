using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._10004YeZhu;

public class Skill_CommonDash : SkillSimpleBase
{
	protected readonly int startKeyIndex1 = 1;

	protected readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	protected readonly string fxA = "Dash";

	protected readonly FP dash_spd = 16;

	protected readonly FP dash_angleLimit = 1;

	protected readonly string fxB = "DashEnd";

	protected readonly FP dash_Spd_B = 6;

	protected readonly FP dash_Dis_B = 3;

	protected PlayFX fxLoopA;

	protected PlayFX fxLoopB;

	protected bool isdashStop;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(startKeyIndex1, startKey, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		fxLoopA = PlayFxForNeedStop(fxA, 1f, _actor.tsTransform.PositionY, _actor.tsTransform.Position, _actor.tsTransform.Rotation);
		LogicEntity attackTarget = GetAttackTarget();
		FP dis = _actor.DistanceWithRadius(attackTarget);
		dis += (FP)4;
		doDash(dis);
		yield return WaitDashFinish();
		fxLoopA.Stop();
		BeginAttack(startKeyIndex1, startKey);
		doDash_B();
		fxLoopB = PlayFxForNeedStop(fxB, 1f, _actor.tsTransform.PositionY, _actor.tsTransform.Position, _actor.tsTransform.Rotation);
		yield return WaitDashFinish();
		fxLoopB.Stop();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void doDash(FP dis)
	{
		BeginDashActorForward(1, dash_spd, dis, dash_angleLimit, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void doDash_B()
	{
		BeginDashActorForward(2, dash_Spd_B, dash_Dis_B, dash_angleLimit, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	protected override void OnDashFinish(int index)
	{
		if (index == 2)
		{
			fxLoopB?.Stop();
			fxLoopB?.Clear();
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		fxLoopA?.Stop();
		fxLoopA?.Clear();
		fxLoopB?.Stop();
		fxLoopB?.Clear();
	}
}
