using UnityEngine;
using UnityEngine.Playables;

public class StoryDarkCornerNode : PlayableAsset
{
	public Color color = Color.black;

	public AnimationCurve strengthCurve = new AnimationCurve(new Keyframe(0f, 0f), new Keyframe(1f, 0f));

	public AnimationCurve softCurve = new AnimationCurve(new Keyframe(0f, 0.2f), new Keyframe(1f, 0.2f));

	public bool bounded;

	public bool isUseScreenPos;

	public Transform trans;

	public Vector2 screenPos = Vector2.one * 0.5f;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryDarkCornerNodeBehaviour> scriptPlayable = ScriptPlayable<StoryDarkCornerNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().color = color;
		scriptPlayable.GetBehaviour().strengthCurve = strengthCurve;
		scriptPlayable.GetBehaviour().softCurve = softCurve;
		scriptPlayable.GetBehaviour().bounded = bounded;
		scriptPlayable.GetBehaviour().isUseScreenPos = isUseScreenPos;
		scriptPlayable.GetBehaviour().trans = trans;
		scriptPlayable.GetBehaviour().screenPos = screenPos;
		return scriptPlayable;
	}
}
