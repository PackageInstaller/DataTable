using System;

namespace ACT.Config;

[Serializable]
public class GmCommandGroup
{
	public readonly int id;

	public readonly string gmName = "";

	public readonly string[] commandGroup = new string[0];

	public GmCommandGroup(int id, string gmName, string[] commandGroup)
	{
		this.id = id;
		this.gmName = gmName;
		this.commandGroup = commandGroup;
	}
}
