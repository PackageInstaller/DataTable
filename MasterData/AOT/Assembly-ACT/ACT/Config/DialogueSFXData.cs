using System;

namespace ACT.Config;

[Serializable]
public class DialogueSFXData
{
	public readonly int id;

	public readonly string key = "";

	public DialogueSFXData(int id, string key)
	{
		this.id = id;
		this.key = key;
	}
}
