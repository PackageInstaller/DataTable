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
	protected Status status = Status.Resting;

	protected float timeStarted;

	private bool latch;

	protected bool isExecuted;

	public float elapsedTime
	{
		get
		{
			if (!isRunning)
			{
				return 0f;
			}
			return base.ownerSystem.elapsedTime - timeStarted;
		}
	}

	public float IntervalTimer => base.ownerSystem.IntervalTimer;

	public bool isRunning => status == Status.Running;

	public bool isPaused { get; private set; }

	public void ExecuteIndependent(Component agent, IBlackboard blackboard, Action<Status> callback)
	{
		if (!isRunning)
		{
			MonoManager.current.StartCoroutine(IndependentActionUpdater(agent, blackboard, callback));
		}
	}

	public IEnumerator IndependentActionUpdater(Component agent, IBlackboard blackboard, Action<Status> callback)
	{
		while (Execute(agent, blackboard) == Status.Running)
		{
			yield return null;
		}
		callback?.Invoke(status);
	}

	[Obsolete("Use 'Execute'")]
	public Status ExecuteAction(Component agent, IBlackboard blackboard)
	{
		return Execute(agent, blackboard);
	}

	public Status Execute(Component agent, IBlackboard blackboard)
	{
		if (!base.isUserEnabled)
		{
			return Status.Optional;
		}
		if (isPaused)
		{
			OnResume();
		}
		isPaused = false;
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
			latch = false;
			return Status.Failure;
		}
		timeStarted = base.ownerSystem.elapsedTime;
		status = Status.Running;
		OnExecute();
		isExecuted = true;
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
		if (status != Status.Running)
		{
			if (!success.HasValue)
			{
				latch = false;
			}
		}
		else
		{
			latch = (success.HasValue ? true : false);
			isPaused = false;
			status = ((!success.HasValue) ? Status.Resting : ((success == true) ? Status.Success : Status.Failure));
			OnStop(!success.HasValue);
		}
	}

	public void Pause()
	{
		if (status == Status.Running)
		{
			isPaused = true;
			OnPause();
		}
	}

	public void OnGraphStopLogic(bool isExecuteStopLogic)
	{
		if (isExecuted)
		{
			CheckIsExecuteOnGraphStop(isExecuteStopLogic);
			isExecuted = false;
		}
	}

	protected virtual void OnExecute()
	{
	}

	protected virtual void OnUpdate()
	{
	}

	protected virtual void OnStop(bool interrupted)
	{
		OnStop();
	}

	protected virtual void OnStop()
	{
	}

	protected virtual void OnPause()
	{
	}

	protected virtual void OnResume()
	{
	}

	protected virtual void CheckIsExecuteOnGraphStop(bool isExecuteStopLogic)
	{
		if (isExecuteStopLogic)
		{
			OnGraphStop();
		}
	}

	protected virtual void OnGraphStop()
	{
	}
}
