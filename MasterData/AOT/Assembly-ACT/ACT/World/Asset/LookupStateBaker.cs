using UnityEngine;

namespace ACT.World.Asset;

[AddComponentMenu("ACT/ServiceScript/Action/LookupState")]
public class LookupStateBaker : ServiceActionBaker
{
	[SerializeField]
	public DataBaker<LookupStateData> dataBaker = new DataBaker<LookupStateData>();

	public override IDataBaker Baker => dataBaker;
}
