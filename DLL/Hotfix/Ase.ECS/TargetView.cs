namespace Ase.ECS;

public class TargetView : EntityView
{
	private EntityBoneComponent boneComponent;

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		boneComponent = mBaseEntity.GetComponent<EntityBoneComponent>();
		if (boneComponent != null && base.transform.TryGetComponent<EntityBoneView>(out var component))
		{
			boneComponent.RegisterBonePointData(base.transform, component.boneList);
		}
	}

	public override void OnAwake(object data = null)
	{
	}
}
