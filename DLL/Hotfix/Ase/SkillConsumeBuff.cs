#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using Ase.ECS;
using GameFramework;

namespace Ase;

public class SkillConsumeBuff : BuffOperationBase<BuffDataSkillConsume>
{
	private HeroSkillTypeEnum skillTypeEnum;

	private bool isPropertyCooling;

	private SkillComponent skillComponent;

	private CoolingComponent coolingComponent;

	private Dictionary<int, float> modifyDic = new Dictionary<int, float>();

	protected override void OnInit()
	{
		isPropertyCooling = CheckPropertyCooling(dataBase.coolingType);
	}

	protected override void OnExecute()
	{
		OnAddition();
	}

	private void OnAddition()
	{
		skillComponent = base.buffOwner.GetComponent<SkillComponent>();
		if (skillComponent == null)
		{
			Log.Error("buff 10 错误：实体没有技能组件");
			return;
		}
		coolingComponent = base.buffOwner.GetComponent<CoolingComponent>();
		if (coolingComponent == null)
		{
			Log.Error("buff 10 错误：实体没有冷却组件");
			return;
		}
		skillTypeEnum = GetHeroSkillTypeEnum(dataBase.skillType);
		if (skillTypeEnum == HeroSkillTypeEnum.None)
		{
			Log.Error($"修改技能冷却buff，id：{base.buffId}，技能类型异常{dataBase.skillType}");
			Toast.ShowError($"修改技能冷却buff，id：{base.buffId}，技能类型异常{dataBase.skillType}");
			return;
		}
		List<HeroSkillData> skillGroup = skillComponent.GetSkillGroup(skillTypeEnum);
		if (skillGroup.IsNullOrEmpty())
		{
			Log.Error("buff 10 错误：未找到技能数据");
			return;
		}
		for (int i = 0; i < skillGroup.Count; i++)
		{
			OnModifySkillConsume(skillGroup[i].Id);
		}
	}

	private void OnModifySkillConsume(int skillId)
	{
		float num = 0f;
		if (isPropertyCooling)
		{
			float skillRelease = coolingComponent.GetSkillRelease(skillId, dataBase.coolingType.ToString());
			num = BuffExtension.GetModifyDelta(dataBase.changeType, dataBase.numberType, skillRelease, dataBase.changeVal);
			if (base.config.LayerOverlying)
			{
				num *= (float)base.buff.GetLayer();
			}
			coolingComponent.ChangeSkillRelease(skillId, dataBase.coolingType.ToString(), num, isSetValue: false);
		}
		else
		{
			float coolingTime = coolingComponent.GetCoolingTime(skillId);
			num = BuffExtension.GetModifyDelta(dataBase.changeType, dataBase.numberType, coolingTime, dataBase.changeVal);
			if (base.config.LayerOverlying)
			{
				num *= (float)base.buff.GetLayer();
			}
			coolingComponent.ReviseCoolingTime(skillId, num);
		}
		modifyDic.Add(skillId, num);
	}

	protected override void OnDispose()
	{
		OnClearAddition();
	}

	private void OnClearAddition()
	{
		coolingComponent = base.buffOwner.GetComponent<CoolingComponent>();
		if (coolingComponent == null)
		{
			return;
		}
		if (isPropertyCooling)
		{
			foreach (KeyValuePair<int, float> item in modifyDic)
			{
				coolingComponent.ChangeSkillRelease(item.Key, dataBase.coolingType.ToString(), 0f - item.Value, isSetValue: false);
			}
		}
		else
		{
			foreach (KeyValuePair<int, float> item2 in modifyDic)
			{
				coolingComponent.ReviseCoolingTime(item2.Key, 0f - item2.Value);
			}
		}
		modifyDic.Clear();
	}

	protected override void OnUpdateLayerChanged(int deltaLayer)
	{
		if (base.buff.HasOperations)
		{
			OnClearAddition();
			OnAddition();
		}
	}

	private HeroSkillTypeEnum GetHeroSkillTypeEnum(InputOptionEnum specificDataSkillType)
	{
		return specificDataSkillType switch
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

	private bool CheckPropertyCooling(SkillCoolingType specificDataCoolingType)
	{
		if ((uint)(specificDataCoolingType - 1) <= 2u)
		{
			return true;
		}
		return false;
	}
}
