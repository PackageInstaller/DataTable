using System;

namespace ACT.Config;

[Serializable]
public class TeamParameters
{
	public readonly int id;

	public readonly int nodeID;

	public readonly int type;

	public readonly string name = "";

	public readonly int TypeValueOne;

	public readonly float TypeValueTwo;

	public readonly bool TypeValueThree;

	public TeamParameters(int id, int nodeID, int type, string name, int TypeValueOne, float TypeValueTwo, bool TypeValueThree)
	{
		this.id = id;
		this.nodeID = nodeID;
		this.type = type;
		this.name = name;
		this.TypeValueOne = TypeValueOne;
		this.TypeValueTwo = TypeValueTwo;
		this.TypeValueThree = TypeValueThree;
	}
}
