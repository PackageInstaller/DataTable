using System;
using System.Threading;

namespace GameFramework.Network;

public interface INetworkSubscription<T> : IDisposable
{
	INetworkSubscription<T> Filter(Predicate<T> filter);

	INetworkSubscription<T> ObserveOn(SynchronizationContext context);

	INetworkSubscription<T> Subscribe(Action<T> action);
}
