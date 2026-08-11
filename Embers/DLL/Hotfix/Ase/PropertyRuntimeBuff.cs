#define ENABLE_ERROR_AND_ABOVE_LOG
using Ase.ECS;
using GameFramework;
using UnityEngine;

namespace Ase;

public class PropertyRuntimeBuff : BuffOperationBase<BuffDataPropertyRuntime>
{
	private float deltaVal;

	private BaseEntity from;

	private BaseEntity target;

	protected override void OnExecute()
	{
		from = BuffExtension.GetConditonRuntimeTarget(dataBase.modifyFromRuntimeEnum, base.buff, base.buff.ConditionRuntimeData);
		if (from == null)
		{
			Log.Error($"buff {(int)dataBase.EffectType} 错误，未找到属性参照者实体");
			return;
		}
		target = BuffExtension.GetConditonRuntimeTarget(dataBase.modifyToRuntimeEnum, base.buff, base.buff.ConditionRuntimeData);
		if (target == null)
		{
			Log.Error($"buff {(int)dataBase.EffectType} 错误，未找到属性添加者实体");
		}
		else if (dataBase.product <= 0f)
		{
			Log.Error($"修改乘积错误:{dataBase.product}");
		}
		else
		{
			OnAddition(from, target);
		}
	}

	private void OnAddition(BaseEntity from, BaseEntity target)
	{
		float property = BattleFormulaUtility.GetProperty(from, dataBase.modifyFromPropertykey, dataBase.modifyFromPropertyType);
		property = Mathf.Min(property, dataBase.limitMax);
		property = Mathf.CeilToInt(property);
		property = Mathf.CeilToInt(property / dataBase.product);
		float propertyValue = GetPropertyValue(target, dataBase.modifyToPropertykey, dataBase.modifyToPropertyType, base.config.FinishClearOperations);
		float num = GetModifyDeltaByFrom(dataBase.changeType, dataBase.numberType, property, dataBase.value);
		if (base.config.LayerOverlying)
		{
			num *= (float)base.buff.GetLayer();
		}
		deltaVal += num;
		switch (dataBase.modifyToPropertyType)
		{
		case PropertyType.Min:
			Log.Error("属性Buff 设置属性类型(min) 无效！");
			break;
		case PropertyType.Max:
			this.target.SetPropertyMax(dataBase.modifyToPropertykey, propertyValue + num);
			break;
		case PropertyType.Init:
			this.target.SetPropertyInit(dataBase.modifyToPropertykey, propertyValue + num);
			break;
		case PropertyType.Cur:
			this.target.SetPropertyBuff(dataBase.modifyToPropertykey, propertyValue + num, isIgnoreMax: false, base.config.FinishClearOperations);
			break;
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"Buff 304 设置实体属性,  buffId：{base.config.Id} 当前总修改数值 {deltaVal}", target);
		}
		BattleProgressPropertyMonitor.RecordPropertyValue(target, dataBase.modifyToPropertykey, target.GetProperty(dataBase.modifyToPropertykey));
		OnRecordAddition(target);
	}

	private float GetPropertyValue(BaseEntity entity, string propertyKey, PropertyType propertyType, bool isClearEffect)
	{
		if (entity == null)
		{
			return 0f;
		}
		switch (propertyType)
		{
		case PropertyType.Min:
			Log.Error("属性Buff 设置属性类型(min) 无效！");
			return entity.GetPropertyMin(propertyKey);
		case PropertyType.Max:
			return entity.GetPropertyMax(propertyKey);
		case PropertyType.Init:
			return entity.GetPropertyInit(propertyKey);
		case PropertyType.Cur:
			return entity.GetPropertyBuff(propertyKey, isClearEffect);
		default:
			return 0f;
		}
	}

	private float GetModifyDeltaByFrom(ChangeType changeType, NumberType numType, float origin, float modify)
	{
		modify *= origin;
		if (numType == NumberType.Factor)
		{
			modify *= 0.01f;
		}
		return changeType switch
		{
			ChangeType.Set => modify - origin, 
			ChangeType.Add => modify, 
			ChangeType.Dec => 0f - modify, 
			ChangeType.Mul => modify * origin - origin, 
			ChangeType.Div => modify / origin - origin, 
			_ => 0f, 
		};
	}

	protected override void OnDispose()
	{
		OnClearAddition(target);
	}

	private void OnClearAddition(BaseEntity target)
	{
		float propertyValue = GetPropertyValue(target, dataBase.modifyToPropertykey, dataBase.modifyToPropertyType, base.config.FinishClearOperations);
		switch (dataBase.modifyToPropertyType)
		{
		case PropertyType.Min:
			Log.Error("属性Buff 设置属性类型 1 (min) 无效！");
			break;
		case PropertyType.Max:
			target.SetPropertyMax(dataBase.modifyToPropertykey, propertyValue - deltaVal);
			break;
		case PropertyType.Init:
			target.SetPropertyInit(dataBase.modifyToPropertykey, propertyValue - deltaVal);
			break;
		case PropertyType.Cur:
			target.SetPropertyBuff(dataBase.modifyToPropertykey, propertyValue - deltaVal);
			break;
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"Buff 304 清除实体属性,  buffId：{base.config.Id} 清除值 {deltaVal}", target);
		}
		deltaVal = 0f;
		OnRecordClearAddition(target);
	}

	protected void OnRecordAddition(BaseEntity target)
	{
	}

	protected void OnRecordClearAddition(BaseEntity target)
	{
	}

	protected override void OnRecordOperation(string record)
	{
	}

	protected override void OnUpdateLayerChanged(int deltaLayer)
	{
		base.OnUpdateLayerChanged(deltaLayer);
		if (base.buff.HasOperations)
		{
			OnClearAddition(target);
			OnAddition(from, target);
		}
	}

	protected override void OnClear()
	{
		deltaVal = 0f;
		from = null;
		target = null;
	}
}
