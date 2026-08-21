using Ase.ECS;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("等待实体朝向目标结束", 0)]
[Description("等待实体朝向目标方向结束")]
[Category("✫ DragonLost/Transform")]
public class WaitLookTargetFinish : ActionTaskBase
{
	private EntityRotationComponent rotationComponent;

	protected override void OnExecute()
	{
		base.OnExecute();
		rotationComponent = ownerEntity.GetComponent<EntityRotationComponent>();
		if (rotationComponent == null)
		{
			OnActionFail();
		}
	}

	protected override void OnUpdate()
	{
		if (rotationComponent.RotationFinish)
		{
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance?.WriteAuthorityEntityId("等待实体朝向目标结束 ", ownerEntity);
			}
			OnActionFinish();
		}
	}
}
