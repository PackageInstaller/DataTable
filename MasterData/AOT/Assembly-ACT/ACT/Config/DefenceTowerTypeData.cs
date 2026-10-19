using System;

namespace ACT.Config;

[Serializable]
public class DefenceTowerTypeData
{
	public readonly int id;

	public readonly int defenceTowerTypeDesc;

	public DefenceTowerTypeData(int id, int defenceTowerTypeDesc)
	{
		this.id = id;
		this.defenceTowerTypeDesc = defenceTowerTypeDesc;
	}
}
