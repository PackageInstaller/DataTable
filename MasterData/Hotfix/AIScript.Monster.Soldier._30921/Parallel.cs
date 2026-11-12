namespace AIScript.Monster.Soldier._30921;

public class Parallel : AIBase
{
	private const int buffNormal = 250106001;

	private const int buffSupport_2 = 250106002;

	private int PotentialLv = 1;

	public void OnEnable()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		PotentialLv = (_actor as SoldierActor).GetPotentialLv();
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
	}

	private void OnReceiveBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (_actor != null && adventureActorReceiveDamageBeforeHitEvent.from is SoldierActor soldierActor && adventureActorReceiveDamageBeforeHitEvent.from.Id == _actor.Id && soldierActor.isSupport && PotentialLv >= 2)
		{
			_actor.buffComponent.AddBuff(250106002, _actor);
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (_actor != null && adventureActorReceiveDamageEvent.from is SoldierActor soldierActor && adventureActorReceiveDamageEvent.from.Id == _actor.Id && !soldierActor.isSupport && _actor.buffComponent.CheckBuffByBuffID(250106001))
		{
			_actor.buffComponent.RemoveBuffByBuffId(250106001);
		}
	}
}
