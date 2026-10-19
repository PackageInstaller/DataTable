using System;

namespace ACT.Config;

[Serializable]
public class SubAreaStateObject
{
	public readonly int id;

	public readonly int name;

	public readonly string RectSubRootName = "";

	public readonly float areaWeight;

	public SubAreaStateObject(int id, int name, string RectSubRootName, float areaWeight)
	{
		this.id = id;
		this.name = name;
		this.RectSubRootName = RectSubRootName;
		this.areaWeight = areaWeight;
	}
}
