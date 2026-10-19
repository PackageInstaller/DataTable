using System;

namespace ACT.Config;

[Serializable]
public class RogueEventText
{
	public readonly int id;

	public readonly int text;

	public RogueEventText(int id, int text)
	{
		this.id = id;
		this.text = text;
	}
}
