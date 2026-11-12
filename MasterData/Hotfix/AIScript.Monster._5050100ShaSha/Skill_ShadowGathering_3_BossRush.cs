using System.Collections;
using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class Skill_ShadowGathering_3_BossRush : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] _actionKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.H };

	private static readonly string Jumpto = "Jumpto";

	protected override IEnumerator DoMainLogic()
	{
		SetLockToughnessEnable();
		KillActors(GetTargetsByFaction(isFriend: true));
		FP dis2 = Distance(GetPosition(), new TSVector2(0, 0));
		if (dis2 > 5)
		{
			BeginLookAtByPos(new TSVector2(0, 0), 2, 300);
			yield return WaitTime(0.5);
			BeginAttack(1, Jumpto, flushInputedKeys: true, forceInterruptAttack: true);
			SetCloseBlockEnable();
			FP dis3 = dis2 + 2f;
			FP dash_spd = dis3 / 0.8;
			yield return WaitTime(0.1);
			BeginDashActorForward(1, dash_spd, dis3, 40, comboWithAttack: true, isAngle: true, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			yield return WaitTime(1.1);
			CancelAttack();
			SetCloseBlockDisable();
			yield return WaitCombo(ComboAttackType.isComboFinish);
			yield return WaitTime(0.2);
		}
		BeginLookAtByPos(new TSVector2(0, -60), 0, 400);
		yield return WaitTime(0.5);
		_actor.logicVariable.ToggleLogicTag("CheckSkill_ShaSha", value: false);
		BeginAttack(2, _actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		SummonTeammate(1, new TSVector2(-6, 0), TSVector2.down);
		SummonTeammate(1, new TSVector2(6, 0), TSVector2.down);
		yield return WaitTime(1.2f);
		AddBuffToTarget(_actor, 505010110);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetLockToughnessDisable();
		yield return WaitTime(2);
	}

	protected void OnFinish()
	{
		_actor.logicVariable.ToggleLogicTag("CheckSkill_ShaSha", value: true);
		_skill?.Clear();
	}

	protected void OnInterrupt()
	{
		AddBuffToTarget(_actor, 505010110);
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		SetLockToughnessDisable();
		SetCloseBlockDisable();
		_actor.logicVariable.ToggleLogicTag("5050100ShaShaSpecial", value: false);
		_actor.logicVariable.ToggleLogicTag("5050100ShaShaViolent", value: true);
		_actor.logicVariable.ToggleLogicTag("5050100ShaShaViolent_Start", value: true);
	}
}
