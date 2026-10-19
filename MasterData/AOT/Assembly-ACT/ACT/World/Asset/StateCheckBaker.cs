using UnityEngine;

namespace ACT.World.Asset;

[AddComponentMenu("ACT/ServiceScript/Verification/StateCheck")]
public class StateCheckBaker : InteractVerificationBaker
{
	[SerializeField]
	public DataBaker<StateCheck> dataBaker = new DataBaker<StateCheck>();

	public override IDataBaker Baker => dataBaker;
}
