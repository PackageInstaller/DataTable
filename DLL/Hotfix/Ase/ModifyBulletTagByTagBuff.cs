using Ase.ECS;

namespace Ase;

public class ModifyBulletTagByTagBuff : BuffOperationBase<BuffDataModifyBulletTagByTag>
{
	protected BulletChangeTagData data;

	protected override void OnExecute()
	{
		if (!dataBase.checkTagList.IsNullOrEmpty() && !dataBase.modifyTagList.IsNullOrEmpty())
		{
			BulletSystem system = base.buffOwner.GetSystem<BulletSystem>();
			if (system != null)
			{
				BulletChangeTagData bulletChangeTagData = new BulletChangeTagData
				{
					entityId = base.buffOwner.Id,
					checkTagList = dataBase.checkTagList,
					changeType = dataBase.changeType,
					modifyTagList = dataBase.modifyTagList
				};
				system.AddChangeTagData(base.buffOwner.Id, bulletChangeTagData);
			}
		}
	}

	protected override void OnDispose()
	{
		if (data != null)
		{
			base.buffOwner.GetSystem<BulletSystem>()?.RemoveChangeTagData(base.buffOwner.Id, data);
			data = null;
		}
	}
}
