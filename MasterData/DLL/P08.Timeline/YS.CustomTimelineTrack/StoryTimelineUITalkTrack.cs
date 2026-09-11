using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace YS.CustomTimelineTrack;

[Serializable]
[DisplayName("剧情Timeline/文本/对话框(StoryTimelineUITalk)")]
[TrackClipType(typeof(StoryTimelineUITalkNode))]
public class StoryTimelineUITalkTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		return ScriptPlayable<StoryTimelineUITalkTrackBehaviour>.Create(graph, inputCount);
	}
}
