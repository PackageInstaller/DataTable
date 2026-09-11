using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[DisplayName("后宅-UI遮罩")]
public class StoryTimelineDormMaskUINode : PlayableAsset
{
	public string ui_path = "UI/Dorm/StoryMaskUI";

	public Gradient color_grad;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelineDormMaskUINodeBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineDormMaskUINodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().ui_path = ui_path;
		scriptPlayable.GetBehaviour().color_grad = color_grad;
		return scriptPlayable;
	}
}
