using System;

namespace ACT.Config;

[Serializable]
public class JumpAbyss
{
	public readonly int id;

	public readonly int nextJumpFloor;

	public JumpAbyss(int id, int nextJumpFloor)
	{
		this.id = id;
		this.nextJumpFloor = nextJumpFloor;
	}
}
