using Ase.ECS;

namespace Ase;

public class ModifyBulletAdditionByTagBuff : BuffOperationBase<BuffDataModifyBulletAdditionByTag>
{
	protected BulletChangeAdditionData data;

	protected override void OnExecute()
	{
		if (dataBase.additionEnum == BulletAdditionEnum.DamageRadio)
		{
			if (dataBase.modifyValueList.IsNullOrEmpty())
			{
				LogWarning("修改值为空");
				return;
			}
			data = new BulletChangeAdditionData
			{
				entityId = base.buffOwner.Id,
				checkTagList = dataBase.checkTagList,
				changeType = dataBase.changeType,
				modifyAdditionEnum = dataBase.additionEnum,
				modifyValues = dataBase.modifyValueList
			};
			base.buffOwner.GetSystem<BulletSystem>()?.AddChangeAdditionData(base.buffOwner.Id, data);
		}
	}

	protected override void OnDispose()
	{
		if (data != null)
		{
			base.buffOwner.GetSystem<BulletSystem>()?.RemoveChangeAdditionData(base.buffOwner.Id, data);
		}
	}

	protected override void OnClear()
	{
		data = null;
	}
}
