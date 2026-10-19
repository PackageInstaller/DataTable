using System;

namespace ACT.Config;

[Serializable]
public class SaleList
{
	public readonly int id;

	public readonly int type;

	public readonly int bundleid;

	public readonly int eventPoint;

	public SaleList(int id, int type, int bundleid, int eventPoint)
	{
		this.id = id;
		this.type = type;
		this.bundleid = bundleid;
		this.eventPoint = eventPoint;
	}
}
