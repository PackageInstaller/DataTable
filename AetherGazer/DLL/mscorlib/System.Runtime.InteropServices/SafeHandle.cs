using System.Runtime.ConstrainedExecution;
using System.Threading;

namespace System.Runtime.InteropServices;

[StructLayout(LayoutKind.Sequential)]
public abstract class SafeHandle : CriticalFinalizerObject, IDisposable
{
	protected IntPtr handle;

	private int _state;

	private bool _ownsHandle;

	private bool _fullyInitialized;

	private const int RefCount_Mask = 2147483644;

	private const int RefCount_One = 4;

	public bool IsClosed
	{
		[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
		get
		{
			return (_state & 1) == 1;
		}
	}

	public abstract bool IsInvalid
	{
		[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
		get;
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	protected SafeHandle(IntPtr invalidHandleValue, bool ownsHandle)
	{
		handle = invalidHandleValue;
		_state = 4;
		_ownsHandle = ownsHandle;
		if (!ownsHandle)
		{
			GC.SuppressFinalize(this);
		}
		_fullyInitialized = true;
	}

	protected SafeHandle()
	{
		throw new NotImplementedException();
	}

	~SafeHandle()
	{
		Dispose(disposing: false);
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	protected void SetHandle(IntPtr handle)
	{
		this.handle = handle;
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public IntPtr DangerousGetHandle()
	{
		return handle;
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public void Close()
	{
		Dispose(disposing: true);
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public void Dispose()
	{
		Dispose(disposing: true);
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	protected virtual void Dispose(bool disposing)
	{
		if (disposing)
		{
			InternalDispose();
		}
		else
		{
			InternalFinalize();
		}
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	protected abstract bool ReleaseHandle();

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public void SetHandleAsInvalid()
	{
		try
		{
		}
		finally
		{
			int state;
			int value;
			do
			{
				state = _state;
				value = state | 1;
			}
			while (Interlocked.CompareExchange(ref _state, value, state) != state);
			GC.SuppressFinalize(this);
		}
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.MayFail)]
	public void DangerousAddRef(ref bool success)
	{
		try
		{
		}
		finally
		{
			if (!_fullyInitialized)
			{
				throw new InvalidOperationException();
			}
			int state;
			int value;
			do
			{
				state = _state;
				if ((state & 1) != 0)
				{
					throw new ObjectDisposedException(null, "Safe handle has been closed");
				}
				value = state + 4;
			}
			while (Interlocked.CompareExchange(ref _state, value, state) != state);
			success = true;
		}
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	public void DangerousRelease()
	{
		DangerousReleaseInternal(dispose: false);
	}

	private void InternalDispose()
	{
		if (!_fullyInitialized)
		{
			throw new InvalidOperationException();
		}
		DangerousReleaseInternal(dispose: true);
		GC.SuppressFinalize(this);
	}

	private void InternalFinalize()
	{
		if (_fullyInitialized)
		{
			DangerousReleaseInternal(dispose: true);
		}
	}

	private void DangerousReleaseInternal(bool dispose)
	{
		try
		{
		}
		finally
		{
			if (!_fullyInitialized)
			{
				throw new InvalidOperationException();
			}
			bool flag = false;
			int state;
			int num;
			do
			{
				state = _state;
				if (dispose && (state & 2) != 0)
				{
					flag = false;
					break;
				}
				if ((state & 0x7FFFFFFC) == 0)
				{
					throw new ObjectDisposedException(null, "Safe handle has been closed");
				}
				flag = (state & 0x7FFFFFFC) == 4 && (state & 1) == 0 && _ownsHandle && !IsInvalid;
				num = state - 4;
				if ((state & 0x7FFFFFFC) == 4)
				{
					num |= 1;
				}
				if (dispose)
				{
					num |= 2;
				}
			}
			while (Interlocked.CompareExchange(ref _state, num, state) != state);
			if (flag)
			{
				ReleaseHandle();
			}
		}
	}
}
