using UnityEngine;

namespace ACT.Battle.Configs;

[SerializeField]
public struct FlyEnemyUpdatePos
{
	public float shortRadius;

	public float longRadius;

	public Vector2 holdAngle;

	public Vector2 updateAngle;
}
