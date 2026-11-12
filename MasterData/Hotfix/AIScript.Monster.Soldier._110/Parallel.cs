using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._110;

public class Parallel : AIBase
{
	private readonly FP spawnInterval = 3;

	private readonly int maxAliveCount = 3;

	private readonly FP ringInnerRadius = 1;

	private readonly FP ringOuterRadius = 3;

	private int _potentialLv;

	private FP _timer;

	private readonly List<AdventureActor> _enemyBuffer = new List<AdventureActor>();

	public void OnEnable()
	{
		_potentialLv = ((!(_actor is SoldierActor soldierActor)) ? 1 : soldierActor.GetPotentialLv());
		_timer = 0;
		_enemyBuffer.Clear();
	}

	public void OnUpdate()
	{
		if (_actor is SoldierActor { isSupport: not false } || _potentialLv < 3 || SupportSkill.summonedChessId == 0)
		{
			return;
		}
		_timer += _actor.LogicDeltaTime;
		if (_timer < spawnInterval)
		{
			return;
		}
		_timer -= spawnInterval;
		if (ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController && soldierLevelController.GetSoldierSummonCount(_actor.Id, SupportSkill.summonedChessId) < maxAliveCount)
		{
			AdventureActor adventureActor = PickRandomEnemy();
			if (!(adventureActor == null))
			{
				SpawnNear(soldierLevelController, adventureActor);
			}
		}
	}

	private AdventureActor PickRandomEnemy()
	{
		_enemyBuffer.Clear();
		List<AdventureActor> confrontFactionActors = ILRuntimeAPI.GetConfrontFactionActors(_actor);
		if (confrontFactionActors == null)
		{
			return null;
		}
		for (int i = 0; i < confrontFactionActors.Count; i++)
		{
			AdventureActor adventureActor = confrontFactionActors.get_Item(i);
			if (!(adventureActor == null))
			{
				ActorHealthInfo actorHealthInfo = adventureActor.actorHealthInfo;
				if (actorHealthInfo != null && actorHealthInfo.isAlive && !adventureActor.IsSearchedImmunity() && !(adventureActor is SoldierActor { isSupport: not false }))
				{
					_enemyBuffer.Add(adventureActor);
				}
			}
		}
		if (_enemyBuffer.Count == 0)
		{
			return null;
		}
		return _enemyBuffer.get_Item(TSRandom.Range(0, _enemyBuffer.Count));
	}

	private void SpawnNear(SoldierLevelController levelController, AdventureActor enemy)
	{
		TSVector2 position = enemy.tsTransform.Position;
		DeterministicShape deterministicCircleShape = CommonUtils.GetDeterministicCircleShape(ringOuterRadius, ringInnerRadius, position);
		TSVector2 result = ILRuntimeAPI.GetRandomPointInShape(_actor, deterministicCircleShape);
		if (!_actor.QueryPositionWalkable(result))
		{
			_actor.QueryClosestPositionWalkable(result, out result);
		}
		TSVector2 normalized = (position - result).normalized;
		levelController.SpawnSoldierSummon(_actor as SoldierActor, SupportSkill.summonedChessId, result, normalized.GetAngle());
	}

	public void OnDisable()
	{
		_timer = 0;
		_enemyBuffer.Clear();
	}
}
