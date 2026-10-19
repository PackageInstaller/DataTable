using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class AnimatorParamClip : PlayableAsset
{
	public List<TimelineAnimatorPara> configs;

	public AnimatorParamBehaviour template = new AnimatorParamBehaviour();

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<AnimatorParamBehaviour> scriptPlayable = ScriptPlayable<AnimatorParamBehaviour>.Create(graph, template);
		scriptPlayable.GetBehaviour().configs = configs;
		return scriptPlayable;
	}
}
