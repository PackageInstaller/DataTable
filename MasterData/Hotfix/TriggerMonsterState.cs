using UnityEngine;

public class TriggerMonsterState : TriggerConditionBase
{
	public enum monsterType
	{
		[InspectorName("指定关系")]
		selectType,
		[InspectorName("指定ID")]
		selectId
	}

	public enum relatiobShip
	{
		[InspectorName("敌对")]
		ennemyType,
		[InspectorName("友好")]
		frendelyType
	}

	public enum monsterState
	{
		[InspectorName("出生")]
		Spawn,
		[InspectorName("待机")]
		Idle,
		[InspectorName("行动")]
		Action,
		[InspectorName("死亡")]
		Death
	}

	public enum stateType
	{
		[InspectorName("进入")]
		enter,
		[InspectorName("退出")]
		exit
	}

	public monsterType _monsterType;

	public relatiobShip _relatiobShip;

	public int monsterID;

	public monsterState _monsterState;

	public stateType _stateType;

	public override void ToActive()
	{
		base.ToActive();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACORTSTATE_CHANGE", OnActorSateChange);
	}

	public override void DisableTrigger()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACORTSTATE_CHANGE", OnActorSateChange);
	}

	protected void OnActorSateChange(IEvent ievent)
	{
		AdventurActorStateChange adventurActorStateChange = (AdventurActorStateChange)ievent;
		if ((bool)(adventurActorStateChange._actor = null) || !(adventurActorStateChange._actor is MonsterAdventureActor))
		{
			return;
		}
		switch (_monsterType)
		{
		case monsterType.selectType:
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor;
			if (playerAdventureActor == null || (playerAdventureActor.IsConfrontWith(adventurActorStateChange._actor) && _relatiobShip != relatiobShip.ennemyType) || (!playerAdventureActor.IsConfrontWith(adventurActorStateChange._actor) && _relatiobShip != relatiobShip.frendelyType))
			{
				return;
			}
			break;
		}
		case monsterType.selectId:
			if (adventurActorStateChange._actor.dataID != monsterID)
			{
				return;
			}
			break;
		}
		bool flag = false;
		switch (adventurActorStateChange.stateID)
		{
		case 1:
			flag = _monsterState == monsterState.Spawn;
			break;
		case 2:
			flag = _monsterState == monsterState.Idle;
			break;
		case 3:
			flag = _monsterState == monsterState.Action;
			break;
		case 5:
			flag = _monsterState == monsterState.Death;
			break;
		}
		if (flag)
		{
			if (_monsterState == monsterState.Death)
			{
				_stateType = stateType.enter;
			}
			if ((_stateType != stateType.enter || adventurActorStateChange.iEnter) && (_stateType != stateType.exit || !adventurActorStateChange.iEnter))
			{
				OnTrigger();
			}
		}
	}
}
