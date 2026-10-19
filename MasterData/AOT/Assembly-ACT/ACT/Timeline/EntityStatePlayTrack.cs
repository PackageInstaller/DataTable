using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

[TrackColor(0.85f, 0.3f, 0.15f)]
[TrackClipType(typeof(EntityStatePlayClip))]
[TrackBindingType(typeof(GameObject))]
public class EntityStatePlayTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		return ScriptPlayable<EntityStatePlayMixerBehaviour>.Create(graph, inputCount);
	}
}
