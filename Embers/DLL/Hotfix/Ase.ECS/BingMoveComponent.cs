using UnityEngine;

namespace Ase.ECS;

public class BingMoveComponent : BaseComponent
{
	private bool enable;

	private Vector3 offsetPos = Vector3.zero;

	private BaseEntity interEntity;

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		if (enable && interEntity != null)
		{
			mBaseEntity.GetComponent<KinematicMoveComponent>().SetPosition(interEntity.transform.position - offsetPos, "绑定实体移动");
		}
	}

	public void SetEnableComp(int entityId, bool isRotateForward)
	{
		if (enable)
		{
			CloseComp();
			return;
		}
		interEntity = base.Entity.GetSystem<EntitySystem>().GetEntity(entityId);
		if (interEntity != null)
		{
			offsetPos = interEntity.transform.position - base.transform.position;
			if (isRotateForward)
			{
				interEntity.GetComponent<EntityRotationComponent>()?.ImmediatelyRotate(mBaseEntity.transform.position);
			}
			interEntity.GetComponent<StateComponent>().AddState(4004, interEntity.Id);
			enable = true;
		}
	}

	public void CloseComp()
	{
		if (interEntity != null)
		{
			interEntity.GetComponent<StateComponent>().RemoveState(4004);
		}
		enable = false;
		interEntity = null;
		offsetPos = Vector3.zero;
	}

	public void EntityUnLoad()
	{
		if (enable)
		{
			CloseComp();
		}
	}
}
