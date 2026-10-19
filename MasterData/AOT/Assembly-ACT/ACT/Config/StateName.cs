using System;

namespace ACT.Config;

[Serializable]
public class StateName
{
	public readonly int id;

	public readonly int type;

	public readonly string[] nodeID = new string[0];

	public StateName(int id, int type, string[] nodeID)
	{
		this.id = id;
		this.type = type;
		this.nodeID = nodeID;
	}
}
