using UnityEngine;
using UnityEngine.Playables;

public class SceneGraynessNode : PlayableAsset
{
	public AnimationCurve GraynessCurve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 1f), new Keyframe(1f, 0f));

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<SceneGraynessNodePlayable> scriptPlayable = ScriptPlayable<SceneGraynessNodePlayable>.Create(graph);
		scriptPlayable.GetBehaviour().GraynessCurve = GraynessCurve;
		return scriptPlayable;
	}
}
