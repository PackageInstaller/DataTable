#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Threading;

namespace GameFramework.Runtime;

public class Subject<T> : SubjectBase
{
	private class Subscription : ISubscription<T>, IDisposable
	{
		private Subject<T> subject;

		private Action<T> action;

		private SynchronizationContext context;

		private bool disposed = false;

		public string Key { get; private set; }

		public Subscription(Subject<T> subject, Action<T> action)
		{
			this.subject = subject;
			this.action = action;
			Key = Guid.NewGuid().ToString();
			this.subject.Add(this);
		}

		public void Publish(T message)
		{
			try
			{
				if (context != null)
				{
					context.Post(delegate(object state)
					{
						action((T)state);
					}, message);
				}
				else
				{
					action(message);
				}
			}
			catch (Exception message2)
			{
				Log.Error(message2);
			}
		}

		public ISubscription<T> ObserveOn(SynchronizationContext context)
		{
			this.context = context ?? throw new ArgumentNullException("context");
			return this;
		}

		protected virtual void Dispose(bool disposing)
		{
			if (disposed)
			{
				return;
			}
			try
			{
				if (disposed)
				{
					return;
				}
				if (subject != null)
				{
					subject.Remove(this);
				}
				context = null;
				action = null;
				subject = null;
			}
			catch (Exception)
			{
			}
			disposed = true;
		}

		~Subscription()
		{
			Dispose(disposing: false);
		}

		public void Dispose()
		{
			Dispose(disposing: true);
			GC.SuppressFinalize(this);
		}
	}

	private readonly ConcurrentDictionary<string, WeakReference<Subscription>> subscriptions = new ConcurrentDictionary<string, WeakReference<Subscription>>();

	public bool IsEmpty()
	{
		return subscriptions.Count <= 0;
	}

	public override void Publish(object message)
	{
		Publish((T)message);
	}

	public void Publish(T message)
	{
		if (subscriptions.Count <= 0)
		{
			return;
		}
		foreach (KeyValuePair<string, WeakReference<Subscription>> subscription in subscriptions)
		{
			subscription.Value.TryGetTarget(out var target);
			if (target != null)
			{
				target.Publish(message);
			}
			else
			{
				subscriptions.TryRemove(subscription.Key, out var _);
			}
		}
	}

	public ISubscription<T> Subscribe(Action<T> action)
	{
		return new Subscription(this, action);
	}

	private void Add(Subscription subscription)
	{
		WeakReference<Subscription> value = new WeakReference<Subscription>(subscription, trackResurrection: false);
		subscriptions.TryAdd(subscription.Key, value);
	}

	private void Remove(Subscription subscription)
	{
		subscriptions.TryRemove(subscription.Key, out var _);
	}
}
