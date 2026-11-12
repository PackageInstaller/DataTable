using System.Collections.Generic;

namespace AIScript.Monster._31301JiJuXie;

public class Action_UltraTornado : MonsterActionBase
{
	private AdventureActor summoner;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		summoner = logicComponent.SummonActor;
		summoner?.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		summoner?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		summoner = null;
	}

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.POOL;
		List<PoolBranchesInfo> poolBranches = new List<PoolBranchesInfo>
		{
			new PoolBranchesInfo
			{
				index = 1,
				braches = new List<PoolBranchInfo>()
			}
		};
		InitPoolBranches(1, poolBranches);
	}

	private void OnCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent)
		{
			_ = adventureActorCustomEvent.sender as AdventureActor != summoner;
		}
	}
}
