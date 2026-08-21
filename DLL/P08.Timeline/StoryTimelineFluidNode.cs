using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[DisplayName("扰动效果(Fluid)")]
public class StoryTimelineFluidNode : PlayableAsset
{
	public FluidNodeType fluidType;

	public string sceneFluidPath;

	public string sourceName;

	public string attachPoint;

	public Vector3 localOffset;

	public Color color;

	public bool localPlayer;

	public float radius;

	public float size;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<StoryTimelineFluidNodeBehaviour> scriptPlayable = ScriptPlayable<StoryTimelineFluidNodeBehaviour>.Create(graph);
		StoryTimelineFluidNodeBehaviour behaviour = scriptPlayable.GetBehaviour();
		behaviour.fluidType = fluidType;
		behaviour.sceneFluidPath = sceneFluidPath;
		behaviour.sourceName = sourceName;
		behaviour.localOffset = localOffset;
		behaviour.color = color;
		behaviour.localPlayer = localPlayer;
		behaviour.radius = radius;
		behaviour.size = size;
		return scriptPlayable;
	}
}
