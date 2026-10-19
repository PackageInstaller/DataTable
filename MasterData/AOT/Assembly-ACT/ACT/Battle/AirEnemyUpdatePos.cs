using System;

namespace ACT.Battle;

[Serializable]
public class AirEnemyUpdatePos
{
	public float bufferRange = 5f;

	public float followInsideRadius = 1.5f;

	public float followOutsideRadius = 4.5f;

	public float minAngle = 15f;

	public float maxAngle = 45f;

	public bool mirrorAngle = true;

	public AirEnemyUpdatePos(AirEnemyUpdatePos key)
	{
		bufferRange = key.bufferRange;
		followInsideRadius = key.followInsideRadius;
		followOutsideRadius = key.followOutsideRadius;
		minAngle = key.minAngle;
		maxAngle = key.maxAngle;
		mirrorAngle = key.mirrorAngle;
	}

	public AirEnemyUpdatePos()
	{
	}
}
