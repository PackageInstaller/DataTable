using UnityEngine;

namespace ACT.World.Asset;

[AddComponentMenu("ACT/ServiceScript/Event/OnCustomInteract")]
public class OnCustomInteractBaker : InteractEventBaker
{
	[SerializeField]
	public DataBaker<OnCustomInteract> dataBaker = new DataBaker<OnCustomInteract>();

	public override IDataBaker Baker => dataBaker;
}
