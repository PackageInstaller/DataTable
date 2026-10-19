using UnityEngine;

namespace ACT.World.Asset;

[AddComponentMenu("ACT/ServiceScript/Action/FinishMission")]
public class FinishMissionBaker : ServiceActionBaker
{
	[SerializeField]
	public DataBaker<FinishMission> dataBaker = new DataBaker<FinishMission>();

	public override IDataBaker Baker => dataBaker;
}
