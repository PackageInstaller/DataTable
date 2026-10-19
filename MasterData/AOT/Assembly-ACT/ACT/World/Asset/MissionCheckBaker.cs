using UnityEngine;

namespace ACT.World.Asset;

[AddComponentMenu("ACT/ServiceScript/Verification/MissionCheck")]
public class MissionCheckBaker : InteractVerificationBaker
{
	[SerializeField]
	public DataBaker<MissionCheck> dataBaker = new DataBaker<MissionCheck>();

	public override IDataBaker Baker => dataBaker;
}
