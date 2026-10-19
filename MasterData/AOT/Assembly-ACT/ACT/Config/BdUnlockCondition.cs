using System;

namespace ACT.Config;

[Serializable]
public class BdUnlockCondition
{
	public readonly int id;

	public readonly int type;

	public readonly int param;

	public readonly int number;

	public BdUnlockCondition(int id, int type, int param, int number)
	{
		this.id = id;
		this.type = type;
		this.param = param;
		this.number = number;
	}
}
