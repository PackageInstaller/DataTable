using System.Collections;
using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class SkillScript_ShadowGathering_3 : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] _actionKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.H };

	protected override IEnumerator DoMainLogic()
	{
		SetLockToughnessEnable();
		MoveToPosition(new TSVector2(0, 0), 0.1f, AdventureActor.MovementMode.Walk);
		yield return WaitMoveStatus();
		BeginLookAtByPos(new TSVector2(0, -60), 0, 400);
		yield return WaitTime(0.2);
		_actor.logicVariable.ToggleLogicTag("CheckSkill_ShaSha", value: false);
		BeginAttack(1, _actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		SummonTeammate(1, new TSVector2(-6, 0), TSVector2.down);
		SummonTeammate(1, new TSVector2(6, 0), TSVector2.down);
		yield return WaitTime(1.2f);
		AddBuffToTarget(_actor, 505010110);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetLockToughnessDisable();
		yield return WaitTime(0.5);
	}

	protected void OnFinish()
	{
		_actor.logicVariable.ToggleLogicTag("CheckSkill_ShaSha", value: true);
		_skill?.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		SetLockToughnessDisable();
		_actor.logicVariable.ToggleLogicTag("5050100ShaShaSpecial", value: false);
		_actor.logicVariable.ToggleLogicTag("5050100ShaShaViolent", value: true);
		_actor.logicVariable.ToggleLogicTag("5050100ShaShaViolent_Start", value: true);
	}
}
