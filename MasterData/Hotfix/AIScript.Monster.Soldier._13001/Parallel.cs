namespace AIScript.Monster.Soldier._13001;

public class Parallel : AIBase
{
	private const int buffId_2 = 250102901;

	private const int buffId_3 = 250102902;

	private int _potentialLv = 1;

	public void OnEnable()
	{
		SoldierActor soldierActor = _actor as SoldierActor;
		_potentialLv = soldierActor.GetPotentialLv();
		if (_potentialLv >= 2 && soldierActor.isSupport)
		{
			ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		}
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
	}

	private void OnDamage(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && !(adventureActorReceiveDamageEvent.from != _actor) && adventureActorReceiveDamageEvent.to is AdventureActor adventureActor)
		{
			int buffID = ((_potentialLv >= 3) ? 250102902 : 250102901);
			adventureActor.buffComponent.AddBuff(buffID, _actor);
		}
	}
}
