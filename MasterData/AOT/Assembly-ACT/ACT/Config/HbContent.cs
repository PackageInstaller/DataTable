using System;

namespace ACT.Config;

[Serializable]
public class HbContent
{
	public readonly int id;

	public readonly int contentName;

	public readonly int tabName;

	public readonly int contentType;

	public readonly int openRequire;

	public readonly int[] raidNewType = new int[0];

	public readonly int message;

	public HbContent(int id, int contentName, int tabName, int contentType, int openRequire, int[] raidNewType, int message)
	{
		this.id = id;
		this.contentName = contentName;
		this.tabName = tabName;
		this.contentType = contentType;
		this.openRequire = openRequire;
		this.raidNewType = raidNewType;
		this.message = message;
	}
}
