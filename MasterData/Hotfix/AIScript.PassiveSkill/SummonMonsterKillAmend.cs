using TrueSync;

namespace AIScript.PassiveSkill;

public class SummonMonsterKillAmend : PassiveSkillBase
{
	private int addTotalCount = 2;

	private FP addTime = 3;

	private int addCount;

	protected override void OnSkillEnable()
	{
		addCount = 0;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
	}

	protected override void OnSkillDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
	}

	private void OnDamage(IEvent evt)
	{
		if (addCount >= addTotalCount || !(evt is AdventureActorReceiveDamageEvent { isKill: not false } adventureActorReceiveDamageEvent))
		{
			return;
		}
		MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageEvent.from as MonsterAdventureActor;
		if (monsterAdventureActor == null || monsterAdventureActor.monsterSummonInfo.SummonActor == null || monsterAdventureActor.monsterSummonInfo.SummonActor.Id != _actor.Id)
		{
			return;
		}
		bool flag = _actor is PlayerAdventureActor;
		foreach (AdventureModuleController.MonsterSummonData monsterSummonInfo in ModuleController<AdventureModuleController>.Instance.MonsterSummonInfos)
		{
			if (monsterSummonInfo.isPlayerSummons == flag)
			{
				monsterSummonInfo.monster.monsterSummonInfo.AddLeftTime(addTime);
			}
		}
		addCount++;
	}
}
