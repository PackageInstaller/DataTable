using System.Collections.Generic;

public class BattleResultForLua
{
	public long battleId;

	public bool Result;

	public float battleTime;

	public int totalDeadNum;

	public int totalHittedNum;

	public long injuredNum;

	public int fallDownNum;

	public int knockoutNum;

	public int qteExecuteCount;

	public int loadMilliseconds;

	public int resurrectTimes;

	public List<long> currentHP = new List<long>();

	public List<int> currentHPHero = new List<int>();

	public List<long> MaxHP = new List<long>();

	public Dictionary<int, int> items = new Dictionary<int, int>(new IntComparer());

	public Dictionary<int, int> recordDatas = new Dictionary<int, int>(new IntComparer());
}
