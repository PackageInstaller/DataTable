using System;

namespace ACT.Config;

[Serializable]
public class MapIconData
{
	public readonly int id;

	public readonly int type;

	public readonly int lightState;

	public readonly int greyState;

	public readonly int specialState;

	public readonly int scaleType;

	public MapIconData(int id, int type, int lightState, int greyState, int specialState, int scaleType)
	{
		this.id = id;
		this.type = type;
		this.lightState = lightState;
		this.greyState = greyState;
		this.specialState = specialState;
		this.scaleType = scaleType;
	}
}
