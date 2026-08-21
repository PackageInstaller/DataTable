using UnityEngine;

public class ComponentSubRenderer : ComponentRenderer
{
	public Material defaultMaterial;

	public Material fadeoutMaterial;

	public Transform probeAnchor;

	protected override Material DefaultMaterial => defaultMaterial;

	protected override Material FadeoutMaterial => fadeoutMaterial;

	public override void ActiveBehavior()
	{
		base.ActiveBehavior();
		base.Renderer = GetComponentInChildren<SkinnedMeshRenderer>();
		base.Owner = GetComponentInParent<AgentHuman>();
	}

	public override void DefaultStatus(bool isSemivisible)
	{
		base.DefaultStatus(isSemivisible);
		base.Renderer.probeAnchor = probeAnchor;
	}

	public override bool Highlight(bool on)
	{
		return false;
	}
}
