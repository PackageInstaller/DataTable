using System;
using System.Threading;

namespace GameFramework.Runtime;

public interface ISubscription<T> : IDisposable
{
	ISubscription<T> ObserveOn(SynchronizationContext context);
}
