using UnityEngine;
using UnityEngine.Playables;

public class SceneFogNode : PlayableAsset
{
	public AnimationCurve DynamicFogIntensityCurve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(0.5f, 1f), new Keyframe(1f, 0f));

	public Color color;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<SceneFogNodePlayable> scriptPlayable = ScriptPlayable<SceneFogNodePlayable>.Create(graph);
		scriptPlayable.GetBehaviour().DynamicFogIntensityCurve = DynamicFogIntensityCurve;
		scriptPlayable.GetBehaviour().color = color;
		return scriptPlayable;
	}
}
