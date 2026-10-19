using System;

namespace ACT.Config;

[Serializable]
public class ChapterIndex
{
	public readonly int id;

	public readonly int name;

	public ChapterIndex(int id, int name)
	{
		this.id = id;
		this.name = name;
	}
}
