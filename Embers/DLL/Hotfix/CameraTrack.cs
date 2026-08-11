using System;

[Serializable]
[TrackName(Name = "相机效果")]
[TrackColor(0.16078432f, 0f, 1f)]
[TrackBindClip(Types = new Type[] { typeof(CameraRotateClip) })]
public class CameraTrack : StandardTrack
{
}
