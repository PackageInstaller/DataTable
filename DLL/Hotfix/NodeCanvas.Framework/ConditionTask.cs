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

	private int yieldReturn = -1;

	private int yields;

	private bool isRuntimeEnabled;

	public bool IsRuntimeEnabled => isRuntimeEnabled;

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
		if (!isRuntimeEnabled && base.isUserEnabled && Set(agent, bb))
		{
			isRuntimeEnabled = true;
			OnEnable();
		}
	}

	public void Disable()
	{
		if (isRuntimeEnabled && base.isUserEnabled)
		{
			isRuntimeEnabled = false;
			OnDisable();
		}
	}

	[Obsolete("Use 'Check'")]
	public bool CheckCondition(Component agent, IBlackboard blackboard)
	{
		return Check(agent, blackboard);
	}

	public bool Check(Component agent, IBlackboard blackboard)
	{
		if (!base.isUserEnabled)
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

	public bool CheckOnce(Component agent, IBlackboard blackboard)
	{
		Enable(agent, blackboard);
		bool result = Check(agent, blackboard);
		Disable();
		return result;
	}

	protected void YieldReturn(bool value)
	{
		if (isRuntimeEnabled)
		{
			yieldReturn = (value ? 1 : 0);
			StartCoroutine(Flip());
		}
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
}
