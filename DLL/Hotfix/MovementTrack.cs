using System;

[Serializable]
[TrackName(Name = "运动")]
[TrackColor(0f, 1f, 0.9411765f)]
[TrackBindClip(Types = new Type[]
{
	typeof(LineMoveClip),
	typeof(OpenMovementClip)
})]
public class MovementTrack : StandardTrack
{
}
