using System;
using System.Collections;
using System.Collections.Generic;
using Sirenix.OdinInspector;
using UnityEngine;

namespace Dorm.Character;

public class EntityCmdExecutor : SerializedMonoBehaviour, IEidProvider
{
	private enum ExecuteState
	{
		Abort,
		RunCmd
	}

	public DormComplexEntity entity;

	private Queue<CmdTask> cmdQueue = new Queue<CmdTask>();

	private Coroutine curTask;

	private ExecuteState state;

	public const int ALWAYS_INTERRUPT = int.MaxValue;

	public const int IDLE = 0;

	private IEnumerator task;

	private bool inFinishSection;

	private bool skipTick;

	public int EntityID => entity.id;

	public CmdTask CurCmdTask
	{
		get
		{
			if (cmdQueue.TryPeek(out var result))
			{
				return result;
			}
			return null;
		}
	}

	public int PendingCmdNum => cmdQueue.Count;

	internal void OnDisable()
	{
		if (curTask != null)
		{
			StopCoroutine(curTask);
		}
		curTask = null;
		Abort(treatCurCmdAsFinished: false);
	}

	internal void OnEnable()
	{
		Restart();
	}

	public void StopAllCmdTask(bool treatCurCmdAsFinished = false)
	{
		if (PendingCmdNum != 0)
		{
			Abort(treatCurCmdAsFinished);
			cmdQueue.Clear();
		}
	}

	public void ClearAllPendingCmdTask()
	{
		bool num = cmdQueue.TryDequeue(out var result);
		cmdQueue.Clear();
		if (num)
		{
			cmdQueue.Enqueue(result);
		}
	}

	private void Restart()
	{
		curTask = StartCoroutine(StartTask());
	}

	private IEnumerator StartTask()
	{
		yield return null;
		while (true)
		{
			if (PendingCmdNum != 0)
			{
				state = ExecuteState.RunCmd;
			}
			CmdTask cmd;
			while (state == ExecuteState.RunCmd && cmdQueue.TryPeek(out cmd))
			{
				if (!cmd.IsStarted)
				{
					task = cmd.Start(this);
				}
				while (state == ExecuteState.RunCmd)
				{
					if (skipTick)
					{
						skipTick = false;
						yield return task.Current;
						continue;
					}
					bool flag = false;
					try
					{
						flag = task?.MoveNext() ?? false;
					}
					catch (Exception exception)
					{
						Debug.LogException(exception);
					}
					if (!flag)
					{
						break;
					}
					if (task == null)
					{
						yield return null;
					}
					else
					{
						yield return task.Current;
					}
				}
				if (state == ExecuteState.RunCmd)
				{
					inFinishSection = true;
					cmdQueue.TryDequeue(out var _);
					cmd.Finish(this);
					inFinishSection = false;
				}
			}
			if (PendingCmdNum == 0)
			{
				entity.ResetCallOnceBeforeIdle();
				DormEntityAction.Notify("ON_DORM_CHARACTER_WAIT_CMD", EntityID);
				while (PendingCmdNum == 0)
				{
					entity.IdleUpdate();
					yield return null;
				}
				state = ExecuteState.RunCmd;
			}
			yield return null;
		}
	}

	internal void Abort(bool treatCurCmdAsFinished)
	{
		if (state == ExecuteState.Abort)
		{
			return;
		}
		state = ExecuteState.Abort;
		task = null;
		if (cmdQueue.TryDequeue(out var result))
		{
			if (treatCurCmdAsFinished)
			{
				result.Finish(this);
			}
			else
			{
				result.Abort(this);
			}
		}
	}

	public bool CanAccept(DormEntityManager.EntityCmdPriority priority)
	{
		int num = (cmdQueue.TryPeek(out var result) ? result.InterruptLevel : 0);
		return (int)priority > num;
	}

	public bool SendCmd(CmdTask cmd, bool queue)
	{
		int num = (cmdQueue.TryPeek(out var result) ? result.InterruptLevel : 0);
		if (queue || num == 0)
		{
			cmdQueue.Enqueue(cmd);
			return true;
		}
		if (cmd.InterruptLevel > num || cmd.InterruptLevel == int.MaxValue)
		{
			Abort(treatCurCmdAsFinished: false);
			cmdQueue.Clear();
			cmdQueue.Enqueue(cmd);
			return true;
		}
		return false;
	}

	public bool ExecuteCmdImmediate(CmdTask cmd)
	{
		if (inFinishSection)
		{
			return SendCmd(cmd, queue: false);
		}
		int num = (cmdQueue.TryPeek(out var result) ? result.InterruptLevel : 0);
		if (cmd.InterruptLevel > num || cmd.InterruptLevel == int.MaxValue)
		{
			Abort(treatCurCmdAsFinished: false);
			cmdQueue.Clear();
			cmdQueue.Enqueue(cmd);
			task = cmd.Start(this);
			task.MoveNext();
			skipTick = true;
			state = ExecuteState.RunCmd;
			return true;
		}
		return false;
	}

	internal void TakeOverCmdExecuteFrom(EntityCmdExecutor old)
	{
		if (this != old)
		{
			cmdQueue = old.cmdQueue;
			UnityEngine.Object.Destroy(old);
		}
	}
}
