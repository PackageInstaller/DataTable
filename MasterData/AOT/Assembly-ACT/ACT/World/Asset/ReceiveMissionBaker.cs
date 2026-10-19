using UnityEngine;

namespace ACT.World.Asset;

[AddComponentMenu("ACT/ServiceScript/Action/ReceiveMission")]
public class ReceiveMissionBaker : ServiceActionBaker
{
	[SerializeField]
	public DataBaker<ReceiveMission> dataBaker = new DataBaker<ReceiveMission>();

	public override IDataBaker Baker => dataBaker;
}
