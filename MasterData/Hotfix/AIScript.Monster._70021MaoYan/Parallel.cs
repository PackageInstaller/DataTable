using AIScript.Monster.Template;

namespace AIScript.Monster._70021MaoYan;

public class Parallel : AIScript.Monster.Template.Parallel
{
	private int hitCount = 20;

	private int count;

	public override void OnStart()
	{
		base.OnStart();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		count = 0;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (_actor.Id == adventureActorReceiveDamageEvent.from.Id)
		{
			count++;
		}
	}

	public override void OnDied(int monsterId)
	{
		if (monsterId == _actor.dataID && count >= hitCount && !ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.MaoYanLvRenBoss_003))
		{
			ModuleController<AdventureModuleController>.Instance.SetAchievementFinish(HotfixEnum.questCompleteCondClient.MaoYanLvRenBoss_003);
		}
	}
}
