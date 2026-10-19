using System;

namespace ACT.Config;

[Serializable]
public class SystemRecordItem
{
	public readonly int id;

	public SystemRecordItem(int id)
	{
		this.id = id;
	}
}
