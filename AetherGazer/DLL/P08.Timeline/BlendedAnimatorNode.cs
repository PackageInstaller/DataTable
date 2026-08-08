using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;

public class BlendedAnimatorNode : PlayableAsset
{
	[HideInInspector]
	public List<string> stateNames = new List<string>();

	[HideInInspector]
	public float len;

	[HideInInspector]
	public int currentStateIndex;

	[HideInInspector]
	public string currentStateName;

	public float blendInSeconds = 0.4f;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<BlendedAnimatorNodeBehaviour> scriptPlayable = ScriptPlayable<BlendedAnimatorNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().blendInSeconds = blendInSeconds;
		scriptPlayable.GetBehaviour().currentStateIndex = currentStateIndex;
		scriptPlayable.GetBehaviour().currentStateName = currentStateName;
		return scriptPlayable;
	}
}
