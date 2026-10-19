using UnityEngine;

namespace ACT.World.Asset;

[AddComponentMenu("ACT/ServiceScript/Action/PassSubMission")]
public class PassSubMissionBaker : ServiceActionBaker
{
	[SerializeField]
	public DataBaker<PassSubMission> dataBaker = new DataBaker<PassSubMission>();

	public override IDataBaker Baker => dataBaker;
}
