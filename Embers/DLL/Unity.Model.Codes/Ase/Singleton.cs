using System;

namespace Ase;

public abstract class Singleton<T> : ISingleton, IDisposable where T : Singleton<T>, new()
{
	private bool isDisposed;

	[StaticField]
	private static T instance;

	public static T Instance => instance;

	void ISingleton.Register()
	{
		if (instance != null)
		{
			throw new Exception("singleton register twice! " + typeof(T).Name);
		}
		instance = (T)this;
	}

	void ISingleton.Destroy()
	{
		if (!isDisposed)
		{
			isDisposed = true;
			instance.Dispose();
			instance = null;
		}
	}

	bool ISingleton.IsDisposed()
	{
		return isDisposed;
	}

	public virtual void Dispose()
	{
	}
}
