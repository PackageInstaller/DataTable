using System;

namespace ACT.Config;

[Serializable]
public class TrapTypeData
{
	public readonly int id;

	public readonly int trapTypeDesc;

	public TrapTypeData(int id, int trapTypeDesc)
	{
		this.id = id;
		this.trapTypeDesc = trapTypeDesc;
	}
}
