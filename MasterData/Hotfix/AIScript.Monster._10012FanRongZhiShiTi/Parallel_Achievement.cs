using AIScript.Monster.Template;

namespace AIScript.Monster._10012FanRongZhiShiTi;

public class Parallel_Achievement : Parallel
{
	private int dashCount = 5;

	private long hitDmgTotle;

	private int dashHitCount;

	private static int evt_DashEnd = CommonHelper.StringToHash("DashEnd");

	public override void OnStart()
	{
		base.OnStart();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		hitDmgTotle = 0L;
		dashHitCount = 0;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
	}

	private void OnReceiveDamage(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && adventureActorReceiveDamageEvent.to as PlayerAdventureActor != null)
		{
			hitDmgTotle += adventureActorReceiveDamageEvent.damageToShieldAndHp;
		}
	}

	private void OnCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent && adventureActorCustomEvent.eventHashCode == evt_DashEnd && adventureActorCustomEvent.boolParam)
		{
			dashHitCount++;
			if (dashHitCount >= dashCount && !ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.FanRonShiTi_002))
			{
				ModuleController<AdventureModuleController>.Instance.SetAchievementFinish(HotfixEnum.questCompleteCondClient.FanRonShiTi_002);
			}
		}
	}

	public override void OnDied(int monsterId)
	{
		if (monsterId == _actor.dataID)
		{
			if (dashHitCount == 0 && !ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.FanRonShiTi_001))
			{
				ModuleController<AdventureModuleController>.Instance.SetAchievementFinish(HotfixEnum.questCompleteCondClient.FanRonShiTi_001);
			}
			if (hitDmgTotle <= 0 && !ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.FanRonShiTi_004))
			{
				ModuleController<AdventureModuleController>.Instance.SetAchievementFinish(HotfixEnum.questCompleteCondClient.FanRonShiTi_004);
			}
		}
	}
}
