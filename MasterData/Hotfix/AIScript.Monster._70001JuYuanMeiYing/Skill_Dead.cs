using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Skill_Dead : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Dead = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

	private List<MonsterAdventureActor> summons = new List<MonsterAdventureActor>();

	protected override IEnumerator DoMainLogic()
	{
		SendDeclareDeadEvent();
		GetAllSummons(ref summons);
		foreach (MonsterAdventureActor summon in summons)
		{
			summon.ClearSelf();
		}
		BeginAttack(1, Dead, flushInputedKeys: true, forceInterruptAttack: true);
		_actor.PlayDeathAnim();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void GetAllSummons(ref List<MonsterAdventureActor> monsters)
	{
		monsters.Clear();
		List<AdventureModuleController.MonsterSummonData> monsterSummonInfos = ModuleController<AdventureModuleController>.Instance.MonsterSummonInfos;
		for (int i = 0; i < monsterSummonInfos.Count; i++)
		{
			if (monsterSummonInfos.get_Item(i).SummonActorID == _actor.Id)
			{
				LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(monsterSummonInfos.get_Item(i).entityID);
				if (logicEntity != null && logicEntity is MonsterAdventureActor item)
				{
					monsters.Add(item);
				}
			}
		}
	}
}
