using System;

namespace ACT.Config;

[Serializable]
public class BattleRulesData
{
	public readonly int id;

	public readonly int desId;

	public BattleRulesData(int id, int desId)
	{
		this.id = id;
		this.desId = desId;
	}
}
