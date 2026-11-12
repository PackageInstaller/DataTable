using System;
using UnityEngine;

public class MonsterSpawnState : ActorSpawnState
{
	public override void OnEnter(IBehaviourState<GameObject> preStatus, Action onComplete = null, Action onLeave = null)
	{
		base.OnEnter(preStatus, onComplete, onLeave);
		MonsterAdventureActor monster = _actor as MonsterAdventureActor;
		if (_ai == null)
		{
			if (!CheckMonsterSummoner())
			{
				_actor.Idle();
			}
			else if (monster.spawnerInfo.enterActionStateWhenSpawn)
			{
				_actor.Action(makeThreatAlert: false);
				SceneSingleton<AdventurePlayerController>.Instance.ActionAlert(_actor);
			}
			else
			{
				_actor.Idle();
			}
		}
		bool CheckMonsterSummoner()
		{
			MonsterSummonInfo monsterSummonInfo = monster.monsterSummonInfo;
			if (monsterSummonInfo == null)
			{
				return true;
			}
			AdventureActor summonActor = monsterSummonInfo.SummonActor;
			if (null == summonActor)
			{
				return true;
			}
			if (summonActor is PlayerAdventureActor)
			{
				return false;
			}
			return true;
		}
	}
}
