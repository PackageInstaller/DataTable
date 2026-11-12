using AIScript.Utils;

namespace AIScript.Monster.Soldier._13031;

public class Parallel : AIBase
{
	private static readonly int bulletDamageTag = CommonHelper.StringToHash("13031_MainSkill_Bullet");

	private const int buffId_2 = 250102803;

	private const int buffId_3 = 250102804;

	private int _potentialLv = 1;

	public void OnEnable()
	{
		_potentialLv = (_actor as SoldierActor).GetPotentialLv();
		if (_potentialLv >= 2)
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
		if (evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && !(adventureActorReceiveDamageEvent.from != _actor) && adventureActorReceiveDamageEvent.isKill && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, bulletDamageTag))
		{
			int buffID = ((_potentialLv >= 3) ? 250102804 : 250102803);
			_actor.buffComponent.AddBuff(buffID, _actor);
		}
	}
}
