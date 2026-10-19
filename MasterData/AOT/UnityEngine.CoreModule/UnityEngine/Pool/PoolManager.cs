using System;
using System.Collections.Generic;

namespace UnityEngine.Pool;

internal static class PoolManager
{
	private static readonly List<WeakReference<IPool>> s_WeakPoolReferences = new List<WeakReference<IPool>>();

	public static void Register(IPool pool)
	{
		s_WeakPoolReferences.Add(new WeakReference<IPool>(pool));
	}
}
