using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace Ase;

[TrackColor(1f, 1f, 1f)]
[TrackBindingType(typeof(Animator))]
[TrackClipType(typeof(AnimationSwitchClip))]
public class AnimationSwitchTrack : TrackAsset
{
	public override Playable CreateTrackMixer(PlayableGraph graph, GameObject go, int inputCount)
	{
		return ScriptPlayable<AnimationTrackMixer>.Create(graph, inputCount);
	}
}
