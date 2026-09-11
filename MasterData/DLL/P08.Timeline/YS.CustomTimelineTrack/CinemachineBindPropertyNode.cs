using UnityEngine;
using UnityEngine.Playables;

namespace YS.CustomTimelineTrack;

public class CinemachineBindPropertyNode : PlayableAsset
{
	public PROPERTY_TYPE propertyType;

	public string gameObjectName = "";

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<CinemachineBindPropertyNodeBehaviour> scriptPlayable = ScriptPlayable<CinemachineBindPropertyNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().propertyType = propertyType;
		scriptPlayable.GetBehaviour().gameObjectName = gameObjectName;
		return scriptPlayable;
	}
}
