using System;

[Serializable]
[TrackName(Name = "子弹")]
[TrackColor(0f, 0f, 0f)]
[TrackBindClip(Types = new Type[] { typeof(CreateBulletClip) })]
public class BulletTrack : StandardTrack
{
}
