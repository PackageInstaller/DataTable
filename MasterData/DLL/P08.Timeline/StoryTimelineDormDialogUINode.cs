using System.Collections.Generic;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[DisplayName("后宅-对话框")]
public class StoryTimelineDormDialogUINode : PlayableAsset
{
	public string ui_path = "UI/Dorm/StoryDialogUI";

	public bool hideIcon;

	public string icon_path = "TextureConfig/Story/Character/story_1038";

	[Tooltip("对应 activity_story_dorm_talk.csv 的ID")]
	public string talkId = "1001";

	public bool needClick;

	public bool showChoice;

	public List<string> choices = new List<string>();

	public bool effect;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelineDormDialogUINodeBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineDormDialogUINodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().ui_path = ui_path;
		scriptPlayable.GetBehaviour().hideIcon = hideIcon;
		scriptPlayable.GetBehaviour().icon_path = icon_path;
		scriptPlayable.GetBehaviour().talkId = talkId;
		scriptPlayable.GetBehaviour().needClick = needClick;
		scriptPlayable.GetBehaviour().showChoice = showChoice;
		scriptPlayable.GetBehaviour().choices = choices;
		scriptPlayable.GetBehaviour().effect = effect;
		return scriptPlayable;
	}
}
