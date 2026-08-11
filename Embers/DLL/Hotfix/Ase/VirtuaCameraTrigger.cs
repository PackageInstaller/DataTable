using Ase.ECS;
using Cinemachine;
using UnityEngine;

namespace Ase;

[Trigger("虚拟相机触发器")]
public class VirtuaCameraTrigger : BaseTrigger
{
	public CinemachineVirtualCamera virtualCamera;

	public bool isActive = true;

	public bool lockHero = true;

	public bool followHero = true;

	public override string TriggerName => "虚拟相机触发器";

	protected override bool OpenAngleCheck => true;

	public override void Execute()
	{
		if (virtualCamera == null || sceneSystem == null)
		{
			return;
		}
		EntitySystem system = sceneSystem.GetSystem<EntitySystem>();
		if (system == null)
		{
			return;
		}
		WorldBase world = sceneSystem.GetWorld();
		if (world == null)
		{
			return;
		}
		BaseEntity entity = system.GetEntity(world.ActorId);
		if (entity == null)
		{
			return;
		}
		Transform transform = entity.GetEntityObject()?.transform;
		if (!(transform == null))
		{
			if (lockHero)
			{
				virtualCamera.m_LookAt = transform;
			}
			if (followHero)
			{
				virtualCamera.m_Follow = transform;
			}
			base.Execute();
		}
	}

	protected override void DoExecute()
	{
		base.DoExecute();
		if (isActive)
		{
			if ((bool)virtualCamera)
			{
				sceneSystem.GetSystem<VirtualCameraSystem>().EnqueueLevelTriggerVirtualCamera(virtualCamera, lockHero, followHero);
			}
		}
		else
		{
			sceneSystem.GetSystem<VirtualCameraSystem>().CloseLevelTriggerVirtualCamera();
		}
	}

	protected override void OnRestTrigger()
	{
		base.OnRestTrigger();
		if ((bool)virtualCamera && virtualCamera.gameObject.activeSelf)
		{
			sceneSystem.GetSystem<VirtualCameraSystem>().CloseLevelTriggerVirtualCamera();
		}
	}
}
