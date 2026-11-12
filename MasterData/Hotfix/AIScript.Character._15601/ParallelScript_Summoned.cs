using System.Collections;
using TrueSync;

namespace AIScript.Character._15601;

public class ParallelScript_Summoned : AIBase
{
	private AdventureActor _summoner;

	public void OnEnable()
	{
		_actor.EnableUnparalleled();
		_summoner = ((MonsterAdventureActor)_actor).monsterSummonInfo.SummonActor;
		FP logicTagValue = _summoner.logicVariable.GetLogicTagValue("SummonedCount");
		_summoner.logicVariable.SetLogicTagValue("SummonedCount", logicTagValue + 1);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
	}

	private void OnBattleReady(IEvent _)
	{
		if (_actor.state == ActorState.Spawn)
		{
			_actor.StartLogicCoroutine(WaitForDestroySelf());
		}
		else
		{
			_actor.DestroySelf();
		}
	}

	private IEnumerator WaitForDestroySelf()
	{
		while (_actor.state == ActorState.Spawn)
		{
			yield return null;
		}
		_actor.DestroySelf();
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		_actor.DisableUnparalleled();
		FP logicTagValue = _summoner.logicVariable.GetLogicTagValue("SummonedCount");
		if (logicTagValue > 0)
		{
			_summoner.logicVariable.SetLogicTagValue("SummonedCount", logicTagValue - 1);
		}
		_summoner = null;
	}
}
