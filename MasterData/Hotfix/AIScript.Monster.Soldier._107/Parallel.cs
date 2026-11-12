using AdventureBehaviour;

namespace AIScript.Monster.Soldier._107;

public class Parallel : AIBase
{
	private const string hitAreaEffect = "AreaEffect";

	public void OnEnable()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("FLY_SHIELD_HIT", OnShieldHit);
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("FLY_SHIELD_HIT", OnShieldHit);
	}

	private void OnShieldHit(IEvent evt)
	{
		if (evt is FlyShieldHitEvent flyShieldHitEvent && !(flyShieldHitEvent.owner != _actor) && !(flyShieldHitEvent.target == null))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect", flyShieldHitEvent.target.tsTransform.Position);
		}
	}
}
