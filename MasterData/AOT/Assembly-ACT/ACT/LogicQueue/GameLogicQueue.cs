using System;
using System.Collections.Generic;
using System.Threading;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.LogicQueue;

public class GameLogicQueue : Singleton<GameLogicQueue>
{
	private bool m_Processing;

	private ILogicActionInternal m_RunningAction;

	private LinkedList<ILogicActionInternal> m_Queue = new LinkedList<ILogicActionInternal>();

	private CancellationTokenSource m_CancellationTokenSource;

	private int m_IncrementActionId = 1;

	public bool Processing => m_Processing;

	public override void Init()
	{
		m_IncrementActionId = 1;
		m_Processing = false;
		m_RunningAction = null;
		m_Queue.Clear();
		m_CancellationTokenSource?.Cancel();
		m_CancellationTokenSource?.Dispose();
		m_CancellationTokenSource = new CancellationTokenSource();
		BeginUpdate(m_CancellationTokenSource.Token);
	}

	public override void UnInit()
	{
		m_Queue.Clear();
		if (m_RunningAction != null && m_RunningAction.State == LogicActionState.Running)
		{
			m_RunningAction.State = LogicActionState.Canceled;
			m_RunningAction.Stop().Forget();
		}
		m_IncrementActionId = 1;
		m_Processing = false;
		m_RunningAction = null;
		m_CancellationTokenSource?.Cancel();
		m_CancellationTokenSource?.Dispose();
		m_CancellationTokenSource = null;
	}

	private async void BeginUpdate(CancellationToken token)
	{
		while (!token.IsCancellationRequested)
		{
			await UniTask.Yield(PlayerLoopTiming.LastPostLateUpdate);
			if (!m_Processing && m_Queue.First != null)
			{
				Process().Forget();
			}
		}
	}

	public LogicActionResult Execute(LogicAction action)
	{
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		m_Queue.AddLast(action);
		((ILogicActionInternal)action).Id = m_IncrementActionId++;
		((ILogicActionInternal)action).State = LogicActionState.Waiting;
		Process().Forget();
		return new LogicActionResult(action, UniTask.WaitUntil(() => action.IsDone));
	}

	private async UniTaskVoid Process()
	{
		if (m_Processing)
		{
			return;
		}
		try
		{
			m_Processing = true;
			int count = m_Queue.Count;
			while (m_Queue.First != null && count > 0)
			{
				count--;
				ILogicActionInternal action = m_Queue.First.Value;
				m_Queue.RemoveFirst();
				if (!action.CanExecute())
				{
					m_Queue.AddLast(action);
					continue;
				}
				try
				{
					action.State = LogicActionState.Running;
					await action.Start();
					if (action.State == LogicActionState.Running)
					{
						action.State = LogicActionState.Finished;
					}
				}
				catch (Exception message)
				{
					Debug.LogError(message);
					if (action.State == LogicActionState.Running)
					{
						action.State = LogicActionState.Error;
					}
				}
			}
		}
		catch (Exception message2)
		{
			Debug.LogError(message2);
		}
		finally
		{
			m_Processing = false;
		}
	}
}
