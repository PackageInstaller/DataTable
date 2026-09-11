using System;

[Serializable]
public class TimelineHiddenPartsClip : IComparable<TimelineHiddenPartsClip>, ITimelineClipBeginNormalized, ITimelineClipLength, ITimelineClipEndNormalized
{
	public float NormalizedBegin;

	public float Length;

	public float NormalizedEnd;

	public bool ShowOnStop;

	public bool IsReverse;

	public bool HideWithShadow;

	public bool OnlyHideShadow;

	public int ControlGroupIndex;

	public int CompareTo(TimelineHiddenPartsClip other)
	{
		return NormalizedBegin.CompareTo(other.NormalizedBegin);
	}

	public float GetBeginNormalized()
	{
		return NormalizedBegin;
	}

	public float GetLength()
	{
		return Length;
	}

	public float GetEndNormalized()
	{
		return NormalizedEnd;
	}
}
