using System;

namespace ACT.Config;

[Serializable]
public class TemporaryActivityGoalData
{
	public readonly int id;

	public readonly int jumpType;

	public readonly int[] jumpParam = new int[0];

	public readonly int jumpText;

	public TemporaryActivityGoalData(int id, int jumpType, int[] jumpParam, int jumpText)
	{
		this.id = id;
		this.jumpType = jumpType;
		this.jumpParam = jumpParam;
		this.jumpText = jumpText;
	}
}
