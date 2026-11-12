using System.Collections.Generic;
using AIScript.Monster.Template;

namespace AIScript.Monster._50101YinYing;

public class Parallel : AIScript.Monster.Template.Parallel
{
	private long hitDmgTotle;

	public override void OnStart()
	{
		base.OnStart();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		hitDmgTotle = 0L;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (adventureActorReceiveDamageEvent.to as PlayerAdventureActor != null)
		{
			hitDmgTotle += adventureActorReceiveDamageEvent.damageToShieldAndHp;
		}
	}

	public override void OnDied(int monsterId)
	{
		if (monsterId != _actor.dataID)
		{
			return;
		}
		List<LogicEntity> monsters = ModuleController<AdventureModuleController>.Instance.GetMonsters();
		bool flag = true;
		for (int i = 0; i < monsters.Count; i++)
		{
			if (monsters.get_Item(i).Id != _actor.Id && monsters.get_Item(i) is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor.actorHealthInfo.isAlive)
			{
				flag = false;
				break;
			}
		}
		if (flag && !ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.DaYinYing_001))
		{
			ModuleController<AdventureModuleController>.Instance.SetAchievementFinish(HotfixEnum.questCompleteCondClient.DaYinYing_001);
		}
		if (hitDmgTotle <= 0 && !ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.DaYinYing_002))
		{
			ModuleController<AdventureModuleController>.Instance.SetAchievementFinish(HotfixEnum.questCompleteCondClient.DaYinYing_002);
		}
	}
}
