using System;

namespace GameFramework.Runtime;

public interface IProxyObject : IDisposable
{
	Type Type { get; }

	bool IsRoot { get; }

	object Value { get; set; }

	event EventHandler ValueChanged;

	T GetProperty<T>(string name);

	void SetProperty<T>(string name, T value);

	T GetField<T>(string name);

	void SetField<T>(string name, T value);

	object Invoke(string name, params object[] args);

	object Invoke(string name, Type[] parameterTypes, params object[] args);

	IProxyObject GetPropertyProxy(string name);

	IProxyInvoker GetMethodInvoker(string name);

	IProxyInvoker GetMethodInvoker(string name, Type[] parameterTypes);
}
public interface IProxyObject<T> : IProxyObject, IDisposable
{
	new T Value { get; set; }

	IProxyObject<E> GetPropertyProxy<E>(string name);

	TResult Invoke<TResult>(string name, params object[] args);

	TResult Invoke<TResult>(string name, Type[] parameterTypes, params object[] args);
}
