using System;

namespace ACT.Config;

[Serializable]
public class EntityRobotData
{
	public readonly int id;

	public readonly string name = "";

	public readonly string config = "";

	public readonly string AI = "";

	public EntityRobotData(int id, string name, string config, string AI)
	{
		this.id = id;
		this.name = name;
		this.config = config;
		this.AI = AI;
	}
}
