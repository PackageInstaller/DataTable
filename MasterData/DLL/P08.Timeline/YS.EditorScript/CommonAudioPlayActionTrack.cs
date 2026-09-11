using System.ComponentModel;
using UnityEngine.Timeline;

namespace YS.EditorScript;

[DisplayName("玩法Timeline/音效(AudioPlay)")]
[TrackClipType(typeof(CommonAudioPlayActionNode))]
[TrackMediaType(TimelineAsset.MediaType.Script)]
public class CommonAudioPlayActionTrack : PlayableTrack
{
}
