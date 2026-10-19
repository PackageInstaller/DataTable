using System;
using System.Collections.Generic;

namespace frame8.Logic.Misc.Other;

public static class DotNETCoreCompat
{
	public static List<TOut> ConvertAll<TIn, TOut>(IEnumerable<TIn> objects, Func<TIn, TOut> converter)
	{
		List<TOut> list = new List<TOut>();
		foreach (TIn @object in objects)
		{
			list.Add(converter(@object));
		}
		return list;
	}

	public static TOut[] ConvertAllToArray<TIn, TOut>(IEnumerable<TIn> objects, Func<TIn, TOut> converter)
	{
		return ConvertAll(objects, converter).ToArray();
	}
}
