using System.Collections.Generic;
using Ase;
using Ase.ECS;
using UnityEngine;

public class PropertyCooling : CoolingBase
{
	public string propertyName;

	public float initParamValue;

	public int overdraw;

	public PropertyCooling(string[] param, bool isConsumeCondition, BaseEntity baseEntity)
		: base(param, isConsumeCondition, baseEntity)
	{
		if (param != null && param.Length != 0)
		{
			propertyName = param[1];
			if (isConsumeCondition)
			{
				overdraw = int.Parse(param[3]);
			}
			base.ReleaseParamValue = float.Parse(isConsumeCondition ? param[2] : param[3]);
			initParamValue = base.ReleaseParamValue;
		}
	}

	private float GetSkillOverDrawDraft()
	{
		return base.ReleaseParamValue * entity.GetWorld().BattleConfig.ratioOverDraft;
	}

	public override bool Check()
	{
		enoughCondition = false;
		if (isConsumeCondition)
		{
			if (string.Equals(propertyName, "Energy"))
			{
				CoolingComponent component = entity.GetComponent<CoolingComponent>();
				if (component != null && !component.OpenEnergyConsume)
				{
					enoughCondition = true;
					return enoughCondition;
				}
				if (overdraw == 1)
				{
					if (base.ReleaseParamValue <= 0f)
					{
						enoughCondition = true;
						return enoughCondition;
					}
					enoughCondition = entity.GetProperty(propertyName) > 0f;
					return enoughCondition;
				}
			}
			if (entity.GetProperty(propertyName) >= base.ReleaseParamValue)
			{
				enoughCondition = true;
				return enoughCondition;
			}
			return enoughCondition;
		}
		enoughCondition = ReleaseOption(entity.GetProperty(propertyName));
		return enoughCondition;
	}

	public override void Release()
	{
		if (string.Equals(propertyName, "Energy"))
		{
			CoolingComponent component = entity.GetComponent<CoolingComponent>();
			if (component != null && !component.OpenEnergyConsume)
			{
				return;
			}
		}
		entity.ChangeProperty(propertyName, 0f - base.ReleaseParamValue, isExecuteValueChanged: true, isIgnoreMin: true);
	}

	public override void Update()
	{
		if (propertyName != null)
		{
			base.CurrentParamValue = entity.Property[propertyName]?.CurValue ?? 0f;
		}
	}

	public override void Cultivate(CoolingBase coolingBase)
	{
		if (coolingBase.IsConsumeCondition == base.IsConsumeCondition && coolingBase is PropertyCooling propertyCooling)
		{
			if (string.Equals(propertyCooling.propertyName, propertyName))
			{
				base.ReleaseParamValue = Mathf.Clamp(base.ReleaseParamValue + propertyCooling.ReleaseParamValue, 0f, 9999f);
				initParamValue = base.ReleaseParamValue;
			}
			if (propertyCooling.overdraw == 1)
			{
				overdraw = 1;
			}
		}
	}

	public void SetPropertyValue(float value)
	{
		base.ReleaseParamValue = value;
	}

	public void RevisePropertyValue(float value)
	{
		base.ReleaseParamValue += value;
	}

	public void ResetPropertyValue()
	{
		base.ReleaseParamValue = initParamValue;
	}

	public override string NotEnoughConditionText(List<string> tipTexts)
	{
		if (!enoughCondition)
		{
			DRPropertyKeyName dataRow = GameEntry.DataTable.GetDataRow((DRPropertyKeyName p) => p.PropertyKey.Equals(propertyName));
			if (dataRow == null)
			{
				return propertyName;
			}
			if (!tipTexts.Contains(dataRow.PropertyName))
			{
				tipTexts.Add(dataRow.PropertyName);
				return dataRow.PropertyName;
			}
		}
		return string.Empty;
	}
}
