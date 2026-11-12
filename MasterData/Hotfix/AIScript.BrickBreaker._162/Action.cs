using TrueSync;

namespace AIScript.BrickBreaker._162;

public class Action : BrickActorAction
{
	private FP _nextGenBladeTime;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		_nextGenBladeTime = 0;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("DESTRUCTIBLEOBJECT_DIE", OnBrickDestroyed);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterKilled);
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("DESTRUCTIBLEOBJECT_DIE", OnBrickDestroyed);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterKilled);
	}

	private void OnBrickDestroyed(IEvent evt)
	{
		TryGenFloatingBlade();
	}

	private void OnMonsterKilled(IEvent evt)
	{
		TryGenFloatingBlade();
	}

	private void TryGenFloatingBlade()
	{
		if (!(_actor.LogicTime < _nextGenBladeTime) && _actor.buffComponent.GetBuffNumByID(821620101) < 5)
		{
			_nextGenBladeTime = _actor.LogicTime + Config.genBladeCd;
			_actor.buffComponent.AddBuff(821620101, _actor);
		}
	}
}
