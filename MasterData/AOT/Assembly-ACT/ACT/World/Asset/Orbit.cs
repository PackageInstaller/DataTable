using System;

namespace ACT.World.Asset;

[Serializable]
public class Orbit : IDataToBake
{
	public Pos start;

	public Pos end;

	public bool isJumpDown;
}
