using System;
using System.Collections.Generic;

namespace Sirenix.Utilities;

public static class DelegateExtensions
{
	public static Func<TResult> Memoize<TResult>(this Func<TResult> getValue)
	{
		TResult value = default;
		bool hasValue = false;
		return () =>
		{
			if (!hasValue)
			{
				hasValue = true;
				value = getValue();
			}
			return value;
		};
	}

	public static Func<T, TResult> Memoize<T, TResult>(this Func<T, TResult> func)
	{
		Dictionary<T, TResult> dic = new Dictionary<T, TResult>();
		return (T n) =>
		{
			if (!dic.TryGetValue(n, out var value))
			{
				value = func(n);
				dic.Add(n, value);
			}
			return value;
		};
	}
}
