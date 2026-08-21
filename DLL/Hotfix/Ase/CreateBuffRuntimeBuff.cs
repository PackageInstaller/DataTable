using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class CreateBuffRuntimeBuff : BuffOperationBase<BuffDataCreateRuntimeBuff>
{
	protected override void OnExecute()
	{
		DRBuff dataRow = GameEntry.DataTable.GetDataRow<DRBuff>(dataBase.createRuntimeBuffId);
		if (dataRow == null)
		{
			return;
		}
		dataBase.buffConfig = dataRow;
		List<BuffConditionBase> triggerConditions = base.buff.GetTriggerConditions();
		if (triggerConditions == null || dataBase.conditionIndex >= triggerConditions.Count)
		{
			return;
		}
		BuffRuntimeDataBase runtimeData = triggerConditions[dataBase.conditionIndex].RuntimeData;
		base.buff.AddConditionRuntimeData(runtimeData);
		if (runtimeData != null)
		{
			BaseEntity conditonRuntimeTarget = BuffExtension.GetConditonRuntimeTarget(dataBase.runtimeEnum, base.buff, runtimeData);
			if (conditonRuntimeTarget != null)
			{
				conditonRuntimeTarget.GetSystem<BuffSystem>()?.CheckAndAcquireCreateTargetBuff(base.buffFrom, conditonRuntimeTarget, dataBase);
				OnRecordCreateBuff(conditonRuntimeTarget, dataRow.Id);
			}
		}
	}

	protected void OnRecordCreateBuff(BaseEntity target, int buffId)
	{
	}

	protected override void OnRecordOperation(string record)
	{
	}
}
