using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle;

public static class DefenseStateSnapshotBuilder
{
	private static readonly List<IDefenseStateSource> s_Sources = new List<IDefenseStateSource>
	{
		new MotionDefenseStateSource(),
		new EntityTagDefenseStateSource(),
		new PropertyDefenseStateSource(),
		new AbilityDefenseStateSource()
	};

	public static DefenseStateSnapshot Build(Entity target)
	{
		DefenseStateSnapshot snapshot = default;
		foreach (IDefenseStateSource s_Source in s_Sources)
		{
			s_Source.Collect(target, ref snapshot);
		}
		return snapshot;
	}
}
