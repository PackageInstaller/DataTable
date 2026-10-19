using System;

namespace ACT.Config;

[Serializable]
public class DialogueBGMData
{
	public readonly int id;

	public readonly string key = "";

	public DialogueBGMData(int id, string key)
	{
		this.id = id;
		this.key = key;
	}
}
