using System;
using UnityEngine;
using UnityEngine.UI;

namespace civilization;

public class CivilizationGameSkillBlock : CivilizationGameBlockBase
{
	private const string MAX = "skillmax";

	private const string NOT = "skillnot";

	public int skillID;

	public int cost;

	public int cd;

	public bool isSetData;

	public Text skillCost;

	public GameObject cdMaskGo;

	public Text cdText;

	public Button tipsBtn;

	public Animator animator;

	public override bool IsSkill => true;

	public void RefreshSkillShow(bool isShow, UnlockedSkill skill = null)
	{
		if (!isShow)
		{
			blockGo.SetActive(value: false);
			isSetData = false;
			tipsBtn.onClick.RemoveAllListeners();
		}
		else if (skill != null)
		{
			blockGo.SetActive(value: true);
			isSetData = true;
			skillID = skill.skillID;
			cd = skill.cd;
			cost = skill.cost;
			FreshBlock(newBlock: true);
			tipsBtn.onClick.RemoveAllListeners();
			tipsBtn.onClick.AddListener(delegate
			{
				LuaHelper.CallFunction("CivilizationGameToLuaBridge.ClickSkill", skillID, base.transform);
			});
			if (skillID == 1017)
			{
				ShowTipsAni(isShow: true);
			}
			else
			{
				ShowTipsAni(isShow: false);
			}
		}
	}

	public override void FreshBlock(bool newBlock, bool isMouse = false)
	{
		int skillCD = CivilizationMain.Instance.GetSkillCD(skillID);
		blockGo.SetActive(value: true);
		cdMaskGo.SetActive(skillCD != 0);
		cdText.text = skillCD.ToString();
		image.sprite = AtlasManager.GetSpriteWithoutAtlas(CivilizationCfg.skill.Find((Skill s) => s.id == skillID).spritePath);
		if (!isMouse)
		{
			FreshSkillCost();
		}
	}

	public void FreshSkillCost()
	{
		if (CivilizationMain.Instance.skillData.GetIsFree())
		{
			skillCost.text = "0";
		}
		else
		{
			skillCost.text = cost.ToString();
		}
		if (CivilizationMain.Instance.source[3] >= cost || CivilizationMain.Instance.skillData.GetIsFree())
		{
			LuaHelper.CallFunction("CivilizationGameToLuaBridge.ChangeControllerState", base.transform, "skill", "skillmax");
		}
		else
		{
			LuaHelper.CallFunction("CivilizationGameToLuaBridge.ChangeControllerState", base.transform, "skill", "skillnot");
		}
	}

	public bool CanUse(int freeSkillNum)
	{
		if (!isSetData)
		{
			return false;
		}
		int skillCD = CivilizationMain.Instance.GetSkillCD(skillID);
		if (skillCD > 0)
		{
			return false;
		}
		if (CivilizationMain.Instance.source[3] < cost && freeSkillNum <= 0)
		{
			return false;
		}
		if (skillCD == 0 && (CivilizationMain.Instance.source[3] >= cost || freeSkillNum > 0))
		{
			return true;
		}
		return false;
	}

