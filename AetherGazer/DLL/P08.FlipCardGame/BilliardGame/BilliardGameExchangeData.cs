using System.Collections.Generic;

namespace BilliardGame;

public class BilliardGameExchangeData
{
	public int stageID;

	public int hard;

	public int result;

	public int start_seconds;

	public int use_seconds;

	public List<BilliardHeroOrMonsterData> heroInfoList;

	public List<BilliardHeroOrMonsterData> monsterInfoList;

	public int potHp;

	public int potDamage;

	public int potRegeneration;

	public int roundNum;

	public List<UseSkillData> skillList;

	public BilliardGameExchangeData(int stageID, int hard)
	{
		this.stageID = stageID;
		this.hard = hard;
		result = 0;
		use_seconds = 0;
		heroInfoList = new List<BilliardHeroOrMonsterData>();
		monsterInfoList = new List<BilliardHeroOrMonsterData>();
		potHp = 0;
		potDamage = 0;
		potRegeneration = 0;
		roundNum = 0;
		skillList = new List<UseSkillData>();
	}

	public void OnGameOver(int result, int now_seconds, int start_seconds, List<BilliardHeroOrMonsterData> heroList, List<BilliardHeroOrMonsterData> monsterList, int roundNum)
	{
		this.result = result;
		this.start_seconds = start_seconds;
		use_seconds = now_seconds - start_seconds;
		heroInfoList = heroList;
		monsterInfoList = monsterList;
		this.roundNum = roundNum;
	}

	public void OnUseSkill(int skillID, bool isAddNum)
	{
		UseSkillData useSkillData = skillList.Find((UseSkillData s) => s.id == skillID);
		if (useSkillData != null)
		{
			useSkillData.useNum++;
			if (isAddNum)
			{
				useSkillData.useNum++;
			}
		}
		else
		{
			UseSkillData item = new UseSkillData(skillID, 1, 1);
			skillList.Add(item);
		}
	}

	public void OnPotDamage(int damage, int hp)
	{
		potDamage += damage;
		potHp = hp;
	}

	public void OnPotRegeneration(int regeneration, int hp)
	{
		potRegeneration += regeneration;
		potHp = hp;
	}
}
