#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;

namespace Ase;

public class PropertyViceIgnoreBindBuff : BuffOperationBase<BuffDataPropertyViceIgnoreBind>
{
	private float deltaVal;

	protected override void OnExecute()
	{
		float num = 0f;
		float num2 = 0f;
		float num3 = 0f;
		switch (dataBase.vicePropertyType)
		{
		case PropertyType.Min:
			num2 = 0f;
			break;
		case PropertyType.Max:
			num2 = dataBase.ratio * base.buffOwner.GetPropertyMax(dataBase.vicePropertyKey);
			break;
		case PropertyType.Init:
			num2 = dataBase.ratio * base.buffOwner.GetPropertyInit(dataBase.vicePropertyKey);
			break;
		case PropertyType.Cur:
			num2 = dataBase.ratio * base.buffOwner.GetPropertyBuff(dataBase.vicePropertyKey, base.config.FinishClearOperations);
			break;
		}
		switch (dataBase.propertyType)
		{
		case PropertyType.Min:
			Log.Error("属性Buff 设置属性类型 1 (min) 无效！");
			break;
		case PropertyType.Max:
			num3 = base.buffOwner.GetPropertyMax(dataBase.propertyKey);
			break;
		case PropertyType.Init:
			num3 = base.buffOwner.GetPropertyInit(dataBase.propertyKey);
			break;
		case PropertyType.Cur:
			num3 = base.buffOwner.GetPropertyBuff(dataBase.propertyKey, base.config.FinishClearOperations);
			break;
		}
		num = ((dataBase.changeType != ChangeType.Set) ? ((dataBase.changeType == ChangeType.Add) ? num2 : (0f - num2)) : (num2 - num3));
		if (base.config.LayerOverlying)
		{
			num *= (float)base.buff.GetLayer();
		}
		deltaVal += num;
		switch (dataBase.propertyType)
		{
		case PropertyType.Min:
			Log.Error("属性Buff 设置属性类型 1 (min) 无效！");
			break;
		case PropertyType.Max:
			base.buffOwner.SetPropertyMax(dataBase.propertyKey, num3 + num);
			break;
		case PropertyType.Init:
			base.buffOwner.SetPropertyInit(dataBase.propertyKey, num3 + num);
			break;
		case PropertyType.Cur:
			base.buffOwner.SetPropertyBuff(dataBase.propertyKey, num3 + num, isIgnoreMax: false, base.config.FinishClearOperations, isExcuteValueChanged: false);
			break;
		}
		if (dataBase.clearVice)
		{
			base.buffOwner.SetPropertyBuff(dataBase.vicePropertyKey, 0f, isIgnoreMax: false, base.config.FinishClearOperations);
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"Buff 13 通过副属性修改属性,  buffId：{base.config.Id} 当前总修改数值 {deltaVal}", base.buffOwner);
		}
	}

	protected override void OnDispose()
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
			base.buffOwner.SetPropertyBuff(dataBase.propertyKey, num - deltaVal, isIgnoreMax: false, base.config.FinishClearOperations, isExcuteValueChanged: false);
			break;
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"Buff 13 清除通过副属性修改属性,  buffId：{base.config.Id} 清除值 {deltaVal}", base.buffOwner);
		}
	}

	protected override void OnClear()
	{
		deltaVal = 0f;
	}
}
