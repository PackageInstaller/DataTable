using System;

namespace ACT.Config;

[Serializable]
public class JumpData
{
	public readonly int id;

	public readonly int jumpType;

	public readonly int[] jumpParam = new int[0];

	public JumpData(int id, int jumpType, int[] jumpParam)
	{
		this.id = id;
		this.jumpType = jumpType;
		this.jumpParam = jumpParam;
	}
}
