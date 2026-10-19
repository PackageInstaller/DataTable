using System;

namespace Unity.Jobs.LowLevel.Unsafe;

public enum ScheduleMode
{
	Run = 0,
	[Obsolete("Batched is obsolete, use Parallel or Single depending on job type. (UnityUpgradable) -> Parallel", false)]
	Batched = 1,
	Parallel = Batched,
	Single = 2
}
