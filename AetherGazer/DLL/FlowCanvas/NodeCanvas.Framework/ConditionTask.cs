using System;
using System.Collections;
using UnityEngine;

namespace NodeCanvas.Framework;

public abstract class ConditionTask<T> : ConditionTask where T : class
{
	public sealed override Type agentType => typeof(T);

	public new T agent => base.agent as T;
}
public abstract class ConditionTask : Task
{
	[SerializeField]
	private bool _invert;

	[NonSerialized]
	private int yieldReturn = -1;

	private int yields;

	public bool invert
	{
		get
		{
			return _invert;
		}
		set
		{
			_invert = value;
		}
	}

	public void Enable(Component agent, IBlackboard bb)
	{
		if (Set(agent, bb))
		{
			OnEnable();
		}
	}

	public void Disable()
	{
		base.isActive = false;
		OnDisable();
	}

	public bool CheckCondition(Component agent, IBlackboard blackboard)
	{
		if (!base.isActive)
		{
			return false;
		}
		if (!Set(agent, blackboard))
		{
			return false;
		}
		if (yieldReturn != -1)
		{
			bool result = (invert ? (yieldReturn != 1) : (yieldReturn == 1));
			yieldReturn = -1;
			return result;
		}
		if (!invert)
		{
			return OnCheck();
		}
		return !OnCheck();
	}

	protected void YieldReturn(bool value)
	{
		if (base.isActive)
		{
			yieldReturn = (value ? 1 : 0);
			StartCoroutine(Flip());
		}
	}

	protected virtual void OnEnable()
	{
	}

	protected virtual void OnDisable()
	{
	}

	protected virtual bool OnCheck()
	{
		return true;
	}

	private IEnumerator Flip()
	{
		yields++;
		yield return null;
		yields--;
		if (yields == 0)
		{
			yieldReturn = -1;
		}
	}
}
