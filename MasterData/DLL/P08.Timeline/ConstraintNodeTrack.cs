using System;
using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

[Serializable]
[DisplayName("UI.Timeline/节点约束轨道(ConstraintNodeTrack)")]
[TrackClipType(typeof(ParentConstrainNode))]
[TrackBindingType(typeof(HeroUITimelineBrain))]
public class ConstraintNodeTrack : TrackAsset
{
	public string parentPath;

	public string constraintPoint;

	public bool isUsePath;

	protected override Playable CreatePlayable(PlayableGraph graph, GameObject gameObject, TimelineClip clip)
	{
		if (clip.asset is ParentConstrainNode parentConstrainNode)
		{
			PlayableDirector playableDirector = graph.GetResolver() as PlayableDirector;
			HeroUITimelineBrain heroUITimelineBrain = playableDirector.GetGenericBinding(this) as HeroUITimelineBrain;
			if (heroUITimelineBrain == null)
			{
				return Playable.Null;
			}
			GameObject gameObject2 = heroUITimelineBrain.FindTarget(parentPath, playableDirector.transform);
			if (gameObject2 == null)
			{
				gameObject2 = heroUITimelineBrain.gameObject;
			}
			if (isUsePath)
			{
				parentConstrainNode.parent = gameObject2;
			}
			else
			{
				ConstraintPointGroup componentInChildren = gameObject2.GetComponentInChildren<ConstraintPointGroup>();
				if (componentInChildren == null)
				{
					Debug.LogError($"ParentConstrainBehaviour 无法从 {gameObject2.gameObject} 上找到 ConstraintPointGroup");
					return Playable.Null;
				}
				Transform constraintTransform = componentInChildren.GetConstraintTransform(constraintPoint);
				if (constraintTransform == null)
				{
					Debug.LogError($"ParentConstrainBehaviour 无法从 {gameObject2.gameObject} 上找到约束点 {constraintPoint}");
					return Playable.Null;
				}
				parentConstrainNode.parent = constraintTransform.gameObject;
			}
		}
		return base.CreatePlayable(graph, gameObject, clip);
	}
}
