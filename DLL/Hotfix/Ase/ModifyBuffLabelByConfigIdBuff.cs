namespace Ase;

public class ModifyBuffLabelByConfigIdBuff : BuffOperationBase<BuffDataModifyBuffLabelByConfigId>
{
	protected BuffChangeLabelData data;

	protected override void OnExecute()
	{
		if (!dataBase.checkConfigIdList.IsNullOrEmpty() && !dataBase.modifyLabelList.IsNullOrEmpty())
		{
			BuffSystem system = base.buffOwner.GetSystem<BuffSystem>();
			if (system != null)
			{
				data = new BuffChangeLabelData
				{
					entityId = base.buffOwner.Id,
					checkConfigIdList = dataBase.checkConfigIdList,
					changeType = dataBase.changeType,
					modifyLabelList = dataBase.modifyLabelList
				};
				system.AddChangeBuffLabelData(base.buffOwner.Id, data);
			}
		}
	}

	protected override void OnDispose()
	{
		if (data != null)
		{
			base.buffOwner.GetSystem<BuffSystem>()?.RemoveChangeBuffLabelData(base.buffOwner.Id, data);
		}
	}

	protected override void OnClear()
	{
		data = null;
	}
}
