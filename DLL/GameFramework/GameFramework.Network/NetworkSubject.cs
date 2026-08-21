#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Threading;

namespace GameFramework.Network;

public class NetworkSubject<T> : IDisposable
{
	private class NetworkSubscription : INetworkSubscription<T>, IDisposable
	{
		private NetworkSubject<T> networkSubject;

		private Predicate<T> filter;

		private Action<T> action;

		private SynchronizationContext context;

		private bool disposed = false;

		public string Key { get; private set; }

		public NetworkSubscription(NetworkSubject<T> networkSubject)
			: this(networkSubject, (Predicate<T>)null)
		{
		}

		public NetworkSubscription(NetworkSubject<T> networkSubject, Predicate<T> filter)
		{
			Key = Guid.NewGuid().ToString();
			this.networkSubject = networkSubject ?? throw new ArgumentNullException("networkSubject");
			this.filter = filter;
		}

		public void Publish(T message)
		{
			try
			{
				if (filter != null && !filter(message))
				{
					return;
				}
				if (context != null)
				{
					context.Post(delegate(object state)
					{
						if (action != null)
						{
							action((T)state);
						}
					}, message);
				}
				else if (action != null)
				{
					action(message);
				}
			}
			catch (Exception message2)
			{
				Log.Error(message2);
			}
		}

		public INetworkSubscription<T> Filter(Predicate<T> filter)
		{
			if (action != null)
			{
				throw new InvalidOperationException("Please register the filter before the Subscribe() function is called");
			}
			this.filter = filter ?? throw new ArgumentNullException("filter");
			return this;
		}

		public INetworkSubscription<T> ObserveOn(SynchronizationContext context)
		{
			if (action != null)
			{
				throw new InvalidOperationException("Please set the SynchronizationContext before the Subscribe() function is called");
			}
			this.context = context ?? throw new ArgumentNullException("context");
			return this;
		}

		public INetworkSubscription<T> Subscribe(Action<T> action)
		{
			if (this.action != null)
			{
				throw new InvalidOperationException("The action already exists, please do not subscribe again");
			}
			this.action = action ?? throw new ArgumentNullException("action");
			networkSubject.Add(this);
			return this;
		}

		protected virtual void Dispose(bool disposing)
		{
			try
			{
				if (disposed)
				{
					return;
				}
				if (networkSubject != null)
				{
					networkSubject.Remove(this);
				}
				Key = null;
				context = null;
				action = null;
				filter = null;
				networkSubject = null;
			}
			catch (Exception)
			{
			}
			disposed = true;
		}

		~NetworkSubscription()
		{
			Dispose(disposing: false);
		}

		public void Dispose()
		{
			Dispose(disposing: true);
			GC.SuppressFinalize(this);
		}
	}

	private readonly ConcurrentDictionary<string, WeakReference<NetworkSubscription>> subscriptions = new ConcurrentDictionary<string, WeakReference<NetworkSubscription>>();

	private bool disposedValue = false;

	public virtual void Publish(T message)
	{
		if (subscriptions.Count <= 0)
		{
			return;
		}
		foreach (KeyValuePair<string, WeakReference<NetworkSubscription>> subscription in subscriptions)
		{
			string key = subscription.Key;
			WeakReference<NetworkSubscription> value = subscription.Value;
			if (value.TryGetTarget(out var target) && target != null)
			{
				target.Publish(message);
			}
			else
			{
				subscriptions.TryRemove(key, out WeakReference<NetworkSubscription> _);
			}
		}
	}

	public virtual INetworkSubscription<T> Subscribe()
	{
		return new NetworkSubscription(this);
	}

	public virtual INetworkSubscription<T> Subscribe(Predicate<T> filter)
	{
		return new NetworkSubscription(this, filter);
	}

	private void Add(NetworkSubscription networkSubscription)
	{
		WeakReference<NetworkSubscription> value = new WeakReference<NetworkSubscription>(networkSubscription, trackResurrection: false);
		subscriptions.TryAdd(networkSubscription.Key, value);
	}

	private void Remove(NetworkSubscription networkSubscription)
	{
		subscriptions.TryRemove(networkSubscription.Key, out WeakReference<NetworkSubscription> _);
	}

	protected virtual void Dispose(bool disposing)
	{
		if (!disposedValue)
		{
			subscriptions.Clear();
			disposedValue = true;
		}
	}

	public void Dispose()
	{
		Dispose(disposing: true);
	}
}
