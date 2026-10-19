using UnityEngine;

namespace ACT.Battle.Configs;

public class FollowConfigCompositeMove : ConfigCompositeMove
{
	public bool followPosition = true;

	public ConfigFunction<Vector3> position;

	public bool followRotation = true;

	public ConfigFunction<Quaternion> rotation;

	public override CompositeMoveBase CreateInstance()
	{
		return new FollowCompositeMove(this);
	}
}
