using System.Collections.Generic;
using Pathfinding;
using Pathfinding.Util;

public static class SimPathFunnelModifier
{
	public static void Apply(Path p, bool unwrap, bool splitAtEveryPortal)
	{
		if (p.path == null || p.path.Count == 0 || p.int3Path == null || p.int3Path.Count == 0)
		{
			XLogger.Debug("p.path == " + p.path.Count + "," + p.int3Path.Count);
			return;
		}
		List<Int3> list = ListPool<Int3>.Claim();
		List<Funnel.PathPart> list2 = Funnel.SplitIntoParts(p);
		for (int i = 0; i < list2.Count; i++)
		{
			Funnel.PathPart part = list2[i];
			if (!part.isLink)
			{
				Funnel.FunnelPortals funnel = Funnel.ConstructFunnelPortals(p.path, part);
				List<Int3> list3 = Funnel.Calculate(funnel, unwrap, splitAtEveryPortal);
				list.AddRange(list3);
				ListPool<Int3>.Release(list3);
			}
		}
		ListPool<Funnel.PathPart>.Release(list2);
		ListPool<Int3>.Release(p.int3Path);
		p.int3Path = list;
	}
}
