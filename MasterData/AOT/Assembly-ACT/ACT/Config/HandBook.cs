using System;

namespace ACT.Config;

[Serializable]
public class HandBook
{
	public readonly int id;

	public readonly int name;

	public readonly int system;

	public readonly int[] raidTypeID = new int[0];

	public readonly int banner;

	public HandBook(int id, int name, int system, int[] raidTypeID, int banner)
	{
		this.id = id;
		this.name = name;
		this.system = system;
		this.raidTypeID = raidTypeID;
		this.banner = banner;
	}
}
