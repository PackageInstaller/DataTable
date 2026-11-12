using System.Collections;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Skill_Summon_Dead_Phase_2 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Dead = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		SetCloseBlockEnable();
		_actor.logicVariable.ToggleLogicTag("Patrol", value: false);
	}

	protected override IEnumerator DoMainLogic()
	{
		SendDeclareDeadEvent();
		(_actor as MonsterAdventureActor).monsterSummonInfo.SummonActor.buffComponent.RemoveBuffByBuffId(700010010, 10);
		BeginAttack(1, Dead, flushInputedKeys: true, forceInterruptAttack: true);
		_actor.PlayDeathAnim();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
