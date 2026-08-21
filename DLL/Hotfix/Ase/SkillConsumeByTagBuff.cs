#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using Ase.ECS;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class SkillConsumeByTagBuff : BuffOperationBase<BuffDataSkillConsumeByTag>
{
	private Dictionary<int, float> modifyDeltaDic = new Dictionary<int, float>();

	private SkillComponent skillComponent;

	private CoolingComponent coolingComponent;

	private bool isPropertyCooling;

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
			Log.Error("buff 1004 错误：实体没有技能组件");
			return;
		}
		coolingComponent = base.buffOwner.GetComponent<CoolingComponent>();
		if (coolingComponent == null)
		{
			Log.Error("buff 1004 错误：实体没有冷却组件");
			return;
		}
		ObservableDictionary<int, HeroSkillData> heroAllSkillData = skillComponent.GetHeroAllSkillData();
		if (heroAllSkillData == null)
		{
			Log.Error("buff 1004 错误：没有获取到技能数据");
			return;
		}
		foreach (HeroSkillData value in heroAllSkillData.Values)
		{
			if (value.GetSkillLabelList().Contains(dataBase.tag) == dataBase.isSel)
			{
				OnModifySkillConsume(value.Id);
			}
		}
	}

	private void OnModifySkillConsume(int skillId)
	{
		float num;
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
		modifyDeltaDic.Add(skillId, num);
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
			foreach (KeyValuePair<int, float> item in modifyDeltaDic)
			{
				coolingComponent.ChangeSkillRelease(item.Key, dataBase.coolingType.ToString(), 0f - item.Value, isSetValue: false);
			}
		}
		else
		{
			foreach (KeyValuePair<int, float> item2 in modifyDeltaDic)
			{
				coolingComponent.ReviseCoolingTime(item2.Key, 0f - item2.Value);
			}
		}
		modifyDeltaDic.Clear();
	}

	protected override void OnUpdateLayerChanged(int deltaLayer)
	{
		if (base.buff.HasOperations)
		{
			OnClearAddition();
			OnAddition();
		}
	}

	private bool CheckPropertyCooling(SkillCoolingType specificDataCoolingType)
	{
		if ((uint)(specificDataCoolingType - 1) <= 2u)
		{
			return true;
		}
		return false;
	}

	protected override void OnClear()
	{
		modifyDeltaDic?.Clear();
	}
}
