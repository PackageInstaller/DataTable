using System;

namespace ACT.Config;

[Serializable]
public class RogueBlueprint
{
	public readonly int id;

	public readonly string addressable = "";

	public RogueBlueprint(int id, string addressable)
	{
		this.id = id;
		this.addressable = addressable;
	}
}
