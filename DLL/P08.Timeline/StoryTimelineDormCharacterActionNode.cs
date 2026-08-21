using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[DisplayName("后宅-角色动画")]
public class StoryTimelineDormCharacterActionNode : PlayableAsset
{
	[Tooltip("角色编号, 不是角色id, 从0开始")]
	public int actorIndex;

	public string prefabPath = "StoryTimeline/DormBirthday/CharAction/test_action";

	public bool appleRootMotion;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelineDormCharacterAnimNodeBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineDormCharacterAnimNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().actorIndex = actorIndex;
		scriptPlayable.GetBehaviour().prefabPath = prefabPath;
		scriptPlayable.GetBehaviour().appleRootMotion = appleRootMotion;
		return scriptPlayable;
	}
}
