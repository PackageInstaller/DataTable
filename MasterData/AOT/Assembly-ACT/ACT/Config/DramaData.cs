using System;

namespace ACT.Config;

[Serializable]
public class DramaData
{
	public readonly int id;

	public readonly int type;

	public readonly int content;

	public DramaData(int id, int type, int content)
	{
		this.id = id;
		this.type = type;
		this.content = content;
	}
}
