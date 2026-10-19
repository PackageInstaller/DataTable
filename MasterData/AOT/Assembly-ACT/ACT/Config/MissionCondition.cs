using System;

namespace ACT.Config;

[Serializable]
public class MissionCondition
{
	public readonly int id;

	public readonly int enumID;

	public readonly int descType;

	public readonly int desc;

	public readonly string param = "";

	public MissionCondition(int id, int enumID, int descType, int desc, string param)
	{
		this.id = id;
		this.enumID = enumID;
		this.descType = descType;
		this.desc = desc;
		this.param = param;
	}
}
