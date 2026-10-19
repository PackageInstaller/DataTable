using System;

namespace ACT.Config;

[Serializable]
public class EntityCharacterTag
{
	public readonly int id;

	public readonly int tagTitle;

	public readonly int tagDescLocal;

	public readonly string frameColor = "";

	public readonly string tagColor = "";

	public EntityCharacterTag(int id, int tagTitle, int tagDescLocal, string frameColor, string tagColor)
	{
		this.id = id;
		this.tagTitle = tagTitle;
		this.tagDescLocal = tagDescLocal;
		this.frameColor = frameColor;
		this.tagColor = tagColor;
	}
}
