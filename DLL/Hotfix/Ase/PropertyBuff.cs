#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;

namespace Ase;

public class PropertyBuff : BuffOperationBase<BuffDataProperty>
{
	private float deltaVal;

	protected override void OnInit()
	{
		deltaVal = 0f;
	}

	protected override void OnExecute()
	{
		if (BattleFormulaUtility.CheckSpecialProperty(dataBase.propertyKey))
		{
			Log.Error("当前属性 (" + dataBase.propertyKey + ") 不能直接使用buff加成，应使用 (Fix" + dataBase.propertyKey + ")。请与数值策划沟通");
		}
		else
		{
			OnAddition();
		}
	}

	private void OnAddition()
	{
		float num = 0f;
		switch (dataBase.propertyType)
		{
		case PropertyType.Min:
			Log.Error("属性Buff 设置属性类型(min) 无效！");
			return;
		case PropertyType.Max:
			num = base.buffOwner.GetPropertyMax(dataBase.propertyKey);
			break;
		case PropertyType.Init:
			num = base.buffOwner.GetPropertyInit(dataBase.propertyKey);
			break;
		case PropertyType.Cur:
			num = base.buffOwner.GetPropertyBuff(dataBase.propertyKey, base.config.FinishClearOperations);
			break;
		}
		float num2 = 0f;
		if (dataBase.changeType == ChangeType.Set || dataBase.changeType == ChangeType.Add || dataBase.changeType == ChangeType.Dec)
		{
			num2 = ((dataBase.changeType != ChangeType.Set) ? ((dataBase.changeType == ChangeType.Add) ? dataBase.propertyValue : (0f - dataBase.propertyValue)) : (dataBase.propertyValue - num));
			if (base.config.LayerOverlying)
			{
				num2 *= (float)base.buff.GetLayer();
			}
		}
		else if (dataBase.changeType == ChangeType.Mul)
		{
			num2 = num * dataBase.propertyValue - num;
		}
		else
		{
			Log.Error($"属性Buff 无效的修改类型{dataBase.changeType}！");
		}
		switch (dataBase.propertyType)
		{
		case PropertyType.Min:
			Log.Error("属性Buff 设置属性类型(min) 无效！");
			break;
		case PropertyType.Max:
			base.buffOwner.SetPropertyMax(dataBase.propertyKey, num + num2);
			break;
		case PropertyType.Init:
			base.buffOwner.SetPropertyInit(dataBase.propertyKey, num + num2);
			break;
		case PropertyType.Cur:
			base.buffOwner.SetPropertyBuff(dataBase.propertyKey, num + num2, isIgnoreMax: false, base.config.FinishClearOperations);
			break;
		}
		deltaVal += num2;
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"Buff 3 设置实体属性,  buffId：{base.config.Id} 当前总修改数值 {deltaVal}", base.buffOwner);
		}
		if (base.buffId != 800559)
		{
			BattleProgressPropertyMonitor.RecordPropertyValue(base.buffOwner, dataBase.propertyKey, base.buffOwner.GetProperty(dataBase.propertyKey));
		}
		OnRecordAddition();
	}

	protected override void OnRecordOperation(string record)
	{
	}

	protected override void OnDispose()
	{
		OnClearAddition();
	}

	private void OnClearAddition()
	{
		float num = 0f;
		switch (dataBase.propertyType)
		{
		case PropertyType.Min:
			Log.Error("属性Buff 设置属性类型 1 (min) 无效！");
			return;
		case PropertyType.Max:
			num = base.buffOwner.GetPropertyMax(dataBase.propertyKey);
			break;
		case PropertyType.Init:
			num = base.buffOwner.GetPropertyInit(dataBase.propertyKey);
			break;
		case PropertyType.Cur:
			num = base.buffOwner.GetPropertyBuff(dataBase.propertyKey, base.config.FinishClearOperations);
			break;
		}
		switch (dataBase.propertyType)
		{
		case PropertyType.Min:
			Log.Error("属性Buff 设置属性类型 1 (min) 无效！");
			break;
		case PropertyType.Max:
			base.buffOwner.SetPropertyMax(dataBase.propertyKey, num - deltaVal);
			break;
		case PropertyType.Init:
			base.buffOwner.SetPropertyInit(dataBase.propertyKey, num - deltaVal);
			break;
		case PropertyType.Cur:
			base.buffOwner.SetPropertyBuff(dataBase.propertyKey, num - deltaVal);
			break;
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"Buff 3 清除实体属性,  buffId：{base.config.Id} 清除值 {deltaVal}", base.buffOwner);
		}
		_ = base.buffId;
		_ = 800559;
		deltaVal = 0f;
		OnRecordClearAddition();
	}

	protected void OnRecordAddition()
	{
	}

	protected void OnRecordClearAddition()
	{
	}

	protected override void OnUpdateLayerChanged(int deltaLayer)
	{
		base.OnUpdateLayerChanged(deltaLayer);
		if (base.buff.HasOperations)
		{
			OnClearAddition();
			OnAddition();
		}
	}

	protected override void OnClear()
	{
		deltaVal = 0f;
	}
}
