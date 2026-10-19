using System;

namespace ACT.Config;

[Serializable]
public class HandBookMain
{
	public readonly int id;

	public readonly int contentLv1name;

	public readonly int[] contentLv2ID = new int[0];

	public readonly int banner;

	public readonly int tabOrder;

	public HandBookMain(int id, int contentLv1name, int[] contentLv2ID, int banner, int tabOrder)
	{
		this.id = id;
		this.contentLv1name = contentLv1name;
		this.contentLv2ID = contentLv2ID;
		this.banner = banner;
		this.tabOrder = tabOrder;
	}
}
