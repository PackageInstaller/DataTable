using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("添加碰撞忽略层级", 0)]
[Description("将指定的碰撞层级添加到角色移动组件的忽略列表中，使其不再受碰撞影响。")]
[Category("✫ DragonLost/Collider")]
public class AddIgnoredColliderLayer : ActionTaskBase
{
	[Name("碰撞层级", 0)]
	[Description("要添加到角色移动组件的忽略列表中的碰撞层级。")]
	public BBParameter<CollisionSetting.CollisionLayer> colliderLayer;

	[Tooltip("该行为树运行结束后，是否将添加的忽略层级自动移除。")]
	[Name("结束时重置", 0)]
	[Description("指示在行为树运行结束时，是否将添加的碰撞层级自动从忽略列表中移除。")]
	public bool stopReset = true;

	private KinematicMoveComponent moveComponent;

	protected override void OnExecute()
	{
		base.OnExecute();
		moveComponent = ownerEntity.GetComponent<KinematicMoveComponent>();
		if (moveComponent == null)
		{
			OnActionFail();
			return;
		}
		moveComponent.AddIgnoredLayer(colliderLayer.value);
		OnActionFinish();
	}

	protected override void OnGraphStop()
	{
		if (stopReset && moveComponent != null)
		{
			moveComponent.RemoveIgnoredLayer(colliderLayer.value);
		}
	}
}
