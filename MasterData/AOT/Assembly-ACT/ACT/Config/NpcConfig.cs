using System;

namespace ACT.Config;

[Serializable]
public class NpcConfig
{
	public readonly int id;

	public readonly int name;

	public readonly int title;

	public readonly int content;

	public readonly bool type;

	public NpcConfig(int id, int name, int title, int content, bool type)
	{
		this.id = id;
		this.name = name;
		this.title = title;
		this.content = content;
		this.type = type;
	}
}
