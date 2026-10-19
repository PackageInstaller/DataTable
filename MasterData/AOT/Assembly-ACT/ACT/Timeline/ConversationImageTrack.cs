using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

[TrackColor(0f, 1f, 0f)]
[TrackClipType(typeof(ConversationImageClip))]
public class ConversationImageTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		return ScriptPlayable<ConversationImageMixerBehaviour>.Create(graph, inputCount);
	}
}
