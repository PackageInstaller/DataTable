using System;

namespace ACT.Config;

[Serializable]
public class ExtraList
{
	public readonly int id;

	public readonly int nodeName;

	public ExtraList(int id, int nodeName)
	{
		this.id = id;
		this.nodeName = nodeName;
	}
}
