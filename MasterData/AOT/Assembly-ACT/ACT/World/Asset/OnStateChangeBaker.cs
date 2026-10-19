using UnityEngine;

namespace ACT.World.Asset;

[AddComponentMenu("ACT/ServiceScript/Event/OnStateChange")]
public class OnStateChangeBaker : InteractEventBaker
{
	[SerializeField]
	public DataBaker<OnStateChange> dataBaker = new DataBaker<OnStateChange>();

	public override IDataBaker Baker => dataBaker;
}
