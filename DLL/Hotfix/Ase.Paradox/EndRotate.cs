using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("朝向结束", 0)]
[Description("结束实体的朝向动作。")]
[Category("✫ DragonLost/Transform")]
public class EndRotate : ActionTaskBase
{
	[Name("实体ID", 0)]
	[Description("要结束朝向动作的实体的ID。")]
	public BBParameter<int> EntityId;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(EntityId.value, isSyncEntity: false);
		if (entity == null)
		{
			EndAction();
			return;
		}
		entity.GetComponent<EntityRotationComponent>().OnEndRotation();
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId("朝向结束", ownerEntity);
		}
		EndAction();
	}
}
