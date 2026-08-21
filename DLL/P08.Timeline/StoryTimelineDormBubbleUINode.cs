using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[DisplayName("后宅-气泡文本")]
public class StoryTimelineDormBubbleUINode : PlayableAsset
{
	public int content = 3;

	public string attachPath = "";

	public bool needClick;

	public bool canSkip;

	public int skipFrame;

	public string path = "UI/Dorm/SubtitleBubble";

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelineDormBubbleUINodeBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineDormBubbleUINodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().content = content;
		scriptPlayable.GetBehaviour().attachPath = attachPath;
		scriptPlayable.GetBehaviour().needClick = needClick;
		scriptPlayable.GetBehaviour().canSkip = canSkip;
		scriptPlayable.GetBehaviour().skipFrame = skipFrame;
		scriptPlayable.GetBehaviour().path = path;
		return scriptPlayable;
	}
}
