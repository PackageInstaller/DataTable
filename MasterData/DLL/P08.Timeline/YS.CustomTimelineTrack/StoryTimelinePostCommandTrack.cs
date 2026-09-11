using System;
using System.ComponentModel;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/控制/推送剧情事件(StoryTimelinePostCommand)")]
[TrackClipType(typeof(StoryTimelinePostCommandNode))]
public class StoryTimelinePostCommandTrack : TrackAsset
{
}
