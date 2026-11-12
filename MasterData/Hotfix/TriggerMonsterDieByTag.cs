using System.Collections.Generic;

public class TriggerMonsterDieByTag : TriggerConditionBase
{
	public List<string> tags = new List<string>();

	private List<string> tagList = new List<string>();

	public override void ToActive()
	{
		base.ToActive();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDeath);
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDeath);
	}

	private void OnMonsterDeath(IEvent evt)
	{
		if (!(evt is AdventureMonsterDiedEvent { sender: MonsterAdventureActor sender }))
		{
			return;
		}
		tagList.Clear();
		tagList.Add(sender.monsterInfo.Tag1);
		tagList.Add(sender.monsterInfo.Tag2);
		tagList.Add(sender.monsterInfo.Tag3);
		tagList.Add(sender.monsterInfo.Tag4);
		tagList.Add(sender.monsterInfo.Tag5);
		bool flag = true;
		for (int i = 0; i < tags.Count; i++)
		{
			if (!string.IsNullOrEmpty(tags.get_Item(i)) && !tagList.Contains(tags.get_Item(i)))
			{
				flag = false;
				break;
			}
		}
		if (flag)
		{
			OnTrigger();
		}
	}
}
