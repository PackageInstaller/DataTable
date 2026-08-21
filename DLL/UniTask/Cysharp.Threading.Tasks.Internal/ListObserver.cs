using System;

namespace Cysharp.Threading.Tasks.Internal;

internal class ListObserver<T> : IObserver<T>
{
	private readonly ImmutableList<IObserver<T>> _observers;

	public ListObserver(ImmutableList<IObserver<T>> observers)
	{
		_observers = observers;
	}

	public void OnCompleted()
	{
		IObserver<T>[] data = _observers.Data;
		for (int i = 0; i < data.Length; i++)
		{
			data[i].OnCompleted();
		}
	}

	public void OnError(Exception error)
	{
		IObserver<T>[] data = _observers.Data;
		for (int i = 0; i < data.Length; i++)
		{
			data[i].OnError(error);
		}
	}

	public void OnNext(T value)
	{
		IObserver<T>[] data = _observers.Data;
		for (int i = 0; i < data.Length; i++)
		{
			data[i].OnNext(value);
		}
	}

	internal IObserver<T> Add(IObserver<T> observer)
	{
		return new ListObserver<T>(_observers.Add(observer));
	}

	internal IObserver<T> Remove(IObserver<T> observer)
	{
		int num = Array.IndexOf(_observers.Data, observer);
		if (num < 0)
		{
			return this;
		}
		if (_observers.Data.Length == 2)
		{
			return _observers.Data[1 - num];
		}
		return new ListObserver<T>(_observers.Remove(observer));
	}
}
