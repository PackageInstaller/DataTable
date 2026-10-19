using System;

namespace ACT.Config;

[Serializable]
public class ElementConfig
{
	public readonly int id;

	public readonly int name;

	public readonly string elementColour = "";

	public ElementConfig(int id, int name, string elementColour)
	{
		this.id = id;
		this.name = name;
		this.elementColour = elementColour;
	}
}
