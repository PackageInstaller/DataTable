using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.LogicQueue;
using Cysharp.Threading.Tasks;
using Fundamental;

namespace ACT.MissionSystem;

public class MissionFlowTaskLogicAction : LogicAction
{
	private Queue<LogicAction> m_Queue;

	private Func<CancellationToken, UniTask> m_Action;

	public MissionFlowTaskLogicAction(Queue<LogicAction> queue, Func<CancellationToken, UniTask> action)
	{
		m_Queue = queue;
		m_Action = action;
	}

	public override bool CanExecute()
	{
		if (MonoECS.instance.HasAnyPlayerTag(MonoECS.PlayerTag.TeleportMove | MonoECS.PlayerTag.TeleportRespawnAndTpMove))
		{
			return false;
		}
		if (m_Queue.Count == 0)
		{
			return false;
		}
		if (m_Queue.Peek() != this)
		{
			return false;
		}
		if (Singleton<GameState>.instance.GameControlStateMachine.Current != GameControlState.Free)
		{
			return false;
		}
		if (Singleton<GameState>.instance.InSystemUnlock)
		{
			return false;
		}
		return true;
	}

	public override bool CanInterrupt()
	{
		return true;
	}

	protected override async UniTask Execute(CancellationToken cancellationToken)
	{
		try
		{
			await m_Action(cancellationToken);
		}
		finally
		{
			m_Queue.Dequeue();
		}
	}
}
