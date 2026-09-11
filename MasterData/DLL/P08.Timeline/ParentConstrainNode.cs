using System;
using UnityEngine;
using UnityEngine.Playables;

[Serializable]
public class ParentConstrainNode : PlayableAsset
{
	[SerializeField]
	public ExposedReference<GameObject> childGameObject;

	[HideInInspector]
	public GameObject parent;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<ParentConstrainBehaviour> scriptPlayable = ScriptPlayable<ParentConstrainBehaviour>.Create(graph);
		ParentConstrainBehaviour behaviour = scriptPlayable.GetBehaviour();
		behaviour.child = childGameObject.Resolve(graph.GetResolver());
		behaviour.parent = parent;
		return scriptPlayable;
	}
}
