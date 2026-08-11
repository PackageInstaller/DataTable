using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class BattleMessenger : IMessenger
{
	public static readonly Messenger Default = new Messenger();

	private readonly ConcurrentDictionary<Type, SubjectBase> notifiers = new ConcurrentDictionary<Type, SubjectBase>();

	private readonly ConcurrentDictionary<string, ConcurrentDictionary<Type, SubjectBase>> channelNotifiers = new ConcurrentDictionary<string, ConcurrentDictionary<Type, SubjectBase>>();

	public virtual ISubscription<object> Subscribe(Type type, Action<object> action)
	{
		if (!notifiers.TryGetValue(type, out var value))
		{
			value = new Subject<object>();
			if (!notifiers.TryAdd(type, value))
			{
				notifiers.TryGetValue(type, out value);
			}
		}
		return (value as Subject<object>).Subscribe(action);
	}

	public virtual ISubscription<T> Subscribe<T>(Action<T> action)
	{
		Type typeFromHandle = typeof(T);
		if (!notifiers.TryGetValue(typeFromHandle, out var value))
		{
			value = new Subject<T>();
			if (!notifiers.TryAdd(typeFromHandle, value))
			{
				notifiers.TryGetValue(typeFromHandle, out value);
			}
		}
		return (value as Subject<T>).Subscribe(action);
	}

	public virtual ISubscription<object> Subscribe(string channel, Type type, Action<object> action)
	{
		SubjectBase value = null;
		ConcurrentDictionary<Type, SubjectBase> value2 = null;
		if (!channelNotifiers.TryGetValue(channel, out value2))
		{
			value2 = new ConcurrentDictionary<Type, SubjectBase>();
			if (!channelNotifiers.TryAdd(channel, value2))
			{
				channelNotifiers.TryGetValue(channel, out value2);
			}
		}
		if (!value2.TryGetValue(type, out value))
		{
			value = new Subject<object>();
			if (!value2.TryAdd(type, value))
			{
				value2.TryGetValue(type, out value);
			}
		}
		return (value as Subject<object>).Subscribe(action);
	}

	public virtual ISubscription<T> Subscribe<T>(string channel, Action<T> action)
	{
		SubjectBase value = null;
		ConcurrentDictionary<Type, SubjectBase> value2 = null;
		if (!channelNotifiers.TryGetValue(channel, out value2))
		{
			value2 = new ConcurrentDictionary<Type, SubjectBase>();
			if (!channelNotifiers.TryAdd(channel, value2))
			{
				channelNotifiers.TryGetValue(channel, out value2);
			}
		}
		if (!value2.TryGetValue(typeof(T), out value))
		{
			value = new Subject<T>();
			if (!value2.TryAdd(typeof(T), value))
			{
				value2.TryGetValue(typeof(T), out value);
			}
		}
		return (value as Subject<T>).Subscribe(action);
	}

	public virtual void Publish(object message)
	{
		this.Publish<object>(message);
	}

	public virtual void Publish<T>(T message)
	{
		if (message == null || notifiers.Count <= 0)
		{
			return;
		}
		Type type = message.GetType();
		foreach (KeyValuePair<Type, SubjectBase> notifier in notifiers)
		{
			try
			{
				if (notifier.Key.IsAssignableFrom(type))
				{
					notifier.Value.Publish(message);
				}
			}
			catch (Exception)
			{
			}
		}
	}

	public virtual void Publish(string channel, object message)
	{
		this.Publish<object>(channel, message);
	}

	public virtual void Publish<T>(string channel, T message)
	{
		if (string.IsNullOrEmpty(channel) || message == null)
		{
			return;
		}
		Publish(message);
		ConcurrentDictionary<Type, SubjectBase> value = null;
		if (!channelNotifiers.TryGetValue(channel, out value) || value.Count <= 0)
		{
			return;
		}
		Type type = message.GetType();
		foreach (KeyValuePair<Type, SubjectBase> item in value)
		{
			try
			{
				if (item.Key.IsAssignableFrom(type))
				{
					item.Value.Publish(message);
				}
			}
			catch (Exception)
			{
			}
		}
	}
}
