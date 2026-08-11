using System.Collections.Generic;

namespace Ase;

public struct BattleReward
{
	public long AccountExpDelta;

	public long AccountOldExp;

	public bool IsUpgrade;

	public int Star;

	public int PassTime;

	public bool IsWin;

	public bool IsMulti;

	public List<TeamInfo> TeamInfos;

	public bool IsInit;

	public int RaceCopyScore;

	public bool IsNewRecord;

	public long CostEnergy;

	public bool IsFirst;
}
