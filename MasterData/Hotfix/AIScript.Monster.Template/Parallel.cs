#define LOG_WARNING
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster.Template;

public class Parallel : AIBase
{
	private HashSet<int> StateSet = new HashSet<int>();

	private List<CoroutineNode> protectNodes;

	protected PlayerAdventureActor _player;

	public virtual void OnStart()
	{
		InitState();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("SEARCHIMMUNITY_STATE_CHANGE", OnSearchImmunityStateChange);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("FORCE_TARGET_STATE_CHANGE", OnForceTargetStateChange);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
	}

	public virtual void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("SEARCHIMMUNITY_STATE_CHANGE", OnSearchImmunityStateChange);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("FORCE_TARGET_STATE_CHANGE", OnForceTargetStateChange);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
		if (protectNodes == null)
		{
			return;
		}
		foreach (CoroutineNode protectNode in protectNodes)
		{
			_actor.StopLogicCoroutine(protectNode);
		}
		protectNodes.Clear();
		protectNodes = null;
	}

	private void OnForceTargetStateChange(IEvent e)
	{
		if (_actor.actorHealthInfo.isAlive && e is AdventureForceTargetStateChangedEvent adventureForceTargetStateChangedEvent && adventureForceTargetStateChangedEvent.actor.Id == _actor.Id)
		{
			_actor.monsterTarget = _actor.actorSearchTargetInfo.GetMonsterAttackTarget();
		}
	}

	private void OnSearchImmunityStateChange(IEvent e)
	{
		if (_actor.actorHealthInfo.isAlive && !(_actor.monsterTarget == null) && e is AdventureSearchImmunityStateChangedEvent adventureSearchImmunityStateChangedEvent && adventureSearchImmunityStateChangedEvent.actor.Id == _actor.monsterTarget.Id)
		{
			_actor.monsterTarget = _actor.actorSearchTargetInfo.GetMonsterAttackTarget();
		}
	}

	protected virtual void OnActorDied(IEvent e)
	{
		if (e is AdventureActorDiedEvent adventureActorDiedEvent)
		{
			OnDied(adventureActorDiedEvent.actor.dataID);
			if (_actor.actorHealthInfo.isAlive && !(_actor.monsterTarget == null) && adventureActorDiedEvent.actor.Id == _actor.monsterTarget.Id)
			{
				_actor.monsterTarget = _actor.actorSearchTargetInfo.GetMonsterAttackTarget();
			}
		}
	}

	public virtual void OnDied(int monsterId)
	{
	}

	private IEnumerator Search()
	{
		while (true)
		{
			yield return null;
		}
	}

	private void InitState()
	{
		_player = SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor;
		OnInitState();
		SaveMonsterState();
	}

	protected virtual void OnInitState()
	{
	}

	protected bool EnterState(int stateIndex)
	{
		return StateSet.Add(stateIndex);
	}

	protected bool SwitchState(bool breakCurrentAction, bool breakForceControl, int lastStateIndex, int nextStateIndex)
	{
		if (StateSet.Contains(nextStateIndex))
		{
			NovaLogger.Warning($"状态{lastStateIndex}切换至{nextStateIndex}失败,当前已处于{nextStateIndex}状态");
			return false;
		}
		if (StateSet.Contains(lastStateIndex))
		{
			StateSet.Remove(lastStateIndex);
			StateSet.Add(nextStateIndex);
			SaveMonsterState();
			AdventureMonsterSwitchCustomStateEvent adventureMonsterSwitchCustomStateEvent = AdventureMonsterSwitchCustomStateEvent.Generate();
			adventureMonsterSwitchCustomStateEvent.sender = _actor;
			adventureMonsterSwitchCustomStateEvent.commonHandle = true;
			adventureMonsterSwitchCustomStateEvent.breakCurrentAction = breakCurrentAction;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterSwitchCustomStateEvent);
			if (breakForceControl && _actor.state == ActorState.LostControl)
			{
				_actor.InterruptForceControl();
				CoroutineNode item = _actor.StartLogicCoroutine(Protect());
				if (protectNodes == null)
				{
					protectNodes = new List<CoroutineNode>();
				}
				protectNodes.Add(item);
			}
			OnSwitchState();
			return true;
		}
		NovaLogger.Warning($"状态{lastStateIndex}切换至{nextStateIndex}失败,当前不处于{lastStateIndex}状态");
		return false;
	}

	private void SaveMonsterState()
	{
		string text = "";
		foreach (int item in StateSet)
		{
			text = text + item + ",";
		}
		_actor.logicVariable.SetLogicTagStringValue("Monster_In_State", text);
	}

	protected virtual void OnSwitchState()
	{
	}

	protected IEnumerator Protect()
	{
		_actor.EnableImmuneControl();
		(_actor as MonsterAdventureActor).monsterToughnessInfo.lockToughness = true;
		while (_actor.state == ActorState.LostControl)
		{
			yield return null;
		}
		_actor.DisableImmuneControl();
		(_actor as MonsterAdventureActor).monsterToughnessInfo.lockToughness = false;
	}

	protected bool MonsterInState(int state)
	{
		return StateSet.Contains(state);
	}
}
