using Cinemachine;
using UnityEngine;
using UnityEngine.Playables;

public class StoryTimelineCameraCutTypeNode : PlayableAsset
{
	public CinemachineBlendDefinition cameraBlend;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelineCameraCutTypeNodeBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineCameraCutTypeNodeBehaviour>.Create(graph);
		scriptPlayable.GetBehaviour().cameraBlend = cameraBlend;
		return scriptPlayable;
	}
}
