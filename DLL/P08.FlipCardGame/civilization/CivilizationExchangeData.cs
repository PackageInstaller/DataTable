using System.Collections.Generic;
using LuaInterface;

namespace civilization;

public class CivilizationExchangeData
{
	public int activityID = 343741;

	public int stageID = 1;

	public int result;

	public int heroID = 1;

	public int age;

	public int turn;

	public int seconds;

	public List<int> gridList = new List<int>();

	public List<int> gridTypeList = new List<int>();

	public List<int> techList = new List<int>();

	public List<int> hexList = new List<int>();

	public List<int> source = new List<int>();

	public List<int> useSkillID = new List<int>();

	public List<int> useSkillNum = new List<int>();

	public List<int> unlockSkill = new List<int>();

	public CivilizationExchangeData(int activityID, int stageID, int heroID)
	{
		this.activityID = activityID;
		this.stageID = stageID;
		this.heroID = heroID;
		age = 0;
		turn = 0;
		gridList.Clear();
		gridTypeList.Clear();
		techList.Clear();
		hexList.Clear();
		source.Clear();
		useSkillID.Clear();
		useSkillNum.Clear();
		unlockSkill.Clear();
	}

	public void SetTech(int techID, bool isHex)
	{
		if (isHex)
		{
			if (!hexList.Contains(techID))
			{
				hexList.Add(techID);
			}
		}
		else if (!techList.Contains(techID))
		{
			techList.Add(techID);
		}
	}

	public void SetBlock(int blockType)
	{
		if (!gridTypeList.Contains(blockType))
		{
			gridTypeList.Add(blockType);
		}
	}

	[NoToLua]
	public void SetFinalData(bool isWin, bool isCancel, int age, int turn, int seconds, CivilizationGameBlock[,] blocks, List<int> source, int wideLimit, int hightLimit, Dictionary<int, int> skillUse, List<int> skillUnlock)
	{
		if (isWin)
		{
			result = 1;
		}
		else if (isCancel)
		{
			result = 3;
		}
		else
		{
			result = 2;
		}
		this.age = age;
		this.turn = turn;
		this.seconds = seconds;
		gridList.Clear();
		gridList.AddRange(new int[8]);
		for (int i = 0; i < wideLimit; i++)
		{
			for (int j = 0; j < hightLimit; j++)
			{
				if (blocks[i, j].kind > 0)
				{
					gridList[blocks[i, j].kind - 1]++;
				}
			}
		}
		useSkillID.Clear();
		useSkillNum.Clear();
		foreach (KeyValuePair<int, int> item in skillUse)
		{
			useSkillID.Add(item.Key);
			useSkillNum.Add(item.Value);
		}
		foreach (int item2 in skillUnlock)
		{
			unlockSkill.Add(item2);
		}
		this.source.Clear();
		this.source.Add(source[1]);
		this.source.Add(source[2]);
		this.source.Add(source[3]);
	}
}
