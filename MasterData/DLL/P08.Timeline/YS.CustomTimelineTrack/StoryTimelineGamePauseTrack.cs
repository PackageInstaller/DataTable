using System;
using System.ComponentModel;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/控制/StoryTimelineGamePause")]
[TrackClipType(typeof(StoryTimelineGamePauseNode))]
[TrackClipType(typeof(StoryTimelineSetPlayerRelaxTimerActiveNode))]
[TrackClipType(typeof(StoryTimelineHideAgentsNode))]
[TrackClipType(typeof(StoryTimelineHideCampAgentsNode))]
public class StoryTimelineGamePauseTrack : TrackAsset
{
}
