using System;

namespace ACT.Config;

[Serializable]
public class EnemyDailyRespawnRule
{
	public readonly int id;

	public readonly int desc;

	public readonly int rule;

	public readonly bool lua;

	public readonly int[] weekdayvalue = new int[0];

	public EnemyDailyRespawnRule(int id, int desc, int rule, bool lua, int[] weekdayvalue)
	{
		this.id = id;
		this.desc = desc;
		this.rule = rule;
		this.lua = lua;
		this.weekdayvalue = weekdayvalue;
	}
}
