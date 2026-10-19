using System;

namespace ACT.World.Asset;

[Serializable]
public struct LaserRecallPoint : IDataToBake
{
	public BoxColliderParameters collider;

	public Pos pos;
}
