using System.Collections.Generic;
using UnityEngine;

namespace civilization;

public class CivilizationSkillData
{
	public List<UnlockedSkill> unlockSkillList_ = new List<UnlockedSkill>();

	private Dictionary<int, int> costChangeDic_ = new Dictionary<int, int>();

	public int freeSkillNum1;

	public int freeSkillNum2;

	public bool isAttackFree;

	public CivilizationSkillData()
	{
		Init();
	}

	public void Init()
	{
		unlockSkillList_.Clear();
		costChangeDic_.Clear();
		freeSkillNum1 = 0;
		freeSkillNum2 = 0;
		isAttackFree = false;
	}

	public void UnInit()
	{
	}

	private int GetUnlockSkillIndex(int skillID)
	{
		for (int i = 0; i < unlockSkillList_.Count; i++)
		{
			if (unlockSkillList_[i].skillID == skillID)
			{
				return i;
			}
		}
		return -1;
	}

	public void UnlockSkill(int skillID)
	{
		Skill skillByID = CivilizationCfg.GetSkillByID(skillID);
		UnlockedSkill item = new UnlockedSkill(skillID, skillByID.cd);
		unlockSkillList_.Add(item);
		CalCost(skillID);
		CivilizationMain.Instance.UpdateSkill();
		CivilizationMain.Instance.skillUnlockList.Add(skillID);
	}

	public void ChangeSkill(int deleteSkillID, int skillID)
	{
		Skill skillByID = CivilizationCfg.GetSkillByID(skillID);
		UnlockedSkill unlockedSkill = new UnlockedSkill(skillID, skillByID.cd);
		if (GetUnlockSkillIndex(deleteSkillID) != -1)
		{
			unlockSkillList_[GetUnlockSkillIndex(deleteSkillID)] = unlockedSkill;
		}
		else
		{
			unlockSkillList_.Add(unlockedSkill);
		}
		CalCost(skillID);
		CivilizationMain.Instance.UpdateSkill();
	}

	public void DeleteSkill(int skillID)
	{
		if (GetUnlockSkillIndex(skillID) != -1)
		{
			unlockSkillList_.RemoveAt(GetUnlockSkillIndex(skillID));
		}
		CivilizationMain.Instance.UpdateSkill();
	}

	public void CalCost(int skillID)
	{
		if (GetUnlockSkillIndex(skillID) != -1)
		{
			int num = CivilizationCfg.GetSkillByID(skillID).cost;
			if (costChangeDic_.ContainsKey(skillID))
			{
				num += costChangeDic_[skillID];
			}
			num = Mathf.Max(num, 0);
			unlockSkillList_[GetUnlockSkillIndex(skillID)].SetCost(num);
		}
	}

	public void ChangeSkillCost(int skillID, int costNum)
	{
		if (!costChangeDic_.ContainsKey(skillID))
		{
			costChangeDic_.Add(skillID, costNum);
		}
		else
		{
			costChangeDic_[skillID] += costNum;
		}
		CalCost(skillID);
	}

	public void ChangeSkillCost(int costNum)
	{
		foreach (Skill item in CivilizationCfg.skill)
		{
			int id = item.id;
			if (!costChangeDic_.ContainsKey(id))
			{
				costChangeDic_.Add(id, costNum);
			}
			else
			{
				costChangeDic_[id] += costNum;
			}
			CalCost(id);
		}
	}

	public void ChangeSkillCd()
	{
		for (int i = 0; i < unlockSkillList_.Count; i++)
		{
			unlockSkillList_[i].ChangeSkillCd();
		}
		CivilizationMain.Instance.UpdateSkill();
	}

	public int GetSkillCd(int skillID)
	{
		return unlockSkillList_[GetUnlockSkillIndex(skillID)].cd;
	}

	public bool GetIsFree()
	{
		if (freeSkillNum1 + freeSkillNum2 <= 0)
		{
			return false;
		}
		return true;
	}

	public void UseSkill(int skillID)
	{
		unlockSkillList_[GetUnlockSkillIndex(skillID)].UseSkill();
	}
}
