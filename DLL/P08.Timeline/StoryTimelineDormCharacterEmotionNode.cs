using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[DisplayName("后宅-角色表情")]
public class StoryTimelineDormCharacterEmotionNode : PlayableAsset
{
	[Tooltip("角色编号, 不是角色id, 从0开始")]
	public int actorIndex;

	public bool isSpecial;

	public string efxFacePath = "Effect/Dorm/anger03";

	public bool isRevert;

	public int sheetFaceId;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelineDormCharacterEmotionNodeBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineDormCharacterEmotionNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().actorIndex = actorIndex;
		scriptPlayable.GetBehaviour().isSpecial = isSpecial;
		scriptPlayable.GetBehaviour().efxFacePath = efxFacePath;
		scriptPlayable.GetBehaviour().sheetFaceId = sheetFaceId;
		scriptPlayable.GetBehaviour().isRevert = isRevert;
		return scriptPlayable;
	}
}
