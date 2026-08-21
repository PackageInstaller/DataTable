using System;
using System.Collections;
using System.Collections.Generic;
using Newtonsoft.Json.Serialization;

namespace Newtonsoft.Json.Utilities;

public static class AotHelper
{
	private static bool s_alwaysFalse = DateTime.UtcNow.Year < 0;

	public static void Ensure(Action action)
	{
		if (IsFalse())
		{
			try
			{
				action();
			}
			catch (Exception innerException)
			{
				throw new InvalidOperationException("", innerException);
			}
		}
	}

	public static void EnsureType<T>() where T : new()
	{
		Ensure(delegate
		{
			new T();
		});
	}

	public static void EnsureList<T>()
	{
		Ensure(delegate
		{
			List<T> list = new List<T>();
			new HashSet<T>();
			new CollectionWrapper<T>((IList)list);
			new CollectionWrapper<T>((ICollection<T>)list);
		});
	}

	public static void EnsureDictionary<TKey, TValue>()
	{
		Ensure(delegate
		{
			new Dictionary<TKey, TValue>();
			new DictionaryWrapper<TKey, TValue>((IDictionary)null);
			new DictionaryWrapper<TKey, TValue>((IDictionary<TKey, TValue>)null);
			new DefaultContractResolver.EnumerableDictionaryWrapper<TKey, TValue>(null);
		});
	}

	public static bool IsFalse()
	{
		return s_alwaysFalse;
	}
}
