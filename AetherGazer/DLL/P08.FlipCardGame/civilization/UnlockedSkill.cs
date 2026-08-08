using UnityEngine;

namespace civilization;

public class UnlockedSkill
{
	public int skillID;

	public int cost;

	public int cd;

	public int maxCd;

	public UnlockedSkill(int skillID, int maxCd)
	{
		this.skillID = skillID;
		this.maxCd = maxCd;
		cd = 0;
	}

	public void ChangeSkillCd()
	{
		cd = Mathf.Max(cd - 1, 0);
	}

	public void SetCost(int cost)
	{
		this.cost = cost;
	}

	public void UseSkill()
	{
		cd = maxCd;
	}
}
