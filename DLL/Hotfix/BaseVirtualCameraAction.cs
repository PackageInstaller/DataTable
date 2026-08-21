using Ase;
using Ase.ECS;
using ParadoxNotion.Design;

public abstract class BaseVirtualCameraAction : ActionTaskBase
{
	[ShowIf("IsUniqueBattleCameraCommand", false)]
	[Name("相机标签", 0)]
	[Description("要修改的虚拟相机的标签")]
	public CameraKey Key;

	protected abstract bool IsUniqueBattleCameraCommand { get; }

	protected bool IsCanCameraNode()
	{
		if (ownerEntity == null)
		{
			EndAction();
			return false;
		}
		if (ownerEntity.GetEntityType() == EntityType.HERO && ownerEntity.IsActorEntity)
		{
			return true;
		}
		if (ownerEntity.GetEntityType() == EntityType.MONSTER)
		{
			return true;
		}
		if (ownerEntity.GetEntityType() == EntityType.SummonedEntity && ownerEntity.Parent != null && ownerEntity.Parent is HeroEntity { IsActorEntity: not false })
		{
			return true;
		}
		EndAction();
		return false;
	}
}
