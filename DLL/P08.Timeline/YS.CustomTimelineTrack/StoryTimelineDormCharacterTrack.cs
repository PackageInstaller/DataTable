using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[DisplayName("剧情Timeline/后宅/角色 轨道")]
[TrackColor(0.047f, 0.96f, 0.667f)]
[TrackClipType(typeof(StoryTimelineDormCharacterActiveNode))]
[TrackClipType(typeof(StoryTimelineDormCharacterActionNode))]
[TrackClipType(typeof(StoryTimelineDormCharacterEmotionNode))]
public class StoryTimelineDormCharacterTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		return ScriptPlayable<StoryTimelineDormCharacterTrackBehaviour>.Create(graph, inputCount);
	}
}
