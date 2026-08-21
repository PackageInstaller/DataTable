using Ase.ECS;

namespace Ase;

public class ModifyBulletConfigBuffBuff : BuffOperationBase<BuffDataModifyBulletConfigBuff>
{
	private BulletChangeBuffData data;

	protected override void OnExecute()
	{
		BulletSystem system = base.buffOwner.GetSystem<BulletSystem>();
		if (system != null)
		{
			data = new BulletChangeBuffData();
			data.entityId = base.buffOwner.Id;
			data.modifyEnum = dataBase.modifyEnum;
			data.changeType = dataBase.changeType;
			if (dataBase.modifyEnum == BulletModifyEnum.BulletID)
			{
				data.bulletId = Utility.Convert.StringToInt(dataBase.key);
			}
			else if (dataBase.modifyEnum == BulletModifyEnum.BulletLabel)
			{
				data.bulletLabel = dataBase.key;
			}
			data.buffList = dataBase.buffList.ToList();
			data.targetList = dataBase.targetList.ToList();
			system.AddChangeBuffData(base.buffOwner.Id, data);
		}
	}

	protected override void OnDispose()
	{
		if (data != null)
		{
			base.buffOwner.GetSystem<BulletSystem>()?.RemoveChangeBuffData(base.buffOwner.Id, data);
		}
	}

	protected override void OnClear()
	{
		data = null;
	}
}
