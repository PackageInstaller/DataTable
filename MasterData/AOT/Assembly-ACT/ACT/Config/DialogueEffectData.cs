using System;

namespace ACT.Config;

[Serializable]
public class DialogueEffectData
{
	public readonly int id;

	public readonly string key = "";

	public DialogueEffectData(int id, string key)
	{
		this.id = id;
		this.key = key;
	}
}
