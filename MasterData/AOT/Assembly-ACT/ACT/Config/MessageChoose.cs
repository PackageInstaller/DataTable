using System;

namespace ACT.Config;

[Serializable]
public class MessageChoose
{
	public readonly int id;

	public readonly int chooseText;

	public MessageChoose(int id, int chooseText)
	{
		this.id = id;
		this.chooseText = chooseText;
	}
}
