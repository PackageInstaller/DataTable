using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行控制GhostShadow", "Action", new string[] { "control", "ghost", "shadow", "state", "status", "tag" })]
public class ActionControlGhostShadow : ConfigAction
{
	public GhostShadowDurationType type;

	public bool enable;

	public float interval;

	public float ghostShadowDuration;

	public float fadeThres;

	public int presetIndex;

	public bool useExtraMaterial;

	public Material extraMaterial;

	protected override AbilityAuth defaultAuth => AbilityAuth.Client;

	public override void Do(ActionMemory memory)
	{
	}
}
