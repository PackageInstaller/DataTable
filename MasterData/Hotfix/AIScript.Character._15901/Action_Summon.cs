using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15901;

public class Action_Summon : AIBase
{
	public FP searchRange = 15;

	public FP rotSpeed = 50;

	private int castLaser = CommonHelper.StringToHash("castLaser");

	private LogicEntity _atkTarget;

	private PlayerAdventureActor _summoner;

	private PlayerAdventureActor mainCtrActor;

	private LookAtTarget lookAtTarget = new LookAtTarget();

	public LogicEntity atkTarget
	{
		get
		{
			if (_atkTarget == null)
			{
				return null;
			}
			if (_atkTarget is AdventureActor adventureActor)
			{
				if (!adventureActor.searchedImmunity && adventureActor.actorHealthInfo.isAlive)
				{
					return _atkTarget;
				}
				return null;
			}
			return null;
		}
		set
		{
			_atkTarget = value;
		}
	}

	public void OnEnable()
	{
		mainCtrActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		_summoner = logicComponent.SummonActor as PlayerAdventureActor;
	}

	public void OnDisable()
	{
		_summoner = null;
		_atkTarget = null;
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	public void OnUpdate()
	{
		MainLoop();
	}

	private void DoMainLogic()
	{
		atkTarget = GetAttackTarget(init: true);
		if (atkTarget != null)
		{
			_actor.LookAt(atkTarget.tsTransform.Position, 0);
			_actor.SyncMovementLocation();
		}
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _summoner;
		adventureActorCustomEvent.eventHashCode = castLaser;
		adventureActorCustomEvent.target = _actor;
		_summoner.DispatchEvent(adventureActorCustomEvent);
	}

	private void MainLoop()
	{
		atkTarget = GetAttackTarget(init: false);
		_actor.attackTarget = atkTarget;
		if (atkTarget != null)
		{
			lookAtTarget.BeginLookAt(_actor, atkTarget, 0, rotSpeed, () =>
			{
			});
		}
	}

	public LogicEntity GetAttackTarget(bool init)
	{
		if (atkTarget == null)
		{
			List<LogicEntity> list = ILRuntimeAPI.SearchByRangeAndPosition(_actor, _actor.tsTransform.Position, searchRange, null, isConfront: true, onlyAlive: true, includeSelf: false, (LogicEntity x) => !x.IsSearchedImmunity());
			if (list.Count > 0)
			{
				if (init)
				{
					_actor.SearchEntitySortByDistance(list);
					return list.get_Item(0);
				}
				_actor.SearchEntitySortByAngle(list);
				return list.get_Item(0);
			}
			return null;
		}
		return atkTarget;
	}
}
