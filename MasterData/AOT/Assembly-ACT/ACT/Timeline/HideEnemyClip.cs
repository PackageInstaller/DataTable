using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class HideEnemyClip : PlayableAsset
{
	public HideEnemyBehaviour hideEnemyBehaviour = new HideEnemyBehaviour();

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		return ScriptPlayable<HideEnemyBehaviour>.Create(graph, hideEnemyBehaviour);
	}
}
