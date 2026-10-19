using System;

namespace ACT.Config;

[Serializable]
public class DialogueImageData
{
	public readonly int id;

	public readonly string path = "";

	public DialogueImageData(int id, string path)
	{
		this.id = id;
		this.path = path;
	}
}
