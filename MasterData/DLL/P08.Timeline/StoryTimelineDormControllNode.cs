using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[DisplayName("后宅-控制")]
public class StoryTimelineDormControllNode : PlayableAsset
{
	public enum EBeginStoryFlag
	{
		None,
		HideChar,
		HideFurniture,
		HideBoth
	}

	public bool isBeginStory;

	public EBeginStoryFlag flag;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelineDormControllNodeBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineDormControllNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().isBeginStory = isBeginStory;
		scriptPlayable.GetBehaviour().flag = (int)flag;
		return scriptPlayable;
	}
}
