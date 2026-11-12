using System.Collections.Generic;
using UnityEngine;

public class ActorFSM : BehaviourFSM<GameObject>
{
	protected AdventureActor _actor;

	public new ActorStateBase GetCurState()
	{
		return (ActorStateBase)_curState;
	}

	public ActorFSM(GameObject owner)
		: base(owner)
	{
		_actor = owner.GetComponent<AdventureActor>();
	}

	public virtual void Enable()
	{
		foreach (KeyValuePair<int, IBehaviourState<GameObject>> item in _dicOfState)
		{
			if (item.Value != null)
			{
				((ActorStateBase)item.Value).OnEnable();
			}
		}
	}

	public virtual void Disable()
	{
		foreach (KeyValuePair<int, IBehaviourState<GameObject>> item in _dicOfState)
		{
			if (item.Value != null)
			{
				((ActorStateBase)item.Value).OnDisable();
			}
		}
	}

	public virtual void Pause()
	{
		GetCurState()?.OnPause();
	}

	public virtual void Resume()
	{
		GetCurState()?.OnResume();
	}
}
