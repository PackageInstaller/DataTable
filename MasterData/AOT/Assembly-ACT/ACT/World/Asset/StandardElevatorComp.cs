using UnityEngine;

namespace ACT.World.Asset;

[AddComponentMenu("ACT/WorldAssetComp/StandardElevatorComp")]
public class StandardElevatorComp : StateWorldAssetComp<StandardElevatorData>
{
	public const string ELEVATOR_REF_NAME = "Elevator";

	public const string ELEVATOR_LAYER = "ElevatorLayer";

	public const string ELEVATOR_LAYER_SWUID = "ElevatorLayerSwuid";
}
