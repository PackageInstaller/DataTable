using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace Packages.P08Main.Scripts.T0World.Timeline;

public class DirectControlAnimatorControllerNode : PlayableAsset, ITimelineClipAsset
{
	public DirectControlAnimatorControllerBehaviour template;

	public ClipCaps clipCaps => ClipCaps.ClipIn;

	public override double duration { get; }

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<DirectControlAnimatorControllerBehaviour> scriptPlayable = ScriptPlayable<DirectControlAnimatorControllerBehaviour>.Create(graph, template);
		scriptPlayable.GetBehaviour();
		return scriptPlayable;
	}
}
