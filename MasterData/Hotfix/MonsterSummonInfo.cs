using System.Collections;
using TrueSync;
using UnityEngine;

public class MonsterSummonInfo : LogicComponent, ILogicComponentUpdate, ILogicComponent
{
	private bool _isDestroy;

	private MonsterAdventureActor _actor => (MonsterAdventureActor)Entity;

	public AdventureActor SummonActor { get; private set; }

	public long SummonActorId
	{
		get
		{
			if (SummonActor != null)
			{
				return SummonActor.Id;
			}
			return -1L;
		}
	}

	public SummonCfg SummonCfg { get; private set; }

	public SummonType SummonType { get; private set; }

	public bool IsCoexisted { get; private set; }

	public bool HaveLeftTime { get; private set; }

	public FP LeftTime { get; private set; }

	public bool UseSummonHit { get; private set; }

	public override void OnActive()
	{
		SummonActor = null;
		SummonCfg = null;
		SummonType = SummonType.None;
		IsCoexisted = false;
		HaveLeftTime = false;
		LeftTime = 0;
		UseSummonHit = false;
		_isDestroy = false;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
	}

	public void OnLogicUpdate()
	{
		if (HaveLeftTime)
		{
			if (LeftTime > 0)
			{
				LeftTime -= _actor.LogicDeltaTime;
			}
			else
			{
				DestroySelf();
			}
		}
	}

	public override void OnDeactive()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
	}

	private void OnActorDied(IEvent evt)
	{
		if (!(_actor == null) && !(SummonActor == null) && evt is AdventureActorDiedEvent adventureActorDiedEvent && adventureActorDiedEvent.actor == SummonActor && IsCoexisted)
		{
			DestroySelf();
		}
	}

	internal void ParseSummonCfg(SummonCfg cfgData, ActorSpawnInfo actorSpawnInfo)
	{
		SummonActor = actorSpawnInfo.summoner;
		SummonCfg = cfgData;
		if (SummonActor == null)
		{
			return;
		}
		SummonType = cfgData?.summonType ?? SummonType.Minion;
		UseSummonHit = cfgData?.useSummonHit ?? false;
		SummonFollowType summonFollowType = cfgData?.summonFollowType ?? SummonFollowType.NotFollow;
		SummonAttrType summonAttrType = cfgData?.summonAttrType ?? SummonAttrType.Self;
		SummonRelation summonRelation = cfgData?.summonRelation ?? SummonRelation.Independent;
		int percent = cfgData?.attrPercent ?? 100;
		FP leftTime = cfgData?.leftTime ?? ((FP)0);
		AdventureActor summonActor = SummonActor;
		if (summonActor is PlayerAdventureActor || summonActor is DynamicActor)
		{
			if (summonFollowType == SummonFollowType.NotFollow)
			{
				switch (summonAttrType)
				{
				case SummonAttrType.Inherit:
					_actor?.SetPlayerSummonAttrInfo(SummonActor, percent);
					break;
				case SummonAttrType.InheritByInitialSnapshot:
					if (SummonActor is PlayerAdventureActor player)
					{
						_actor?.SetPlayerSummonAttrInfoBySnapshot(player, percent);
						break;
					}
					Debug.LogWarning($"召唤者非角色,不支持继承初始属性快照,已退化为继承实时属性,召唤者DataId:{SummonActor.dataID},召唤物DataId:{_actor.dataID}");
					_actor?.SetPlayerSummonAttrInfo(SummonActor, percent);
					break;
				default:
				{
					int attrTempleteID = _actor.attrTempleteID;
					int levelDifficultLv = 1;
					CalcRougeAttr(attrTempleteID, levelDifficultLv, percent);
					break;
				}
				}
			}
			else
			{
				_actor.actorInfo = SummonActor.actorInfo;
				_actor.actorElementInfo = SummonActor.actorElementInfo;
			}
		}
		else
		{
			int templeteId = ((summonAttrType == SummonAttrType.Inherit) ? SummonActor.attrTempleteID : _actor.attrTempleteID);
			int levelDifficultLv2 = 1;
			if (SummonActor is MonsterAdventureActor { HasBattleLevelUp: not false, summonMonsterUseBattleLevelAsDifficultLevel: not false } monsterAdventureActor)
			{
				levelDifficultLv2 = monsterAdventureActor.BattleLevel;
			}
			else if (actorSpawnInfo.isRoguelikeMonster)
			{
				levelDifficultLv2 = ModuleController<AdventureModuleController>.Instance.levelLoadParams.levelDifficultLv;
			}
			CalcRougeAttr(templeteId, levelDifficultLv2, percent);
		}
		IsCoexisted = summonRelation == SummonRelation.Coexisted;
		LeftTime = leftTime;
		HaveLeftTime = LeftTime > 0;
		_isDestroy = false;
		ModuleController<AdventureModuleController>.Instance?.AddMonsterSummons(_actor, Entity.Id, SummonActor.Id, SummonActor is PlayerAdventureActor);
	}

	private void CalcRougeAttr(int templeteId, int levelDifficultLv, int percent)
	{
		_actor?.SetRoguelikeAttrInfo(templeteId, levelDifficultLv, percent);
	}

	public void AddLeftTime(FP addTime)
	{
		if (HaveLeftTime)
		{
			LeftTime += addTime;
		}
	}

	public void ResetLeftTime()
	{
		if (HaveLeftTime)
		{
			LeftTime = SummonCfg.leftTime;
		}
	}

	public void DestroySelf()
	{
		if (!_isDestroy)
		{
			_isDestroy = true;
			if (_actor.state == ActorState.Spawn)
			{
				_actor.StartLogicCoroutine(WaitForDestroySelf());
			}
			else
			{
				_actor.DestroySelf();
			}
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
}
