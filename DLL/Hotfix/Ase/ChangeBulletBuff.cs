using Ase.ECS;

namespace Ase;

public class ChangeBulletBuff : BuffOperationBase<BuffDataChangeBullet>, IPredicate<BulletEntity>
{
	protected override void OnExecute()
	{
		BulletEntity bulletEntity = base.buffOwner.GetSystem<EntitySystem>().FindEntity(this);
		if (bulletEntity != null)
		{
			base.buffOwner.GetSystem<BulletSystem>().CopyBulletEntity(base.buffOwner, bulletEntity, dataBase.changedId);
			bulletEntity.DoEntityDead();
		}
	}

	public bool Predicate(BulletEntity bullet)
	{
		if (bullet.Parent == base.buffOwner)
		{
			return bullet.EntityId == dataBase.bulletId;
		}
		return false;
	}
}
