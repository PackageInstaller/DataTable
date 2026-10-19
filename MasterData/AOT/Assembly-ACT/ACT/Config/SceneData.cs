using System;

namespace ACT.Config;

[Serializable]
public class SceneData
{
	public readonly int id;

	public readonly int localname;

	public SceneData(int id, int localname)
	{
		this.id = id;
		this.localname = localname;
	}
}
