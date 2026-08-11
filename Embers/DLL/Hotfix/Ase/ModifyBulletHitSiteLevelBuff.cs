using Ase.ECS;

namespace Ase;

public class ModifyBulletHitSiteLevelBuff : BuffOperationBase<BuffDataModifyBulletHitSiteLevel>
{
	private BulletModifySiteLevelData data;

	protected override void OnExecute()
	{
		BulletSystem system = base.buffOwner.GetSystem<BulletSystem>();
		if (system != null)
		{
			data = new BulletModifySiteLevelData
			{
				modifyEnum = BulletModifyEnum.All,
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
