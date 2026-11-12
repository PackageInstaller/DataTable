using System.Collections.Generic;

public struct Lua2CSharpInfo_SummonMonsterInfo(int summonerId, int monsterId, int hp, long leftTime, SummonCfg summonCfg, List<Lua2CSharpInfo_ResetBuffInfo> buffInfos)
{
	public int summonerId = summonerId;

	public int monsterId = monsterId;

	public int hp = hp;

	public long leftTime = leftTime;

	public SummonCfg summonCfg = summonCfg;

	public List<Lua2CSharpInfo_ResetBuffInfo> buffInfos = buffInfos;
}
