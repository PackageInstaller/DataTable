using System;

namespace ACT.Config;

[Serializable]
public class PreconditionData
{
	public readonly int id;

	public readonly int desId;

	public PreconditionData(int id, int desId)
	{
		this.id = id;
		this.desId = desId;
	}
}
