using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

[TrackColor(0f, 1f, 0f)]
[TrackClipType(typeof(AnimatorParamClip))]
[TrackBindingType(typeof(Animator), TrackBindingFlags.None)]
[ExcludeFromPreset]
public class AnimatorParamTrack : TrackAsset, ILayerable
{
	public override void GatherProperties(PlayableDirector director, IPropertyCollector driver)
	{
		base.GatherProperties(director, driver);
	}

	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		return ScriptPlayable<AnimatorParamMixerBehaviour>.Create(graph, inputCount);
	}

	public Playable CreateLayerMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		return Playable.Null;
	}
}
