using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace Ase;

public class AnimationSwitchClip : PlayableAsset, ITimelineClipAsset
{
	private AnimationSwitchBehaviour tempData = new AnimationSwitchBehaviour();

	public string animationName;

	public ClipCaps clipCaps => (ClipCaps)0;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject go)
	{
		ScriptPlayable<AnimationSwitchBehaviour> scriptPlayable = ScriptPlayable<AnimationSwitchBehaviour>.Create(graph, tempData);
		scriptPlayable.GetBehaviour().animationName = animationName;
		return scriptPlayable;
	}
}
