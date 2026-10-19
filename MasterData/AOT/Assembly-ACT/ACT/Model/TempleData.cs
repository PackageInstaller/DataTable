using System.Collections.Generic;
using ACT.Config;
using ACT.Game.Data;

namespace ACT.Model;

public class TempleData
{
	public int templeId;

	public bool unLock;

	public bool isComplate;

	public bool isExplored;

	public bool[] gotStars = new bool[3];

	public int collectTreasureNum;

	public int[] lastTeamCharacterIds;

	public int lastTeamPotionId;

	public InstanceDungeon staticData;

	public int completeTime;

	public StageChallengeTarget stageChallengeTarget;

	public Dictionary<int, int> battleTempleBuffMap;

	public bool isPerfect;
}
