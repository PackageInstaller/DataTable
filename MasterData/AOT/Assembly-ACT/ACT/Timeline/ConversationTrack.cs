using ACT.Drama;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

[TrackColor(0f, 1f, 0f)]
[TrackBindingType(typeof(ConversationController))]
[TrackClipType(typeof(ConversationClip))]
public class ConversationTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		foreach (TimelineClip clip in GetClips())
		{
			(clip.asset as ConversationClip).clipPassthrough = clip;
		}
		return ScriptPlayable<ConversationMixerBehaviour>.Create(graph, inputCount);
	}
}
