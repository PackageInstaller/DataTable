using System;

namespace ACT.Config;

[Serializable]
public class AreaList
{
	public readonly int id;

	public readonly int name;

	public readonly int type;

	public readonly int[] pointId = new int[0];

	public readonly int UiIcon;

	public readonly int UiBG;

	public AreaList(int id, int name, int type, int[] pointId, int UiIcon, int UiBG)
	{
		this.id = id;
		this.name = name;
		this.type = type;
		this.pointId = pointId;
		this.UiIcon = UiIcon;
		this.UiBG = UiBG;
	}
}
