using System.Collections.Generic;

namespace AIScript.Monster.Trap;

public class TrapSkillBase : SkillSimpleBase
{
	private TrapAdventureActor trapActor;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		trapActor = _actor as TrapAdventureActor;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TRAP_ACTIVE", OnTrapActive);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRAP_ACTIVE", OnTrapActive);
	}

	private void OnTrapActive(IEvent evt)
	{
		if (evt is AdventureTrapActive adventureTrapActive && (adventureTrapActive.GroupId == trapActor.TrapGroupId || adventureTrapActive.GroupId == 0))
		{
			OnTrapActive(adventureTrapActive);
		}
	}

	public void FilterActor(List<DeterministicCollider> result)
	{
		for (int i = 0; i < result.Count; i++)
		{
			AdventureActor actor = result.get_Item(i).Entity as AdventureActor;
			if (FilterMonsterByTag(actor))
			{
				result.RemoveAt(i);
				i--;
			}
		}
	}

	public bool FilterMonsterByTag(AdventureActor actor)
	{
		if (actor is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor.monsterInfo.subType == HotfixEnum.monsterSubType.Monster)
		{
			int[] trapTagIds = monsterAdventureActor.monsterInfo.trapTagIds;
			if (trapTagIds != null)
			{
				for (int i = 0; i < trapTagIds.Length; i++)
				{
					if (trapActor.FilterDic.Contains(trapTagIds[i]))
					{
						return true;
					}
				}
			}
		}
		return false;
	}

	public void OnTrapActive(AdventureTrapActive evt)
	{
	}
}
