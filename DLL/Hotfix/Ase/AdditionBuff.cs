using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class AdditionBuff : BuffOperationBase<BuffDataAddition>
{
	private float curAddition;

	private List<HeroSkillData> heroSkillDataList;

	protected override void OnExecute()
	{
		OnAddition();
	}

	private void OnAddition()
	{
		float num = dataBase.addition;
		if (base.config.LayerOverlying)
		{
			num *= (float)base.buff.GetLayer();
		}
		if (num == 0f)
		{
			return;
		}
		SkillComponent component = base.buffOwner.GetComponent<SkillComponent>();
		if (component == null)
		{
			return;
		}
		if (dataBase.additionType == AdditionType.Command)
		{
			HeroSkillTypeEnum heroSkillTypeEnum = GetHeroSkillTypeEnum(dataBase.skillTypeEnum);
			List<HeroSkillData> skillGroup = component.GetSkillGroup(heroSkillTypeEnum);
			if (skillGroup != null)
			{
				for (int i = 0; i < skillGroup.Count; i++)
				{
					HeroSkillData heroSkillData = skillGroup[i];
					heroSkillData.SetSkillAddition(dataBase.additionKind, num);
					AddBuffOperationRecord($"Buff执行\t技能ID{heroSkillData.Id} {heroSkillData.SkillAdditionData?.ToString()}");
				}
				curAddition += num;
			}
			return;
		}
		if (dataBase.skillTypeEnum == InputOptionEnum.AllSkill)
		{
			foreach (HeroSkillData value in component.GetHeroAllSkillData().Values)
			{
				if (!dataBase.isGlobalAddition)
				{
					value.SetSkillAddition(dataBase.additionKind, num);
					AddBuffOperationRecord($"Buff执行\t技能ID{value.Id} {value.SkillAdditionData?.ToString()}");
				}
				else
				{
					LogWarning(" AllSkill 无法与 Global 同时使用");
				}
			}
		}
		else if (!dataBase.isGlobalAddition)
		{
			HeroSkillTypeEnum heroSkillTypeEnum2 = GetHeroSkillTypeEnum(dataBase.skillTypeEnum);
			heroSkillDataList = component.GetSkillGroup(heroSkillTypeEnum2);
			if (heroSkillDataList != null)
			{
				foreach (HeroSkillData heroSkillData2 in heroSkillDataList)
				{
					heroSkillData2.SetSkillAddition(dataBase.additionKind, num);
					AddBuffOperationRecord($"Buff执行\t技能ID:{heroSkillData2.Id} {heroSkillData2.SkillAdditionData?.ToString()}");
				}
			}
		}
		else
		{
			component.SkillAdditionGlobal(dataBase.additionKind, num, base.config.FinishClearOperations);
			Ase.ECS.PropertyData skillAddtionGlobal = component.GetSkillAddtionGlobal(dataBase.additionKind);
			if (skillAddtionGlobal != null)
			{
				BattleProgressPropertyMonitor.RecordPropertyValue(base.buffOwner, skillAddtionGlobal.PropertyName, skillAddtionGlobal.CurValue);
				AddBuffOperationRecord("Buff执行\t属性数据:" + skillAddtionGlobal.ToString());
			}
		}
		curAddition += num;
	}

	protected override void OnUpdateLayerChanged(int deltaLayer)
	{
		base.OnUpdateLayerChanged(deltaLayer);
		if (base.buff.HasOperations)
		{
			ClearAddition();
			OnAddition();
		}
	}

	protected override void OnDispose()
	{
		ClearAddition();
	}

	private void ClearAddition()
	{
		if (curAddition == 0f)
		{
			return;
		}
		SkillComponent component = base.buffOwner.GetComponent<SkillComponent>();
		if (component == null)
		{
			return;
		}
		if (dataBase.additionType == AdditionType.Command)
		{
			HeroSkillTypeEnum heroSkillTypeEnum = GetHeroSkillTypeEnum(dataBase.skillTypeEnum);
			List<HeroSkillData> skillGroup = component.GetSkillGroup(heroSkillTypeEnum);
			if (skillGroup != null)
			{
				for (int i = 0; i < skillGroup.Count; i++)
				{
					HeroSkillData heroSkillData = skillGroup[i];
					heroSkillData.SetSkillAddition(dataBase.additionKind, 0f - curAddition);
					AddBuffOperationRecord($"Buff清除\t技能ID:{heroSkillData.Id} {heroSkillData.SkillAdditionData?.ToString()}");
				}
			}
			return;
		}
		if (dataBase.skillTypeEnum == InputOptionEnum.AllSkill)
		{
			foreach (HeroSkillData value in component.GetHeroAllSkillData().Values)
			{
				if (!dataBase.isGlobalAddition)
				{
					value.SetSkillAddition(dataBase.additionKind, 0f - curAddition);
					AddBuffOperationRecord($"Buff执行\t技能ID{value.Id} {value.SkillAdditionData?.ToString()}");
				}
				else
				{
					LogWarning(" AllSkill 无法与 Global 同时使用");
				}
			}
		}
		else if (!dataBase.isGlobalAddition && heroSkillDataList != null)
		{
			foreach (HeroSkillData heroSkillData2 in heroSkillDataList)
			{
				heroSkillData2.SetSkillAddition(dataBase.additionKind, 0f - curAddition);
				AddBuffOperationRecord($"Buff清除\t技能ID:{heroSkillData2.Id} {heroSkillData2.SkillAdditionData?.ToString()}");
			}
			heroSkillDataList = null;
		}
		else
		{
			component.SkillAdditionGlobal(dataBase.additionKind, 0f - curAddition, base.config.FinishClearOperations);
			Ase.ECS.PropertyData skillAddtionGlobal = component.GetSkillAddtionGlobal(dataBase.additionKind);
			if (skillAddtionGlobal != null)
			{
				AddBuffOperationRecord("Buff清除\t技能ID:属性数据:" + skillAddtionGlobal);
			}
		}
		curAddition = 0f;
	}

	private InputOptionEnum GetInputOptionEnum(HeroSkillTypeEnum specificDataSkillType)
	{
		return specificDataSkillType switch
		{
			HeroSkillTypeEnum.Attack => InputOptionEnum.Attack, 
			HeroSkillTypeEnum.Skill1 => InputOptionEnum.Skill1, 
			HeroSkillTypeEnum.Skill2 => InputOptionEnum.Skill2, 
			HeroSkillTypeEnum.Skill3 => InputOptionEnum.Skill3, 
			HeroSkillTypeEnum.Skill4 => InputOptionEnum.Skill4, 
			HeroSkillTypeEnum.Roll => InputOptionEnum.Dodge, 
			_ => InputOptionEnum.None, 
		};
	}

	private HeroSkillTypeEnum GetHeroSkillTypeEnum(InputOptionEnum optionEnum)
	{
		return optionEnum switch
		{
			InputOptionEnum.Attack => HeroSkillTypeEnum.Attack, 
			InputOptionEnum.Skill1 => HeroSkillTypeEnum.Skill1, 
			InputOptionEnum.Skill2 => HeroSkillTypeEnum.Skill2, 
			InputOptionEnum.Skill3 => HeroSkillTypeEnum.Skill3, 
			InputOptionEnum.Skill4 => HeroSkillTypeEnum.Skill4, 
			InputOptionEnum.Dodge => HeroSkillTypeEnum.Roll, 
			_ => HeroSkillTypeEnum.None, 
		};
	}
}
