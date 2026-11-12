using System.Collections.Generic;
using AdventureBehaviour;

namespace AIScript.Monster.Common;

public class Idle : AIBase
{
	protected List<LogicEntity> scopeVision;

	protected List<LogicEntity> scopeHear;

	public bool onlyAlive = true;

	public bool includeSelf;

	public void OnUpdate()
	{
		MonsterAdventureActor monsterAdventureActor = _actor as MonsterAdventureActor;
		if (monsterAdventureActor == null || (!ModuleController<AdventureModuleController>.Instance.InBattleState && !monsterAdventureActor.IsPlayerSummoned(out var _, out var _)))
		{
			return;
		}
		ILRuntimeAPI.RangeSearch(_actor, (List<LogicEntity> result) =>
		{
			if (result.Count > 0)
			{
				_actor.Action();
			}
		});
	}
}
