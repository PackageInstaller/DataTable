using System.Collections.Generic;
using ACT.Core;
using Google.Protobuf.Collections;

namespace ACT.Game.Data;

public static class ProtoExtension
{
	public static void MargeValueFrom<T>(this RepeatedField<T> ts, RepeatedField<T> other) where T : struct
	{
		if (ts == other)
		{
			return;
		}
		foreach (T v in other)
		{
			int num = ts.FindIndex((T x) => x.Equals(v));
			if (num == -1)
			{
				ts.Add(v);
			}
			else
			{
				ts[num] = v;
			}
		}
	}

	public static void MargeFrom<T>(this RepeatedField<T> ts, RepeatedField<T> other) where T : IMargeFrom<T>
	{
		if (ts == other)
		{
			return;
		}
		foreach (T v in other)
		{
			int num = ts.FindIndex((T x) => x.GetId() == v.GetId());
			if (num == -1)
			{
				v.Refresh();
				ts.Add(v);
			}
			else
			{
				ts[num].MargeFrom(v);
			}
		}
	}

	public static void CopyValueFrom<T>(this RepeatedField<T> ts, RepeatedField<T> other)
	{
		if (ts == other)
		{
			return;
		}
		ts.Clear();
		foreach (T item in other)
		{
			ts.Add(item);
		}
	}

	public static void MargeValueFrom<TKey, TValue>(this MapField<TKey, TValue> ts, MapField<TKey, TValue> other) where TValue : struct
	{
		if (ts == other)
		{
			return;
		}
		foreach (KeyValuePair<TKey, TValue> item in other)
		{
			ts[item.Key] = item.Value;
		}
	}

	public static void CopyValueFrom<TKey, TValue>(this MapField<TKey, TValue> ts, MapField<TKey, TValue> other) where TValue : struct
	{
		if (ts == other)
		{
			return;
		}
		ts.Clear();
		foreach (KeyValuePair<TKey, TValue> item in other)
		{
			ts[item.Key] = item.Value;
		}
	}

	public static void MargeFrom<TKey, TValue>(this MapField<TKey, TValue> ts, MapField<TKey, TValue> other) where TValue : IMargeFrom<TValue>
	{
		if (ts == other)
		{
			return;
		}
		foreach (KeyValuePair<TKey, TValue> item in other)
		{
			if (ts.ContainsKey(item.Key))
			{
				ts[item.Key].MargeFrom(item.Value);
			}
			else
			{
				ts.Add(item.Key, item.Value);
			}
		}
	}

	public static void MergeDictionary<TKey, TValue>(this MapField<TKey, TValue> ts, MapField<TKey, TValue> other)
	{
		if (ts == other)
		{
			return;
		}
		foreach (KeyValuePair<TKey, TValue> item in other)
		{
			if (ts.ContainsKey(item.Key))
			{
				ts[item.Key] = item.Value;
			}
			else
			{
				ts.Add(item.Key, item.Value);
			}
		}
	}
}
