using System;

namespace ACT.Config;

[Serializable]
public class TextLibraryMain
{
	public readonly int id;

	public readonly int name;

	public readonly int level;

	public TextLibraryMain(int id, int name, int level)
	{
		this.id = id;
		this.name = name;
		this.level = level;
	}
}
