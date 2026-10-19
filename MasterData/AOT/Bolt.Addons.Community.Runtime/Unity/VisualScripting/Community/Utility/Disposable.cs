using System;

namespace Unity.VisualScripting.Community.Utility;

[RenamedFrom("Bolt.Addons.Community.Utility.Disposable")]
public class Disposable : IDisposable
{
	public static IDisposable Empty = new Disposable(null);

	private Action _action;

	public static IDisposable Create(Action action)
	{
		return new Disposable(action);
	}

	private Disposable(Action action)
	{
		_action = action;
	}

	void IDisposable.Dispose()
	{
		if (_action != null)
		{
			_action();
			_action = null;
		}
	}
}
