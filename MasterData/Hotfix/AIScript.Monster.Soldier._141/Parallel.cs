using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster.Soldier._141;

public class Parallel : AIBase
{
	private readonly int buffId_SummonCount = 250141301;

	private readonly FP syncInterval = 0.2;

	private int _potentialLv;

	private FP _syncTimer;

	private int _appliedCount;

	private readonly List<SoldierActor> _battleActors = new List<SoldierActor>();

	private SoldierActor soldierActor => _actor as SoldierActor;

	public void OnEnable()
	{
		_potentialLv = ((!(soldierActor != null)) ? 1 : soldierActor.GetPotentialLv());
		_syncTimer = 0;
		_appliedCount = 0;
	}

	public void OnUpdate()
	{
		if (_potentialLv >= 3 && buffId_SummonCount > 0)
		{
			_syncTimer += _actor.LogicDeltaTime;
			if (!(_syncTimer < syncInterval))
			{
				_syncTimer -= syncInterval;
				SyncBuffLayers(GetOwnedSummonCount());
			}
		}
	}

	private int GetOwnedSummonCount()
	{
		if (!(ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController))
		{
			return 0;
		}
		return soldierLevelController.GetSoldierSummonCount(_actor.Id, SupportSkill.summonedChessId);
	}

	private void SyncBuffLayers(int count)
	{
		if (!(ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController))
		{
			return;
		}
		soldierLevelController.GetBattleActors(_actor, _battleActors);
		for (int i = 0; i < _battleActors.Count; i++)
		{
			BuffCom buffCom = _battleActors.get_Item(i)?.buffComponent;
			if (!(buffCom == null) && buffCom.GetBuffNumByID(buffId_SummonCount) != count)
			{
				buffCom.RemoveBuffByBuffId(buffId_SummonCount);
				if (count > 0)
				{
					buffCom.AddBuffNum(buffId_SummonCount, count, _actor);
				}
			}
		}
		_appliedCount = count;
	}

	public void OnDisable()
	{
		if (_appliedCount > 0 && buffId_SummonCount > 0 && ModuleController<AdventureModuleController>.Instance != null)
		{
			SyncBuffLayers(0);
		}
		_battleActors.Clear();
		_syncTimer = 0;
		_appliedCount = 0;
	}
}
