#define ENABLE_ERROR_AND_ABOVE_LOG
using Ase.ECS;
using GameFramework;
using UnityEngine;

namespace Ase;

public class PropertyConvertBuff : BuffOperationBase<BuffDataPropertyConvert>, IPropertyChanged
{
	private float deltaVal;

	private float baseMainValue;

	private Ase.ECS.PropertyData mainProperty;

	private Ase.ECS.PropertyData deputyProperty;

	protected override void OnInit()
	{
		mainProperty = base.buffOwner.GetPropertyData(dataBase.mainPropertyKey);
		if (mainProperty == null)
		{
			Log.Error($"buff 305 未找到主属性 {dataBase.mainPropertyKey} buff id : {base.buffId}");
			return;
		}
		deputyProperty = base.buffOwner.GetPropertyData(dataBase.deputyPropertyKey);
		if (deputyProperty == null)
		{
			Log.Error($"buff 305 未找到副属性  {dataBase.deputyPropertyKey} buff id : {base.buffId}");
			return;
		}
		baseMainValue = 0f;
		deltaVal = 0f;
		mainProperty.RegisterOnChangedCallback(this);
	}

	public void OnPropertyChanged(string propertyName, PropertyChangedEnum changedEnum, float delta)
	{
		if (propertyName != dataBase.mainPropertyKey)
		{
			return;
		}
		switch (changedEnum)
		{
		case PropertyChangedEnum.MinValue:
		case PropertyChangedEnum.BuffValue:
			return;
		case PropertyChangedEnum.CurValue:
			if (dataBase.mainPropertyType != PropertyType.Cur)
			{
				return;
			}
			break;
		}
		if (changedEnum != PropertyChangedEnum.MaxValue || dataBase.mainPropertyType == PropertyType.Max)
		{
			OnConvert();
		}
	}

	private void OnConvert()
	{
		float f = 0f;
		switch (dataBase.mainPropertyType)
		{
		case PropertyType.Max:
			f = Mathf.Clamp(mainProperty.MaxValue, dataBase.min, dataBase.max);
			break;
		case PropertyType.Cur:
			f = Mathf.Clamp(mainProperty.CurValue, dataBase.min, dataBase.max);
			break;
		}
		f = Mathf.CeilToInt(f);
		f -= baseMainValue;
		float num = f * dataBase.value - deltaVal;
		switch (dataBase.deputyPropertyType)
		{
		case PropertyType.Max:
			deputyProperty.ResetMax(deputyProperty.MaxValue + num);
			break;
		case PropertyType.Cur:
			if (base.config.FinishClearOperations)
			{
				deputyProperty.AdditionBuff(num, isIgnoreMax: false);
			}
			else
			{
				deputyProperty.Addition(num, isIgnoreMax: false);
			}
			break;
		default:
			Log.Error($"buff 305 副属性类型不支持 buff id : {base.buffId}");
			return;
		}
		deltaVal += num;
		OnRecordAddition(base.buffOwner, num);
	}

	protected override void OnExecute()
	{
		if (BattleFormulaUtility.CheckSpecialProperty(dataBase.mainPropertyKey))
		{
			Log.Error("当前属性 (" + dataBase.mainPropertyKey + ") 不能直接使用buff加成，应使用 (Fix" + dataBase.mainPropertyKey + ")。请与数值策划沟通");
		}
		else
		{
			OnConvert();
		}
	}

	protected override void OnDispose()
	{
		OnClearAddition();
	}

	private void OnClearAddition()
	{
		switch (dataBase.deputyPropertyType)
		{
		case PropertyType.Max:
			deputyProperty.ResetMax(deputyProperty.MaxValue - deltaVal);
			break;
		case PropertyType.Cur:
			if (base.config.FinishClearOperations)
			{
				deputyProperty.AdditionBuff(0f - deltaVal, isIgnoreMax: false);
			}
			else
			{
				deputyProperty.Addition(0f - deltaVal, isIgnoreMax: false);
			}
			break;
		}
		OnRecordClearAddition(base.buffOwner);
	}

	protected void OnRecordAddition(BaseEntity target, float value)
	{
	}

	protected void OnRecordClearAddition(BaseEntity target)
	{
	}

	protected override void OnRecordOperation(string record)
	{
	}

	protected override void OnClear()
	{
		deltaVal = 0f;
		if (mainProperty != null)
		{
			mainProperty.RemoveOnChangedCallback(this);
		}
		mainProperty = null;
		deputyProperty = null;
	}
}
