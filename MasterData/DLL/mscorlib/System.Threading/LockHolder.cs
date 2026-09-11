using System.Runtime.CompilerServices;

namespace System.Threading;

[ReflectionBlocked]
public struct LockHolder : IDisposable
{
	private Lock _lock;

	[MethodImpl((MethodImplOptions)256)]
	public static LockHolder Hold(Lock l)
	{
		l.Acquire();
		LockHolder result = default(LockHolder);
		result._lock = l;
		return result;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Dispose()
	{
		_lock.Release();
	}
}
