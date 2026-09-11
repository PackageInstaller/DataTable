using System;
using System.Threading;

namespace MessagePack;

internal struct MonoProtectionDisposal : IDisposable
{
	private readonly object lockObject;

	internal MonoProtectionDisposal(object lockObject)
	{
		this.lockObject = lockObject;
		Monitor.Enter(lockObject);
	}

	public void Dispose()
	{
		if (lockObject != null)
		{
			Monitor.Exit(lockObject);
		}
	}
}
