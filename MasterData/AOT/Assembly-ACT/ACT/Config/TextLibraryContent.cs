using System;

namespace ACT.Config;

[Serializable]
public class TextLibraryContent
{
	public readonly int id;

	public readonly int titleName;

	public readonly int type;

	public readonly int content;

	public readonly int resName;

	public readonly int itemId;

	public TextLibraryContent(int id, int titleName, int type, int content, int resName, int itemId)
	{
		this.id = id;
		this.titleName = titleName;
		this.type = type;
		this.content = content;
		this.resName = resName;
		this.itemId = itemId;
	}
}
