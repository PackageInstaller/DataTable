using System;

namespace CombatStats.Runtime;

[Serializable]
public sealed class SegmentListItemSnapshot
{
	public int SegmentId;

	public string SegmentType;

	public float Duration;

	public long TotalDamage;

	public bool IsSelected;
}
