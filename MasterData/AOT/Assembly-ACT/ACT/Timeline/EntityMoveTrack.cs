using UnityEngine;
using UnityEngine.Timeline;

namespace ACT.Timeline;

[TrackColor(0.15f, 0.45f, 0.95f)]
[TrackClipType(typeof(EntityMoveClip))]
[TrackBindingType(typeof(GameObject))]
public class EntityMoveTrack : TrackAsset
{
}
