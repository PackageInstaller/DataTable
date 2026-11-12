using AIScript.Monster.Template;

namespace AIScript.Monster._13700011Drone;

public class Parallel : AIScript.Monster.Template.Parallel
{
	public override void OnStart()
	{
		base.OnStart();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_START_MSG", OnBattleStart);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_START_MSG", OnBattleStart);
	}

	private void OnBattleStart(IEvent iEvent)
	{
		_actor.DestroySelf();
	}

	private void OnReceiveDamage(IEvent evt)
	{
	}
}
