using System;

namespace CombatStats.Runtime;

[Serializable]
public sealed class CombatSegmentDescriptor
{
	public string SegmentId;

	public string DisplayName;

	public SegmentStartReason StartReason;

	public float StartTime;

	public float EndTime;

	public bool IsActive;
}
