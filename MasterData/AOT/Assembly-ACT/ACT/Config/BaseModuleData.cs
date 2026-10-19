using System;

namespace ACT.Config;

[Serializable]
public class BaseModuleData
{
	public readonly int id;

	public readonly int localName;

	public BaseModuleData(int id, int localName)
	{
		this.id = id;
		this.localName = localName;
	}
}
