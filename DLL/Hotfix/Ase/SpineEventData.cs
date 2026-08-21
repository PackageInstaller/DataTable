using Spine;
using UnityEngine;

namespace Ase;

public readonly struct SpineEventData(Event spineEvent, TrackEntry trackEntry)
{
	public readonly string EventName = spineEvent?.Data?.Name ?? string.Empty;

	public readonly string StringValue = spineEvent?.String ?? string.Empty;

	public readonly int IntValue = spineEvent?.Int ?? 0;

	public readonly float FloatValue = spineEvent?.Float ?? 0f;

	public readonly float EventTime = spineEvent?.Time ?? 0f;

	public readonly int TrackIndex = trackEntry?.TrackIndex ?? (-1);

	public bool HasIntArg => IntValue != 0;

	public bool HasStringArg => !string.IsNullOrEmpty(StringValue);

	public bool HasFloatArg => Mathf.Abs(FloatValue) > 0.0001f;
}
