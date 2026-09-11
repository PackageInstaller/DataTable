using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineUINode : PlayableAsset
{
	public UINodeType type;

	public AnimationCurve maskCurve;

	public int mainTitle = 1;

	public int subTitle = 2;

	public int context = 3;

	public AnimationCurve contextCurve;

	public int fontSize = 42;

	public TextAnchor alignment;

	public bool canSkip = true;

	public bool disableUIWhenFinished;

	public bool destroyUI;

	[HideInInspector]
	public string path = "UI/StoryText";

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelineUINodeBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineUINodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().type = type;
		scriptPlayable.GetBehaviour().mainTitle = mainTitle;
		scriptPlayable.GetBehaviour().subTitle = subTitle;
		scriptPlayable.GetBehaviour().context = context;
		scriptPlayable.GetBehaviour().fontSize = fontSize;
		scriptPlayable.GetBehaviour().alignment = alignment;
		scriptPlayable.GetBehaviour().canSkip = canSkip;
		scriptPlayable.GetBehaviour().disableUIWhenFinished = disableUIWhenFinished;
		scriptPlayable.GetBehaviour().destroyUI = destroyUI;
		scriptPlayable.GetBehaviour().path = path;
		scriptPlayable.GetBehaviour().contextCurve = contextCurve;
		scriptPlayable.GetBehaviour().maskCurve = maskCurve;
		return scriptPlayable;
	}
}
