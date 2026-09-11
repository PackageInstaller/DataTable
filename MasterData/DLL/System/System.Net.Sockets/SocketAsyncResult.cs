using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Threading;

namespace System.Net.Sockets;

[StructLayout(LayoutKind.Sequential)]
internal sealed class SocketAsyncResult : IOAsyncResult
{
	public Socket socket;

	public SocketOperation operation;

	private Exception DelayedException;

	public EndPoint EndPoint;

	public Memory<byte> Buffer;

	public int Offset;

	public int Size;

	public SocketFlags SockFlags;

	public Socket AcceptSocket;

	public IPAddress[] Addresses;

	public int Port;

	public IList<ArraySegment<byte>> Buffers;

	public bool ReuseSocket;

	public int CurrentAddress;

	public Socket AcceptedSocket;

	public int Total;

	internal int error;

	public int EndCalled;

	public IntPtr Handle
	{
		get
		{
			if (socket == null)
			{
				return IntPtr.Zero;
			}
			return socket.Handle;
		}
	}

	public SocketError ErrorCode
	{
		get
		{
			if (DelayedException is SocketException ex)
			{
				return ex.SocketErrorCode;
			}
			if (error != 0)
			{
				return (SocketError)error;
			}
			return SocketError.Success;
		}
	}

	public SocketAsyncResult()
	{
	}

	public void Init(Socket socket, AsyncCallback callback, object state, SocketOperation operation)
	{
		Init(callback, state);
		this.socket = socket;
		this.operation = operation;
		DelayedException = null;
		EndPoint = null;
		Buffer = null;
		Offset = 0;
		Size = 0;
		SockFlags = SocketFlags.None;
		AcceptSocket = null;
		Addresses = null;
		Port = 0;
		Buffers = null;
		ReuseSocket = false;
		CurrentAddress = 0;
		AcceptedSocket = null;
		Total = 0;
		error = 0;
		EndCalled = 0;
	}

	public SocketAsyncResult(Socket socket, AsyncCallback callback, object state, SocketOperation operation)
		: base(callback, state)
	{
		this.socket = socket;
		this.operation = operation;
	}

	public void CheckIfThrowDelayedException()
	{
		if (DelayedException != null)
		{
			socket.is_connected = false;
			throw DelayedException;
		}
		if (error != 0)
		{
			socket.is_connected = false;
			throw new SocketException(error);
		}
	}

	internal override void CompleteDisposed()
	{
		Complete();
	}

	public void Complete()
	{
		if (operation != SocketOperation.Receive && this.socket.CleanedUp)
		{
			DelayedException = new ObjectDisposedException(this.socket.GetType().ToString());
		}
		base.IsCompleted = true;
		Socket socket = this.socket;
		SocketOperation socketOperation = operation;
		if (!base.CompletedSynchronously && base.AsyncCallback != null)
		{
			ThreadPool.UnsafeQueueUserWorkItem(delegate(object state)
			{
				((SocketAsyncResult)state).AsyncCallback((SocketAsyncResult)state);
			}, this);
		}
		switch (socketOperation)
		{
		case SocketOperation.Accept:
		case SocketOperation.Receive:
		case SocketOperation.ReceiveFrom:
		case SocketOperation.ReceiveGeneric:
			socket.ReadSem.Release();
			break;
		case SocketOperation.Send:
		case SocketOperation.SendTo:
		case SocketOperation.SendGeneric:
			socket.WriteSem.Release();
			break;
		case SocketOperation.Connect:
		case SocketOperation.RecvJustCallback:
		case SocketOperation.SendJustCallback:
		case SocketOperation.Disconnect:
		case SocketOperation.AcceptReceive:
			break;
		}
	}

	public void Complete(bool synch)
	{
		base.CompletedSynchronously = synch;
		Complete();
	}

	public void Complete(int total)
	{
		Total = total;
		Complete();
	}

	public void Complete(Exception e, bool synch)
	{
		DelayedException = e;
		base.CompletedSynchronously = synch;
		Complete();
	}

	public void Complete(Exception e)
	{
		DelayedException = e;
		Complete();
	}

	public void Complete(Socket s)
	{
		AcceptedSocket = s;
		Complete();
	}

	public void Complete(Socket s, int total)
	{
		AcceptedSocket = s;
		Total = total;
		Complete();
	}
}
