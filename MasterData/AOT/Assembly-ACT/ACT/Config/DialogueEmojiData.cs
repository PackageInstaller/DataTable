using System;

namespace ACT.Config;

[Serializable]
public class DialogueEmojiData
{
	public readonly int id;

	public readonly string assetKey = "";

	public DialogueEmojiData(int id, string assetKey)
	{
		this.id = id;
		this.assetKey = assetKey;
	}
}
