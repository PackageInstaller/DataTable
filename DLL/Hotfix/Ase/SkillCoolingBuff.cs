using Ase.ECS;
using UnityEngine;

namespace Ase;

public class SkillCoolingBuff : BuffOperationBase<BuffDataSkillCooling>
{
	protected override void OnExecute()
	{
		CoolingComponent component = base.buffOwner.GetComponent<CoolingComponent>();
		if (component == null)
		{
			return;
		}
		if (dataBase.propertyType == PropertyType.Cur)
		{
			if (dataBase.changeType == ChangeType.Reset)
			{
				component.ResetCurCoolingTime(dataBase.skillId);
				return;
			}
			float curCoolingTime = component.GetCurCoolingTime(dataBase.skillId);
			curCoolingTime = CalcCoolingTime(curCoolingTime, dataBase.changeType, dataBase.value);
			component.SetCurCoolingTime(dataBase.skillId, curCoolingTime);
		}
		else if (dataBase.propertyType == PropertyType.Max)
		{
			if (dataBase.changeType == ChangeType.Reset)
			{
				component.ResetCoolingTime(dataBase.skillId);
				return;
			}
			float coolingTime = component.GetCoolingTime(dataBase.skillId);
			coolingTime = CalcCoolingTime(coolingTime, dataBase.changeType, dataBase.value);
			component.SetCoolingTime(dataBase.skillId, coolingTime);
		}
	}

	protected override void OnDispose()
	{
	}

	private float CalcCoolingTime(float coolingTime, ChangeType changeType, float value)
	{
		switch (changeType)
		{
		case ChangeType.Set:
			return value;
		case ChangeType.Add:
			return Mathf.Max(0f, coolingTime + value);
		case ChangeType.Dec:
			return Mathf.Max(0f, coolingTime - value);
		case ChangeType.Mul:
			return Mathf.Max(0f, coolingTime * value);
		case ChangeType.Div:
			if (!(coolingTime <= 0f))
			{
				return Mathf.Max(0f, coolingTime / value);
			}
			return 0f;
		default:
			return coolingTime;
		}
	}
}
