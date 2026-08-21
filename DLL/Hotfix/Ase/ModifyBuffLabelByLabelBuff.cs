namespace Ase;

public class ModifyBuffLabelByLabelBuff : BuffOperationBase<BuffDataModifyBuffLabelByLabel>
{
	protected BuffChangeLabelData data;

	protected override void OnExecute()
	{
		if (!dataBase.checkLabelList.IsNullOrEmpty() && !dataBase.modifyLabelList.IsNullOrEmpty())
		{
			BuffSystem system = base.buffOwner.GetSystem<BuffSystem>();
			if (system != null)
			{
				data = new BuffChangeLabelData
				{
					entityId = base.buffOwner.Id,
					checkLabelList = dataBase.checkLabelList,
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
