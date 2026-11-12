using AIScript.Utils;

namespace AIScript.Monster.Soldier._17011;

public class Parallel : AIBase
{
	private static readonly int damageTag_Crossbow = CommonHelper.StringToHash("Soldier_17011_Crossbow_Bullet");

	private const int goldItemId = 40;

	private const int goldCount = 1;

	private int _potentialLv = 1;

	public void OnEnable()
	{
		_potentialLv = (_actor as SoldierActor).GetPotentialLv();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
	}

	private void OnDamage(IEvent evt)
	{
		if (_potentialLv >= 3 && evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && !(adventureActorReceiveDamageEvent.from != _actor) && adventureActorReceiveDamageEvent.isKill && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, damageTag_Crossbow))
		{
			(ModuleController<AdventureModuleController>.Instance?.levelInstance as SoldierLevelController)?.AddItem(40, 1);
		}
	}
}
