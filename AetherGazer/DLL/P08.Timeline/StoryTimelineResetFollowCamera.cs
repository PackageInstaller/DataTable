using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[DisplayName("重置跟随相机朝向")]
public class StoryTimelineResetFollowCamera : PlayableAsset
{
	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelineResetFollowCameraBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineResetFollowCameraBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour();
		return scriptPlayable;
	}
}
