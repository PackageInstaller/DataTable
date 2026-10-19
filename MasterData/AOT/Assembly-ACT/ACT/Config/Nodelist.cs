using System;

namespace ACT.Config;

[Serializable]
public class Nodelist
{
	public readonly int id;

	public readonly int nodeName;

	public readonly int nodeIcon;

	public Nodelist(int id, int nodeName, int nodeIcon)
	{
		this.id = id;
		this.nodeName = nodeName;
		this.nodeIcon = nodeIcon;
	}
}
