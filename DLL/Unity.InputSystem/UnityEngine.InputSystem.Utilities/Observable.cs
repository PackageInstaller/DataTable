using System;
using System.Collections.Generic;
using UnityEngine.InputSystem.LowLevel;

namespace UnityEngine.InputSystem.Utilities;

public static class Observable
{
	public static IObservable<TValue> Where<TValue>(this IObservable<TValue> source, Func<TValue, bool> predicate)
	{
		if (source == null)
		{
			throw new ArgumentNullException("source");
		}
		if (predicate == null)
		{
			throw new ArgumentNullException("predicate");
		}
		return new WhereObservable<TValue>(source, predicate);
	}

	public static IObservable<TResult> Select<TSource, TResult>(this IObservable<TSource> source, Func<TSource, TResult> filter)
	{
		if (source == null)
		{
			throw new ArgumentNullException("source");
		}
		if (filter == null)
		{
			throw new ArgumentNullException("filter");
		}
		return new SelectObservable<TSource, TResult>(source, filter);
	}

	public static IObservable<TResult> SelectMany<TSource, TResult>(this IObservable<TSource> source, Func<TSource, IEnumerable<TResult>> filter)
	{
		if (source == null)
		{
			throw new ArgumentNullException("source");
		}
		if (filter == null)
		{
			throw new ArgumentNullException("filter");
		}
		return new SelectManyObservable<TSource, TResult>(source, filter);
	}

	public static IObservable<TValue> Take<TValue>(this IObservable<TValue> source, int count)
	{
		if (source == null)
		{
			throw new ArgumentNullException("source");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count");
		}
		return new TakeNObservable<TValue>(source, count);
	}

	public static IObservable<InputEventPtr> ForDevice(this IObservable<InputEventPtr> source, InputDevice device)
	{
		if (source == null)
		{
			throw new ArgumentNullException("source");
		}
		return new ForDeviceEventObservable(source, null, device);
	}

	public static IObservable<InputEventPtr> ForDevice<TDevice>(this IObservable<InputEventPtr> source) where TDevice : InputDevice
	{
		if (source == null)
		{
			throw new ArgumentNullException("source");
		}
		return new ForDeviceEventObservable(source, typeof(TDevice), null);
	}

	public static IDisposable CallOnce<TValue>(this IObservable<TValue> source, Action<TValue> action)
	{
		if (source == null)
		{
			throw new ArgumentNullException("source");
		}
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		IDisposable subscription = null;
		subscription = source.Take(1).Subscribe(new Observer<TValue>(action, delegate
		{
			subscription?.Dispose();
		}));
		return subscription;
	}

	public static IDisposable Call<TValue>(this IObservable<TValue> source, Action<TValue> action)
	{
		if (source == null)
		{
			throw new ArgumentNullException("source");
		}
		if (action == null)
		{
			throw new ArgumentNullException("action");
		}
		return source.Subscribe(new Observer<TValue>(action));
	}
}
