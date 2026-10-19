using System;
using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.LogicQueue;

public abstract class LogicAction : ILogicActionInternal
{
	private int m_Id;

	private LogicActionState m_State;

	private CancellationTokenSource m_CTS;

	int ILogicActionInternal.Id
	{
		get
		{
			return m_Id;
		}
		set
		{
			m_Id = value;
		}
	}

	LogicActionState ILogicActionInternal.State
	{
		get
		{
			return m_State;
		}
		set
		{
			m_State = value;
		}
	}

	public int Id => m_Id;

	public LogicActionState State => m_State;

	public bool IsDone
	{
		get
		{
			LogicActionState state = m_State;
			if ((uint)(state - 1) <= 1u)
			{
				return false;
			}
			return true;
		}
	}

	public virtual bool CanExecute()
	{
		return true;
	}

	public virtual bool CanInterrupt()
	{
		return false;
	}

	async UniTask ILogicActionInternal.Start()
	{
		m_CTS = new CancellationTokenSource();
		try
		{
			await Execute(m_CTS.Token);
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
		m_CTS?.Cancel();
		m_CTS?.Dispose();
	}

	async UniTask ILogicActionInternal.Stop()
	{
		if (m_State == LogicActionState.Running)
		{
			m_CTS?.Cancel();
			m_CTS?.Dispose();
			m_CTS = null;
			await UniTask.WaitUntil(() => IsDone);
		}
	}

	protected virtual UniTask Execute(CancellationToken cancellationToken)
	{
		return UniTask.CompletedTask;
	}
}
