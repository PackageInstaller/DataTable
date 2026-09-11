using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[DisplayName("后宅-角色激活")]
public class StoryTimelineDormCharacterActiveNode : PlayableAsset
{
	[Tooltip("角色编号, 不是角色id, 从0开始")]
	public int actorIndex;

	public bool active;

	public ExposedReference<Transform> parent;

	public bool isLocal;

	public Vector3 position;

	public Vector3 rotation;

	[Tooltip("如果勾选激活, 退出时, 则禁用, 反之则否")]
	public bool invert;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelineDormCharacterActiveNodeBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineDormCharacterActiveNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().actorIndex = actorIndex;
		scriptPlayable.GetBehaviour().active = active;
		scriptPlayable.GetBehaviour().position = position;
		scriptPlayable.GetBehaviour().rotation = rotation;
		scriptPlayable.GetBehaviour().invert = invert;
		scriptPlayable.GetBehaviour().parent = parent;
		scriptPlayable.GetBehaviour().isLocal = isLocal;
		return scriptPlayable;
	}
}