	public bool CheckSkill(CivilizationGameBlock mouseOnBlock, ref int freeSkillNum1, ref int freeSkillNum2)
	{
		if (mouseOnBlock == null || mouseOnBlock.IsSkill)
		{
			return false;
		}
		bool flag = false;
		switch (skillID)
		{
		case 1001:
			if (mouseOnBlock.kind == 0)
			{
				CivilizationMain.Instance.NewBlock(mouseOnBlock.x, mouseOnBlock.y, 1, 1);
				flag = true;
			}
			break;
		case 1002:
		{
			if (mouseOnBlock.kind != 4)
			{
				break;
			}
			if (CivilizationMain.Instance.gameType == GameType.Teach)
			{
				CivilizationMain.Instance.teachStep++;
				CivilizationMain.Instance.isTeach = false;
			}
			int num8 = 2;
			CivilizationMain.Instance.ChangeSource(SourceType.FOOD, num8);
			mouseOnBlock.BeDestroy();
			flag = true;
			if (CivilizationMain.Instance.beastBonusProbability > 0 && CivilizationMain.Instance.beasts.Count > 0)
			{
				int num9 = UnityEngine.Random.Range(1, 101);
				if (num9 <= CivilizationMain.Instance.beastBonusProbability)
				{
					int index3 = num9 % CivilizationMain.Instance.beasts.Count;
					CivilizationMain.Instance.beasts[index3].BeDestroy();
					CivilizationMain.Instance.uiInstance.UpdateHexAni(2002, 1);
				}
			}
			if (CivilizationMain.Instance.skillData.isAttackFree)
			{
				CivilizationMain.Instance.uiInstance.UpdateHexAni(2003, 1);
			}
			break;
		}
		case 1003:
			if (mouseOnBlock.kind == 1 || mouseOnBlock.kind == 2 || mouseOnBlock.kind == 3 || (mouseOnBlock.kind == 8 && mouseOnBlock.speed < 4))
			{
				mouseOnBlock.speed = 4 + CivilizationMain.Instance.moveAdd;
				if (CivilizationMain.Instance.moveAdd > 0)
				{
					CivilizationMain.Instance.uiInstance.UpdateHexAni(2004, CivilizationMain.Instance.moveAdd);
				}
				mouseOnBlock.SetBuff();
				flag = true;
			}
			break;
		case 1004:
			if (mouseOnBlock.kind == 0)
			{
				CivilizationMain.Instance.NewBlock(mouseOnBlock.x, mouseOnBlock.y, 8, 1);
				CivilizationMain.Instance.buildings.Add(mouseOnBlock);
				flag = true;
			}
			break;
		case 1005:
			if ((mouseOnBlock.kind == 1 || mouseOnBlock.kind == 2 || mouseOnBlock.kind == 3) && mouseOnBlock.level == 1)
			{
				mouseOnBlock.level = 2;
				mouseOnBlock.FreshBlock(newBlock: true);
				flag = true;
			}
			break;
		case 1006:
			if (mouseOnBlock.kind == 5)
			{
				mouseOnBlock.number -= 6;
				if (mouseOnBlock.number <= 0)
				{
					mouseOnBlock.number = 0;
					mouseOnBlock.BeDestroy();
				}
				else
				{
					mouseOnBlock.FreshBlock(newBlock: false);
				}
				flag = true;
			}
			break;
		case 1007:
			if ((mouseOnBlock.kind == 1 || mouseOnBlock.kind == 2 || mouseOnBlock.kind == 3) && mouseOnBlock.level < 3)
			{
				mouseOnBlock.level = 3;
				mouseOnBlock.FreshBlock(newBlock: true);
				flag = true;
			}
			break;
		case 1008:
		{
			int num11 = 0;
			for (int m = Math.Max(mouseOnBlock.y - 1, 0); m <= Math.Min(mouseOnBlock.y + 1, CivilizationMain.Instance.hightLimit - 1); m++)
			{
				for (int n = Math.Max(mouseOnBlock.x - 1, 0); n <= Math.Min(mouseOnBlock.x + 1, CivilizationMain.Instance.wideLimit - 1); n++)
				{
					if (CivilizationMain.Instance.blockCells[n, m].kind == 1)
					{
						num11 += CivilizationMain.Instance.blockCells[n, m].level;
						CivilizationMain.Instance.blockCells[n, m].BeDestroy(needAni: true);
					}
				}
			}
			CivilizationMain.Instance.ChangeSource(SourceType.FOOD, num11);
			break;
		}
		case 1009:
		{
			int num2 = Math.Max(mouseOnBlock.x - 2, 0);
			int num3 = Math.Min(mouseOnBlock.x + 2, CivilizationMain.Instance.wideLimit - 1);
			int num4 = Math.Max(mouseOnBlock.y - 2, 0);
			int num5 = Math.Min(mouseOnBlock.y + 2, CivilizationMain.Instance.hightLimit - 1);
			int num6 = 0;
			for (int i = num4; i <= num5; i++)
			{
				for (int j = num2; j <= num3; j++)
				{
					if (CivilizationMain.Instance.blockCells[j, i].kind == 4)
					{
						CivilizationMain.Instance.blockCells[j, i].BeDestroy();
						num6 += 2;
					}
				}
			}
			CivilizationMain.Instance.ChangeSource(SourceType.FOOD, num6);
			flag = true;
			if (CivilizationMain.Instance.beastBonusProbability > 0 && CivilizationMain.Instance.beasts.Count > 0)
			{
				int num7 = UnityEngine.Random.Range(1, 101);
				if (num7 <= CivilizationMain.Instance.beastBonusProbability)
				{
					int index2 = num7 % CivilizationMain.Instance.beasts.Count;
					CivilizationMain.Instance.beasts[index2].BeDestroy();
					CivilizationMain.Instance.uiInstance.UpdateHexAni(2002, 1);
				}
			}
			break;
		}
		case 1010:
			if (mouseOnBlock.kind == 1 || mouseOnBlock.kind == 2 || mouseOnBlock.kind == 3 || (mouseOnBlock.kind == 8 && mouseOnBlock.speed < 6))
			{
				mouseOnBlock.speed = 6 + CivilizationMain.Instance.moveAdd;
				mouseOnBlock.SetBuff();
				flag = true;
			}
			break;
		case 1011:
			if (mouseOnBlock.kind == 0)
			{
				CivilizationMain.Instance.NewBlock(mouseOnBlock.x, mouseOnBlock.y, 1, 3);
				flag = true;
			}
			break;
		case 1012:
			if (mouseOnBlock.kind == 1 || mouseOnBlock.kind == 2 || mouseOnBlock.kind == 3 || mouseOnBlock.kind == 8)
			{
				mouseOnBlock.speed = 999;
				mouseOnBlock.SetBuff();
				flag = true;
			}
			break;
		case 1013:
			if ((mouseOnBlock.kind == 1 || mouseOnBlock.kind == 2 || mouseOnBlock.kind == 3) && mouseOnBlock.level < 4)
			{
				mouseOnBlock.level = 4;
				mouseOnBlock.FreshBlock(newBlock: true);
				flag = true;
			}
			break;
		case 1014:
		{
			int num10 = 0;
			for (int k = Math.Max(mouseOnBlock.y - 1, 0); k <= Math.Min(mouseOnBlock.y + 1, CivilizationMain.Instance.hightLimit - 1); k++)
			{
				for (int l = Math.Max(mouseOnBlock.x - 1, 0); l <= Math.Min(mouseOnBlock.x + 1, CivilizationMain.Instance.wideLimit - 1); l++)
				{
					if (CivilizationMain.Instance.blockCells[l, k].kind == 3)
					{
						num10 += CivilizationMain.Instance.blockCells[l, k].level;
						CivilizationMain.Instance.blockCells[l, k].BeDestroy(needAni: true);
					}
				}
			}
			CivilizationMain.Instance.ChangeSource(SourceType.POP, num10);
			break;
		}
		case 1015:
			if (mouseOnBlock.kind != 6)
			{
				break;
			}
			mouseOnBlock.BeDestroy();
			if (CivilizationMain.Instance.bomBonusProbability > 0 && CivilizationMain.Instance.boms.Count > 0)
			{
				int num = UnityEngine.Random.Range(1, 101);
				if (num <= CivilizationMain.Instance.bomBonusProbability)
				{
					int index = num % CivilizationMain.Instance.boms.Count;
					CivilizationMain.Instance.boms[index].BeDestroy();
				}
			}
			flag = true;
			break;
		case 1016:
			if (mouseOnBlock.kind == 0)
			{
				mouseOnBlock.UseBuildSkill();
				mouseOnBlock.PlayAddAni(50, 2);
				CivilizationMain.Instance.ChangeSource(SourceType.TECH, 50);
				flag = true;
			}
			break;
		case 1017:
			if (mouseOnBlock.kind == 7)
			{
				if (CivilizationMain.Instance.gameType == GameType.Teach)
				{
					CivilizationMain.Instance.teachStep++;
					CivilizationMain.Instance.isTeach = false;
				}
				CivilizationMain.Instance.GameOver(isWin: true);
			}
			break;
		}
		if (flag)
		{
			if (freeSkillNum1 > 0)
			{
				freeSkillNum1--;
				CivilizationMain.Instance.uiInstance.UpdateHexAni(1004, freeSkillNum1);
			}
			else if (freeSkillNum2 > 0)
			{
				freeSkillNum2--;
				CivilizationMain.Instance.uiInstance.UpdateHexAni(1006, freeSkillNum2);
			}
			else
			{
				int skillCostSub = CivilizationMain.Instance.skillCostSub;
				int num12 = -(cost + skillCostSub);
				CivilizationMain.Instance.ChangeSource(SourceType.POP, num12);
			}
			if (CivilizationMain.Instance.skillUseCount.ContainsKey(skillID))
			{
				CivilizationMain.Instance.skillUseCount[skillID]++;
			}
			else
			{
				CivilizationMain.Instance.skillUseCount[skillID] = 1;
			}
			CivilizationMain.Instance.skillData.UseSkill(skillID);
			FreshBlock(newBlock: false);
		}
		return flag;
	}

