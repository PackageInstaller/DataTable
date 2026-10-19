using UnityEngine;

namespace ACT.Battle.Configs;

public class PositionAndRotationConfigCompositeMove : ConfigCompositeMove
{
	public ConfigFunction<Vector3> position;

	public ConfigFunction<Quaternion> rotation;

	public override CompositeMoveBase CreateInstance()
	{
		return new PositionAndRotationCompositeMove(this);
	}
}
