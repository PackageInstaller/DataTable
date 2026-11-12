using AIScript.Utils;

namespace AIScript.Monster.Soldier._18001;

public class Parallel : AIBase
{
	private static readonly int damageTag_Normal = CommonHelper.StringToHash("18001_Normal_Hit");

	private const int buffId_Potential3 = 250106101;

	private bool _aborted;

	public void OnEnable()
	{
		_aborted = false;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
	}

	public void OnDisable()
	{
		_aborted = true;
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
	}

	private void OnDamage(IEvent evt)
	{
		if (!_aborted && !(_actor == null) && evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && !(adventureActorReceiveDamageEvent.from != _actor) && adventureActorReceiveDamageEvent.to is AdventureActor && !(adventureActorReceiveDamageEvent.to == _actor) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, damageTag_Normal) && ((SoldierActor)_actor).GetPotentialLv() >= 3)
		{
			_actor.buffComponent?.AddBuff(250106101, _actor);
		}
	}
}
