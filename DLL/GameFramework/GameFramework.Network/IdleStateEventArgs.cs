using System;

namespace GameFramework.Network;

public class IdleStateEventArgs : EventArgs
{
	public static readonly IdleStateEventArgs FirstReaderIdleStateEvent = new IdleStateEventArgs(first: true, IdleState.ReaderIdle);

	public static readonly IdleStateEventArgs ReaderIdleStateEvent = new IdleStateEventArgs(first: false, IdleState.ReaderIdle);

	public static readonly IdleStateEventArgs FirstWriterIdleStateEvent = new IdleStateEventArgs(first: true, IdleState.WriterIdle);

	public static readonly IdleStateEventArgs WriterIdleStateEvent = new IdleStateEventArgs(first: false, IdleState.WriterIdle);

	public static readonly IdleStateEventArgs FirstAllIdleStateEvent = new IdleStateEventArgs(first: true, IdleState.AllIdle);

	public static readonly IdleStateEventArgs AllIdleStateEvent = new IdleStateEventArgs(first: false, IdleState.AllIdle);

	public IdleState State { get; }

	public bool IsFirst { get; }

	private IdleStateEventArgs(bool first, IdleState state)
	{
		State = state;
		IsFirst = first;
	}

	public override string ToString()
	{
		return $"IdleStateEvent[first:{IsFirst} state:{State}]";
	}
}
