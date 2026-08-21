using Ase.ECS;

namespace Ase;

public class ModifyBulletHitSiteLevelByConfigIdBuff : BuffOperationBase<BuffDataModifyBulletHitSiteLevelByConfigId>
{
	private BulletModifySiteLevelData data;

	protected override void OnExecute()
	{
		BulletSystem system = base.buffOwner.GetSystem<BulletSystem>();
		if (system != null)
		{
			data = new BulletModifySiteLevelData
			{
				modifyEnum = BulletModifyEnum.BulletID,
				bulletId = dataBase.bulletId,
				modifySiteLevelEnum = dataBase.modifySiteLevelEnum
			};
			system.AddModifySiteLevelData(base.buffOwner.Id, data);
		}
	}

	protected override void OnDispose()
	{
		if (data != null)
		{
			base.buffOwner.GetSystem<BulletSystem>()?.RemoveModifySiteLevelData(base.buffOwner.Id, data);
			data = null;
		}
	}
}
