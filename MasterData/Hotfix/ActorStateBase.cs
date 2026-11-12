using System;
using System.Collections;
using TrueSync;
using UnityEngine;

public class ActorStateBase
{
	public virtual void OnEnable()
	{
	}

	public virtual void OnDisable()
	{
	}

	public virtual void OnPause()
	{
	}

	public virtual void OnResume()
	{
	}

	public virtual void OnDeterministicCollisionEnter(DeterministicCollider other)
	{
	}

	public virtual void OnDeterministicCollisionStay(DeterministicCollider other)
	{
	}

	public virtual void OnDeterministicCollisionExit(DeterministicCollider other)
	{
	}

	public virtual void OnMovementInput(bool movementHasInput, TSVector2 movementInputVector, TSVector2 movementInputDirection)
	{
	}

	public virtual void OnAnimationStateTransformation(string messageName, Animator animator, AnimatorStateInfo stateInfo, int layerIndex)
	{
	}

	public virtual void OnAnimationStateMachineTransformation(string messageName, Animator animator, int stateMachinePathHash)
	{
	}
}
public class ActorStateBase<T> : ActorStateBase, IBehaviourState<GameObject>, ICoroutineOwner where T : ActorFSM
{
	protected T _fsm;

	protected AdventureActor _actor;

	protected AIAdapter _ai;

	public virtual int GetStateID()
	{
		return 0;
	}

	public void SetFSM(BehaviourFSM<GameObject> fsm)
	{
		_fsm = fsm as T;
		if (_fsm != null)
		{
			_actor = _fsm.owner.GetComponent<AdventureActor>();
		}
	}

	public void SetAI(string aiPath)
	{
		if (_ai == null)
		{
			_ai = new AIAdapter();
			if (!_ai.Initialize(aiPath, _actor.gameObject))
			{
				_ai = null;
			}
		}
	}

	public void ResetAI(string aiPath)
	{
		if (_ai != null)
		{
			_ai.Stop();
			_ai.Disable();
			_ai = null;
		}
		if (!string.IsNullOrEmpty(aiPath))
		{
			_ai = new AIAdapter();
			if (!_ai.Initialize(aiPath, _actor.gameObject))
			{
				_ai = null;
			}
		}
	}

	public void SetAISpecialEnable()
	{
		_ai?.SpecialEnable();
	}

	public void ForceStartAI()
	{
		_ai?.Start();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_ai?.Stop();
		_ai?.Disable();
		_ai?.SpecialDisable();
	}

	public override void OnPause()
	{
		base.OnPause();
		_ai?.Pause();
	}

	public override void OnResume()
	{
		base.OnResume();
		_ai?.Resume();
	}

	public virtual void OnEnter(IBehaviourState<GameObject> preStatus, Action onComplete = null, Action onLeave = null)
	{
		_ai?.Start();
		AdventurActorStateChange adventurActorStateChange = AdventurActorStateChange.Generate();
		if (adventurActorStateChange != null)
		{
			adventurActorStateChange.stateID = GetStateID();
			adventurActorStateChange.iEnter = true;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventurActorStateChange);
		}
	}

	public virtual void OnReset(Action onComplete = null, Action onLeave = null)
	{
	}

	public virtual void OnLeave(IBehaviourState<GameObject> nextState)
	{
		_ai?.Stop();
		AdventurActorStateChange adventurActorStateChange = AdventurActorStateChange.Generate();
		if (adventurActorStateChange != null)
		{
			adventurActorStateChange._actor = _actor;
			adventurActorStateChange.stateID = GetStateID();
			adventurActorStateChange.iEnter = false;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventurActorStateChange);
		}
	}

	public virtual void OnUpdate()
	{
		_ai?.Update();
	}

	protected CoroutineNode StartLogicCoroutine(IEnumerator routine, bool runImmediately = false)
	{
		if (ModuleController<AdventureModuleController>.Instance != null && IsCoroutineAlive())
		{
			return ModuleController<AdventureModuleController>.Instance.logicCoroutineScheduler.StartCoroutine(routine, this, runImmediately);
		}
		return null;
	}

	protected void StopLogicCoroutine(CoroutineNode coroutine)
	{
		if (ModuleController<AdventureModuleController>.Instance != null && IsCoroutineAlive())
		{
			ModuleController<AdventureModuleController>.Instance.logicCoroutineScheduler.StopCoroutine(coroutine);
		}
	}

	public bool IsCoroutineAlive()
	{
		if (_actor.IsCoroutineAlive())
		{
			return _fsm.GetCurState() == this;
		}
		return false;
	}

	public bool IsCoroutineRunning()
	{
		return _actor.IsCoroutineRunning();
	}

	public FP GetCoroutineDeltaTime()
	{
		return _actor.LogicDeltaTime;
	}
}
