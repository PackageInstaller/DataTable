using UnityEngine;
using UnityEngine.Timeline;

namespace ACT.Timeline;

[TrackColor(0.95f, 0.75f, 0.2f)]
[TrackClipType(typeof(EntityFacingClip))]
[TrackBindingType(typeof(GameObject))]
public class EntityFacingTrack : TrackAsset
{
}
