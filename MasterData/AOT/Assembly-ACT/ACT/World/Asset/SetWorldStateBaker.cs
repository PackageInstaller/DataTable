using UnityEngine;

namespace ACT.World.Asset;

[AddComponentMenu("ACT/ServiceScript/Action/SetWorldState")]
public class SetWorldStateBaker : ServiceActionBaker
{
	[SerializeField]
	public DataBaker<SetWorldState> dataBaker = new DataBaker<SetWorldState>();

	public override IDataBaker Baker => dataBaker;
}