	public override void CheckMask(CivilizationGameBlock block, ref int count)
	{
		if (block != null)
		{
			bool flag = false;
			switch (skillID)
			{
			case 1001:
				flag = block.kind == 0;
				break;
			case 1002:
				flag = block.kind == 4;
				break;
			case 1003:
				flag = block.kind == 1 || block.kind == 2 || block.kind == 3 || (block.kind == 8 && block.speed < 4);
				break;
			case 1004:
				flag = block.kind == 0;
				break;
			case 1005:
				flag = (block.kind == 1 || block.kind == 2 || block.kind == 3) && block.level == 1;
				break;
			case 1006:
				flag = block.kind == 5;
				break;
			case 1007:
				flag = (block.kind == 1 || block.kind == 2 || block.kind == 3) && block.level < 3;
				break;
			case 1008:
				flag = false;
				break;
			case 1009:
				flag = false;
				break;
			case 1010:
				flag = block.kind == 1 || block.kind == 2 || block.kind == 3 || (block.kind == 8 && block.speed < 6);
				break;
			case 1011:
				flag = block.kind == 0;
				break;
			case 1012:
				flag = block.kind == 1 || block.kind == 2 || block.kind == 3 || block.kind == 8;
				break;
			case 1013:
				flag = (block.kind == 1 || block.kind == 2 || block.kind == 3) && block.level < 4;
				break;
			case 1014:
				flag = false;
				break;
			case 1015:
				flag = block.kind == 6;
				break;
			case 1016:
				flag = block.kind == 0;
				break;
			case 1017:
				flag = block.kind == 7;
				break;
			}
			block.SetMask(!flag);
			if (flag)
			{
				count++;
			}
		}
	}

	public bool CheckSpecialMask()
	{
		if (skillID == 1008 || skillID == 1009 || skillID == 1014)
		{
			return true;
		}
		return false;
	}

	public override void StartDrag()
	{
		blockGo.SetActive(value: false);
	}

	public void ShowTipsAni(bool isShow)
	{
		if (isShow)
		{
			animator.Play("UI_skillGridItem_tishi");
		}
		else
		{
			animator.Play("UI_skillGridItem_default");
		}
	}
}
