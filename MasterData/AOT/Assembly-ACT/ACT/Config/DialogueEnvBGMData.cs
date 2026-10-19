using System;

namespace ACT.Config;

[Serializable]
public class DialogueEnvBGMData
{
	public readonly int id;

	public readonly string key = "";

	public DialogueEnvBGMData(int id, string key)
	{
		this.id = id;
		this.key = key;
	}
}
