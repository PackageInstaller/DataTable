using System.Collections.Generic;

namespace BilliardGame.Runtime;

public struct HeroHeadContext
{
	public int maxHp;

	public int curHp;

	public int curShield;

	public int maxCd;

	public int curCd;

	public int skillCost;

	public bool isTired;

	public List<int> buffIDList;

	public List<int> timeList;
}
