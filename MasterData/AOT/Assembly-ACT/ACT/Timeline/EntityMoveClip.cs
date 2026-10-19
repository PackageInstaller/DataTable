using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class EntityMoveClip : PlayableAsset
{
	public EntityMoveBehaviour template = new EntityMoveBehaviour();

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		return ScriptPlayable<EntityMoveBehaviour>.Create(graph, template);
	}
}
