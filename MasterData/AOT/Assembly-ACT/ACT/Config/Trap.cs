using System;

namespace ACT.Config;

[Serializable]
public class Trap
{
	public readonly int id;

	public readonly int trapType;

	public readonly int worldlevel;

	public readonly int damage;

	public Trap(int id, int trapType, int worldlevel, int damage)
	{
		this.id = id;
		this.trapType = trapType;
		this.worldlevel = worldlevel;
		this.damage = damage;
	}
}
