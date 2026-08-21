#define ENABLE_ERROR_AND_ABOVE_LOG
using Ase.ECS;
using GameFramework;

namespace Ase;

public class SkillConsumeByIdBuff : BuffOperationBase<BuffDataSkillConsumeById>
{
	private float delta;

	private SkillComponent skillComponent;

	private CoolingComponent coolingComponent;

	private bool isPropertyCooling;

	protected override void OnInit()
	{
		isPropertyCooling = CheckPropertyCooling(dataBase.coolingType);
	}

	protected override void OnExecute()
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
		if (skillComponent.GetSkillData(dataBase.skillId) == null)
		{
			Log.Error("buff 1004 错误：技能数据为空");
			return;
		}
		delta = 0f;
		OnModifySkillConsume(dataBase.skillId);
	}

	private void OnModifySkillConsume(int skillId)
	{
		if (isPropertyCooling)
		{
			float skillRelease = coolingComponent.GetSkillRelease(skillId, dataBase.coolingType.ToString());
			delta = BuffExtension.GetModifyDelta(dataBase.changeType, dataBase.numberType, skillRelease, dataBase.changeVal);
			if (base.config.LayerOverlying)
			{
				delta *= base.buff.GetLayer();
			}
			coolingComponent.ChangeSkillRelease(skillId, dataBase.coolingType.ToString(), delta, isSetValue: false);
		}
		else
		{
			float coolingTime = coolingComponent.GetCoolingTime(skillId);
			delta = BuffExtension.GetModifyDelta(dataBase.changeType, dataBase.numberType, coolingTime, dataBase.changeVal);
			if (base.config.LayerOverlying)
			{
				delta *= base.buff.GetLayer();
			}
			coolingComponent.ReviseCoolingTime(skillId, delta);
		}
	}

	protected override void OnDispose()
	{
		OnResetSkillConsume();
	}

	private void OnResetSkillConsume()
	{
		coolingComponent = base.buffOwner.GetComponent<CoolingComponent>();
		if (coolingComponent != null)
		{
			if (isPropertyCooling)
			{
				coolingComponent.ChangeSkillRelease(dataBase.skillId, dataBase.coolingType.ToString(), 0f - delta, isSetValue: false);
			}
			else
			{
				coolingComponent.ReviseCoolingTime(dataBase.skillId, 0f - delta);
			}
		}
	}

	protected override void OnUpdateLayerChanged(int deltaLayer)
	{
		if (base.buff.HasOperations)
		{
			OnResetSkillConsume();
			OnModifySkillConsume(dataBase.skillId);
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
	}
}
