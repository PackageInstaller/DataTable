using System;
using System.Collections.Generic;
using UnityEngine;

namespace BilliardGame.Spell;

[Serializable]
public abstract class BParentNode : BNode
{
	[SerializeField]
	public List<int> nextNodes;

	public abstract bool CanExecute(BTEnv env);

	public virtual int CurrentChildIndex(BTEnv env)
	{
		return 0;
	}

	public virtual void OnChildStarted(BTEnv env)
	{
	}

	public abstract void OnChildExecuted(BTEnv env, BTNodeStatus childStatus);

	public virtual BTNodeStatus OverrideStatus(BTNodeStatus status)
	{
		return status;
	}

	public virtual BTNodeStatus OverrideStatus()
	{
		return BTNodeStatus.Running;
	}
}
