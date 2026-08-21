using System;

namespace GameFramework.Runtime;

public interface IMessenger
{
	ISubscription<object> Subscribe(Type type, Action<object> action);

	ISubscription<T> Subscribe<T>(Action<T> action);

	ISubscription<object> Subscribe(string channel, Type type, Action<object> action);

	ISubscription<T> Subscribe<T>(string channel, Action<T> action);

	void Publish(object message);

	void Publish<T>(T message);

	void Publish(string channel, object message);

	void Publish<T>(string channel, T message);
}
