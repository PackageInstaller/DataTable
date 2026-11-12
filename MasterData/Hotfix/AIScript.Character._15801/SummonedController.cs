using System.Collections.Generic;

namespace AIScript.Character._15801;

public class SummonedController
{
	protected PlayerAdventureActor _actor;

	private List<MonsterAdventureActor> _minionList;

	public SummonedController(PlayerAdventureActor actor)
	{
		_actor = actor;
	}

	public virtual void OnEnable()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnSummonedSpawn);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDied);
	}

	public virtual void Init()
	{
	}

	private void OnSummonedSpawn(IEvent evt)
	{
		if (evt is AdventureMonsterSummonerSpawnedEvent { sender: MonsterAdventureActor sender } && sender.IsPlayerMinion(out var summoner) && summoner == _actor)
		{
			if (_minionList == null)
			{
				_minionList = new List<MonsterAdventureActor>(5);
			}
			_minionList.Add(sender);
			OnMinionCountChange();
			OnSelfMinionSpawn(sender);
		}
	}

	protected virtual void OnSelfMinionSpawn(MonsterAdventureActor minion)
	{
	}

	private void OnMonsterDied(IEvent evt)
	{
		if (evt is AdventureMonsterDiedEvent { sender: MonsterAdventureActor sender } && sender.IsPlayerMinion(out var summoner) && summoner == _actor)
		{
			_minionList?.Remove(sender);
			OnMinionCountChange();
			OnSelfMinionDied(sender);
		}
	}

	protected virtual void OnSelfMinionDied(MonsterAdventureActor minion)
	{
	}

	private void OnMinionCountChange()
	{
		if (!ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 1))
		{
			return;
		}
		List<MonsterAdventureActor> minionList = _minionList;
		if (minionList != null && minionList.Count > 0)
		{
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				if (actorL.actorElementInfo.elementType == HotfixEnum.elementType.FE)
				{
					actorL.buffComponent.AddBuff(15896111, _actor);
				}
			}
			return;
		}
		foreach (PlayerAdventureActor actorL2 in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			if (actorL2.actorElementInfo.elementType == HotfixEnum.elementType.FE)
			{
				actorL2.buffComponent.RemoveBuffByBuffId(15896111);
			}
		}
	}

	public void AddBuffToMinion(int buffId, int buffNum = 1)
	{
		if (buffId <= 0 || buffNum <= 0)
		{
			return;
		}
		List<MonsterAdventureActor> minionList = _minionList;
		if (minionList == null || minionList.Count <= 0)
		{
			return;
		}
		foreach (MonsterAdventureActor minion in _minionList)
		{
			minion?.buffComponent.AddBuffNum(buffId, buffNum, _actor);
		}
	}

	public void RemoveBuffFromMinion(int buffId, int reduceNum = 0)
	{
		if (buffId <= 0 || reduceNum < 0)
		{
			return;
		}
		List<MonsterAdventureActor> minionList = _minionList;
		if (minionList == null || minionList.Count <= 0)
		{
			return;
		}
		foreach (MonsterAdventureActor minion in _minionList)
		{
			minion?.buffComponent.RemoveBuffByBuffId(buffId, reduceNum);
		}
	}

	public virtual void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnSummonedSpawn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDied);
		_minionList?.Clear();
	}
}
