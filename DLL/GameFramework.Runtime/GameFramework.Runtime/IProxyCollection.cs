using System;

namespace GameFramework.Runtime;

public interface IProxyCollection : IProxyObject, IDisposable
{
	object this[object key] { get; set; }

	IProxyObject GetItemProxy(object key);
}
public interface IProxyCollection<T> : IProxyObject<T>, IProxyObject, IDisposable, IProxyCollection
{
	new T this[object key] { get; set; }

	new IProxyObject<T> GetItemProxy(object key);
}
