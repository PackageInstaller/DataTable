#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using Ase.ECS;
using GameFramework;

namespace Ase;

public class PropertyTargetLayerBuff : BuffOperationBase<BuffDataPropertyTargetLayer>, IObserverHandler
{
	private Dictionary<int, float> deltaDic = new Dictionary<int, float>();

	private List<BaseEntity> damageEntityList = new List<BaseEntity>();

	private List<BaseEntity> targetList;

	protected override void OnInit()
	{
		if (dataBase.teamType == EntityTeamType.DamageTarget)
		{
			base.buffOwner.GetSystem<BattleObserverSystem>().Attach(BattleObserverEventEnum.AttackBefore, this);
		}
	}

	public void OnNotify(IObserverParams param)
	{
		ObserverDamageProgressParams buffMessage = (ObserverDamageProgressParams)param;
		OnMessage(buffMessage);
	}

	private void OnMessage(ObserverDamageProgressParams buffMessage)
	{
		if (buffMessage.Defender == null || !buffMessage.Defender.IsSurvival || buffMessage.Attacker.Id != base.buffOwner.Id)
		{
			return;
		}
		for (int i = 0; i < damageEntityList.Count; i++)
		{
			if (damageEntityList[i].Id == buffMessage.Defender.Id)
			{
				return;
			}
		}
		damageEntityList.Add(buffMessage.Defender);
	}

	protected override void OnExecute()
	{
		targetList = BuffExtension.GetTargetByTeamTypeList(base.buffFrom, base.buffOwner, dataBase.teamType, damageEntityList);
		if (targetList == null)
		{
			return;
		}
		foreach (BaseEntity target in targetList)
		{
			OnAddition(target);
		}
	}

	private void OnAddition(BaseEntity target)
	{
		float num = 0f;
		float num2 = 0f;
		int num3 = 0;
		Buff buff = target.GetSystem<BuffSystem>().FindEntityBuff(target.Id, dataBase.buffId);
		if (buff != null)
		{
			num3 = buff.GetLayer();
		}
		if (num3 == 0)
		{
			return;
		}
		switch (dataBase.propertyType)
		{
		case PropertyType.Min:
			Log.Error("属性Buff 设置属性类型(min) 无效！");
			return;
		case PropertyType.Max:
			num2 = base.buffFrom.GetPropertyMax(dataBase.propertyKey);
			break;
		case PropertyType.Init:
			num2 = base.buffFrom.GetPropertyInit(dataBase.propertyKey);
			break;
		case PropertyType.Cur:
			num2 = base.buffFrom.GetPropertyBuff(dataBase.propertyKey, base.config.FinishClearOperations);
			break;
		}
		if (dataBase.changeType == ChangeType.Set || dataBase.changeType == ChangeType.Add || dataBase.changeType == ChangeType.Dec)
		{
			num = ((dataBase.changeType != ChangeType.Set) ? ((dataBase.changeType == ChangeType.Add) ? dataBase.propertyValue : (0f - dataBase.propertyValue)) : (dataBase.propertyValue - num2));
			if (base.config.LayerOverlying)
			{
				num *= (float)base.buff.GetLayer();
			}
			num *= (float)num3;
		}
		else if (dataBase.changeType == ChangeType.Mul)
		{
			num = num2 * dataBase.propertyValue - num2;
		}
		else
		{
			Log.Error($"属性Buff 无效的修改类型{dataBase.changeType}！");
		}
		deltaDic[target.Id] = num;
		switch (dataBase.propertyType)
		{
		case PropertyType.Min:
			Log.Error("属性Buff 设置属性类型(min) 无效！");
			break;
		case PropertyType.Max:
			base.buffFrom.SetPropertyMax(dataBase.propertyKey, num2 + num);
			break;
		case PropertyType.Init:
			base.buffFrom.SetPropertyInit(dataBase.propertyKey, num2 + num);
			break;
		case PropertyType.Cur:
			base.buffFrom.SetPropertyBuff(dataBase.propertyKey, num2 + num, isIgnoreMax: false, base.config.FinishClearOperations);
			break;
		}
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"Buff 307 设置实体属性,  BuffID：{base.config.Id} 加成BuffID：{dataBase.buffId} 层数:{num3} 当前总修改数值 {num}", base.buffFrom);
		}
		BattleProgressPropertyMonitor.RecordPropertyValue(base.buffFrom, dataBase.propertyKey, base.buffFrom.GetProperty(dataBase.propertyKey));
		OnRecordAddition(base.buffFrom, num);
	}

	protected override void OnDispose()
	{
		if (targetList == null)
		{
			return;
		}
		foreach (BaseEntity target in targetList)
		{
			OnClearAddition(target);
		}
	}

	private void OnClearAddition(BaseEntity target)
	{
		if (deltaDic.TryGetValue(target.Id, out var value))
		{
			float num = 0f;
			switch (dataBase.propertyType)
			{
			case PropertyType.Min:
				Log.Error("属性Buff 设置属性类型 1 (min) 无效！");
				return;
			case PropertyType.Max:
				num = base.buffFrom.GetPropertyMax(dataBase.propertyKey);
				break;
			case PropertyType.Init:
				num = base.buffFrom.GetPropertyInit(dataBase.propertyKey);
				break;
			case PropertyType.Cur:
				num = base.buffFrom.GetPropertyBuff(dataBase.propertyKey, base.config.FinishClearOperations);
				break;
			}
			switch (dataBase.propertyType)
			{
			case PropertyType.Min:
				Log.Error("属性Buff 设置属性类型 1 (min) 无效！");
				break;
			case PropertyType.Max:
				base.buffFrom.SetPropertyMax(dataBase.propertyKey, num - value);
				break;
			case PropertyType.Init:
				base.buffFrom.SetPropertyInit(dataBase.propertyKey, num - value);
				break;
			case PropertyType.Cur:
				base.buffFrom.SetPropertyBuff(dataBase.propertyKey, num - value, isIgnoreMax: false, base.config.FinishClearOperations);
				break;
			}
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance.WriteAuthorityEntityId($"Buff 307 清除实体属性,  buffId：{base.config.Id} 清除值 {value}", base.buffFrom);
			}
			deltaDic[target.Id] = 0f;
			OnRecordClearAddition(base.buffFrom);
		}
	}

	protected void OnRecordAddition(BaseEntity target, float delta)
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
		if (!base.buff.HasOperations || targetList == null)
		{
			return;
		}
		foreach (BaseEntity target in targetList)
		{
			OnClearAddition(target);
			OnAddition(target);
		}
	}

	protected override void OnClear()
	{
		base.buffOwner.GetSystem<BattleObserverSystem>().Detach(BattleObserverEventEnum.AttackBefore, this);
		deltaDic.Clear();
		damageEntityList.Clear();
		if (targetList != null)
		{
			targetList.Clear();
			targetList = null;
		}
	}
}
