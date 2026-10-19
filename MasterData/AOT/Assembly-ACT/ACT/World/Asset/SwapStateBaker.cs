using UnityEngine;

namespace ACT.World.Asset;

[AddComponentMenu("ACT/ServiceScript/Action/SwapState")]
public class SwapStateBaker : ServiceActionBaker
{
	[SerializeField]
	public DataBaker<SwapStateData> dataBaker = new DataBaker<SwapStateData>();

	public override IDataBaker Baker => dataBaker;
}
