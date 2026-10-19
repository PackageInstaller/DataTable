using System;

namespace ACT.Config;

[Serializable]
public class TextLibrary
{
	public readonly int id;

	public readonly int name;

	public readonly int tabId;

	public readonly int[] content = new int[0];

	public TextLibrary(int id, int name, int tabId, int[] content)
	{
		this.id = id;
		this.name = name;
		this.tabId = tabId;
		this.content = content;
	}
}
