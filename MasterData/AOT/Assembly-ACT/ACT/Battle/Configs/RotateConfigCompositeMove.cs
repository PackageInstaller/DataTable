using UnityEngine;

namespace ACT.Battle.Configs;

public class RotateConfigCompositeMove : ConfigCompositeMove
{
	public float angleDegreeSpeed;

	public Vector3 axis;

	public bool reverse;

	public bool hasRange;

	public Vector2 angleRange;

	public override CompositeMoveBase CreateInstance()
	{
		return new RotateCompositeMove(this);
	}
}
