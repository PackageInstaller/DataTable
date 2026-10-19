using System;

namespace ACT.Config;

[Serializable]
public class DialogueBackgroundData
{
	public readonly int id;

	public readonly string path = "";

	public readonly int type;

	public readonly int defaultEffect;

	public DialogueBackgroundData(int id, string path, int type, int defaultEffect)
	{
		this.id = id;
		this.path = path;
		this.type = type;
		this.defaultEffect = defaultEffect;
	}
}
