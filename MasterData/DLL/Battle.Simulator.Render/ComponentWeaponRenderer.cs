using UnityEngine;

public class ComponentWeaponRenderer : ComponentRenderer
{
	public Material defaultMaterial;

	public Material fadeoutMaterial;

	protected override Material DefaultMaterial => defaultMaterial;

	protected override Material FadeoutMaterial => fadeoutMaterial;

	public override void ActiveBehavior()
	{
		base.ActiveBehavior();
		base.Renderer = GetComponentInChildren<MeshRenderer>();
	}

	public override bool Highlight(bool on)
	{
		return true;
	}

	public void SetProbeAnchor(Transform parent)
	{
		base.Renderer.probeAnchor = parent;
	}
}
