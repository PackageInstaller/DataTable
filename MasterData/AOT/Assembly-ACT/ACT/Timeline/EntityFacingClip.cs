using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class EntityFacingClip : PlayableAsset
{
	public EntityFacingBehaviour template = new EntityFacingBehaviour();

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		return ScriptPlayable<EntityFacingBehaviour>.Create(graph, template);
	}
}
