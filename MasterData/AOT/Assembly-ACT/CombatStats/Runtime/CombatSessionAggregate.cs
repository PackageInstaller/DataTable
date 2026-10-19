using System;
using System.Collections.Generic;
using System.Linq;

namespace CombatStats.Runtime;

public sealed class CombatSessionAggregate
{
	private readonly List<CombatSegmentAggregate> segments = new List<CombatSegmentAggregate>();

	private readonly Func<float> nowProvider;

	public IReadOnlyList<CombatSegmentAggregate> Segments => segments;

	public CombatSegmentAggregate ActiveSegment { get; private set; }

	public CombatSessionAggregate(Func<float> nowProvider)
	{
		this.nowProvider = nowProvider ?? throw new ArgumentNullException("nowProvider");
	}

	public void Reset()
	{
		if (ActiveSegment != null)
		{
			EndActiveSegment(SegmentEndReason.Manual, nowProvider());
		}
		segments.Clear();
	}

	public CombatSegmentAggregate StartSegment(SegmentStartReason reason, float startTime)
	{
		if (ActiveSegment != null)
		{
			if (ActiveSegment.TotalDamage == 0L)
			{
				segments.Remove(ActiveSegment);
			}
			EndActiveSegment(SegmentEndReason.ReplacedByNewSegment, startTime);
		}
		CombatSegmentDescriptor descriptor = new CombatSegmentDescriptor
		{
			SegmentId = $"segment_{segments.Count + 1}",
			DisplayName = $"Fight {segments.Count + 1}",
			StartReason = reason,
			StartTime = startTime,
			IsActive = true
		};
		ActiveSegment = new CombatSegmentAggregate(descriptor, nowProvider);
		segments.Add(ActiveSegment);
		return ActiveSegment;
	}

	public void EndActiveSegment(SegmentEndReason reason, float endTime)
	{
		if (ActiveSegment != null)
		{
			ActiveSegment.FinalizeFieldTime(endTime);
			ActiveSegment.Descriptor.EndTime = endTime;
			ActiveSegment.Descriptor.IsActive = false;
			ActiveSegment = null;
		}
	}

	public CombatSegmentAggregate FindSegment(string segmentId)
	{
		return segments.FirstOrDefault((CombatSegmentAggregate segment) => string.Equals(segment.Descriptor.SegmentId, segmentId, StringComparison.Ordinal));
	}
}
