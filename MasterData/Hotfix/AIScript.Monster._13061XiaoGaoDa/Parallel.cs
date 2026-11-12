using AIScript.Monster.Template;

namespace AIScript.Monster._13061XiaoGaoDa;

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
		if (evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && adventureActorReceiveDamageEvent.to as PlayerAdventureActor != null)
		{
			hitDmgTotle += adventureActorReceiveDamageEvent.damageToShieldAndHp;
		}
	}

	public override void OnDied(int monsterId)
	{
		if (monsterId == _actor.dataID && hitDmgTotle <= 0 && !ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.XiaoGaoDa_001))
		{
			ModuleController<AdventureModuleController>.Instance.SetAchievementFinish(HotfixEnum.questCompleteCondClient.XiaoGaoDa_001);
		}
	}
}
