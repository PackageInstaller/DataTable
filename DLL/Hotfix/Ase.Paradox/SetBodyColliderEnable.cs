using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("设置主体碰撞盒开关", 0)]
public class SetBodyColliderEnable : ActionTaskBase
{
	[Name("实体ID", 0)]
	public BBParameter<int> entityId;

	[Name("开关", 0)]
	public bool enable;

	[Name("是否随行为树还原", 0)]
	public bool isFollowDispose;

	private BaseEntity entity;

	protected override void OnExecute()
	{
		base.OnExecute();
		entity = ownerEntity.GetSystem<EntitySystem>()?.GetEntity(entityId.value);
		if (entity == null)
		{
			OnActionFail($"实体为空 实体ID:{entityId.value}");
			return;
		}
		if (entity.IsSurvival)
		{
			entity.GetComponent<TransformComponent>()?.SetBodyColliderEnable(enable);
		}
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (isFollowDispose && ownerEntity != null && entity != null && entity.IsSurvival)
		{
			entity.GetComponent<TransformComponent>()?.SetBodyColliderEnable(!enable);
		}
	}
}
