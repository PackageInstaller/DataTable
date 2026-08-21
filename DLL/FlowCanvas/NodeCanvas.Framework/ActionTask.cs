using System;
using System.Collections;
using ParadoxNotion.Services;
using UnityEngine;

namespace NodeCanvas.Framework;

public abstract class ActionTask<T> : ActionTask where T : class
{
	public sealed override Type agentType => typeof(T);

	public new T agent => base.agent as T;
}
public abstract class ActionTask : Task
{
	[NonSerialized]
	private Status status = Status.Resting;

	[NonSerialized]
	private float startedTime;

	[NonSerialized]
	private float pausedTime;

	[NonSerialized]
	private bool latch;

	[NonSerialized]
	private bool _isPaused;

	public float elapsedTime
	{
		get
		{
			if (isPaused)
			{
				return pausedTime - startedTime;
			}
			if (isRunning)
			{
				return Time.time - startedTime;
			}
			return 0f;
		}
	}

	public bool isRunning => status == Status.Running;

	public bool isPaused
	{
		get
		{
			return _isPaused;
		}
		private set
		{
			_isPaused = value;
		}
	}

	public void ExecuteAction(Component agent, Action<bool> callback)
	{
		ExecuteAction(agent, null, callback);
	}

	public void ExecuteAction(Component agent, IBlackboard blackboard, Action<bool> callback)
	{
		if (!isRunning)
		{
			MonoManager.current.StartCoroutine(ActionUpdater(agent, blackboard, callback));
		}
	}

	private IEnumerator ActionUpdater(Component agent, IBlackboard blackboard, Action<bool> callback)
	{
		while (ExecuteAction(agent, blackboard) == Status.Running)
		{
			yield return null;
		}
		callback?.Invoke(status == Status.Success);
	}

	public Status ExecuteAction(Component agent, IBlackboard blackboard)
	{
		if (!base.isActive)
		{
			return Status.Failure;
		}
		if (isPaused)
		{
			startedTime += Time.time - pausedTime;
			isPaused = false;
		}
		if (status == Status.Running)
		{
			OnUpdate();
			latch = false;
			return status;
		}
		if (latch)
		{
			latch = false;
			return status;
		}
		if (!Set(agent, blackboard))
		{
			return Status.Failure;
		}
		startedTime = Time.time;
		status = Status.Running;
		OnExecute();
		if (status == Status.Running)
		{
			OnUpdate();
		}
		latch = false;
		return status;
	}

	public void EndAction()
	{
		EndAction(success: true);
	}

	public void EndAction(bool success)
	{
		EndAction((bool?)success);
	}

	public void EndAction(bool? success)
	{
		latch = (success.HasValue ? true : false);
		if (status == Status.Running)
		{
			isPaused = false;
			status = ((!success.HasValue) ? Status.Resting : ((success == true) ? Status.Success : Status.Failure));
			OnStop(!success.HasValue);
		}
	}

	public void PauseAction()
	{
		if (status == Status.Running)
		{
			pausedTime = Time.time;
			isPaused = true;
			OnPause();
		}
	}

	protected virtual void OnExecute()
	{
	}

	protected virtual void OnUpdate()
	{
	}

	protected virtual void OnStop()
	{
	}

	protected virtual void OnStop(bool interrupted)
	{
		OnStop();
	}

	protected virtual void OnPause()
	{
	}
}
