using System.Collections.Generic;

public struct JointDrillBoss(int nBossId, long nHp, long nHpMax, long nToughness, int nEnergyValue, List<Lua2CSharpInfo_ResetBuffInfo> nbuffInfos)
{
	public int nBossId = nBossId;

	public long nHp = nHp;

	public long nHpMax = nHpMax;

	public long nToughness = nToughness;

	public int nEnergyValue = nEnergyValue;

	public List<Lua2CSharpInfo_ResetBuffInfo> nbuffInfos = nbuffInfos;
}
