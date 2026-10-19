using UnityEngine;

namespace ACT.World.Asset;

[AddComponentMenu("ACT/ServiceScript/Action/SetState")]
public class SetStateBaker : ServiceActionBaker
{
	[SerializeField]
	public DataBaker<SetStateData> dataBaker = new DataBaker<SetStateData>();

	public override IDataBaker Baker => dataBaker;
}
