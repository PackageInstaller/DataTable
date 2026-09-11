using UnityEngine;
using UnityEngine.Playables;

public class SceneProbeLightingNode : PlayableAsset
{
	public Gradient ProbeLightingBase;

	public AnimationCurve ProbeLightingScale;

	public bool ResetValueAfterEnd = true;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<SceneProbeLightingNodePlayable> scriptPlayable = ScriptPlayable<SceneProbeLightingNodePlayable>.Create(graph);
		scriptPlayable.GetBehaviour().ProbeLightingBase = ProbeLightingBase;
		scriptPlayable.GetBehaviour().ProbeLightingScale = ProbeLightingScale;
		scriptPlayable.GetBehaviour().ResetValueAfterEnd = ResetValueAfterEnd;
		return scriptPlayable;
	}
}
