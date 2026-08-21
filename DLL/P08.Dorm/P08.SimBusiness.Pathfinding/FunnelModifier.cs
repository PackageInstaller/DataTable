using System;
using System.Collections.Generic;
using Pathfinding;
using Pathfinding.Util;
using UnityEngine;

namespace P08.SimBusiness.Pathfinding;

[Serializable]
[AddComponentMenu("P08_Pathfinding/Modifiers/Simple Funnel")]
[RequireComponent(typeof(PathfindingSeeker))]
public class FunnelModifier : MonoModifier
{
	public bool unwrap = true;

	public bool splitAtEveryPortal;

	public override int Order => 10;

	public override void Apply(Path p)
	{
		if (p.path == null || p.path.Count == 0 || p.vectorPath == null || p.vectorPath.Count == 0)
		{
			return;
		}
		List<Int3> list = ListPool<Int3>.Claim();
		List<Funnel.PathPart> list2 = Funnel.SplitIntoParts(p);
		if (list2.Count == 0)
		{
			return;
		}
		for (int i = 0; i < list2.Count; i++)
		{
			Funnel.PathPart part = list2[i];
			if (!part.isLink)
			{
				List<Int3> list3 = Funnel.Calculate(Funnel.ConstructFunnelPortals(p.path, part), unwrap, splitAtEveryPortal);
				list.AddRange(list3);
				ListPool<Int3>.Release(list3);
				continue;
			}
			if (i == 0 || list2[i - 1].isLink)
			{
				list.Add(part.startPoint);
			}
			if (i == list2.Count - 1 || list2[i + 1].isLink)
			{
				list.Add(part.endPoint);
			}
		}
		ListPool<Funnel.PathPart>.Release(list2);
		ListPool<Int3>.Release(p.int3Path);
		p.int3Path = list;
		for (int j = 0; j < p.int3Path.Count - 1; j++)
		{
			Debug.DrawLine((Vector3)p.int3Path[j], (Vector3)p.int3Path[j + 1], Color.yellow, 5f);
		}
	}
}
