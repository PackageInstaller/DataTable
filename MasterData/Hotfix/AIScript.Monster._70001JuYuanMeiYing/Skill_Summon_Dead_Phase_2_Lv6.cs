using System.Collections;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Skill_Summon_Dead_Phase_2_Lv6 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Dead = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

	private const int buffId_BossReduceDamage = 700010010;

	private readonly int reduceBuffLayer = 10;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		SetCloseBlockEnable();
		_actor.logicVariable.ToggleLogicTag("Patrol", value: false);
	}

	protected override IEnumerator DoMainLogic()
	{
		SendDeclareDeadEvent();
		(_actor as MonsterAdventureActor).monsterSummonInfo.SummonActor.buffComponent.RemoveBuffByBuffId(700010010, reduceBuffLayer);
		BeginAttack(1, Dead, flushInputedKeys: true, forceInterruptAttack: true);
		_actor.PlayDeathAnim();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
