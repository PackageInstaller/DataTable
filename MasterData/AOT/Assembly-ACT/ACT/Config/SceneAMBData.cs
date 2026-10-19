using System;

namespace ACT.Config;

[Serializable]
public class SceneAMBData
{
	public readonly int id;

	public readonly string sceneAMB = "";

	public readonly string AMBParam = "";

	public SceneAMBData(int id, string sceneAMB, string AMBParam)
	{
		this.id = id;
		this.sceneAMB = sceneAMB;
		this.AMBParam = AMBParam;
	}
}
