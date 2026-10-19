using System.Collections.Generic;
using UnityEngine.Localization.SmartFormat.Core.Parsing;
using UnityEngine.Pool;

namespace UnityEngine.Localization.SmartFormat;

internal static class SplitListPool
{
	internal static readonly ObjectPool<Format.SplitList> s_Pool = new ObjectPool<Format.SplitList>(() => new Format.SplitList(), null, (Format.SplitList sl) =>
	{
		sl.Clear();
	});

	public static Format.SplitList Get(Format format, List<int> splits)
	{
		Format.SplitList splitList = s_Pool.Get();
		splitList.Init(format, splits);
		return splitList;
	}

	public static void Release(Format.SplitList toRelease)
	{
		s_Pool.Release(toRelease);
	}
}
