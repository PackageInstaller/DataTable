using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("移除碰撞忽略层级", 0)]
[Description("移除指定的碰撞忽略层级，使实体不再忽略与该层级的碰撞检测。")]
[Category("✫ DragonLost/Collider")]
public class RemoveIgnoredColliderLayer : ActionTaskBase
{
	[Name("碰撞层级", 0)]
	[Description("要移除的碰撞忽略层级。")]
	public BBParameter<CollisionSetting.CollisionLayer> colliderLayer;

	protected override void OnExecute()
	{
		base.OnExecute();
		KinematicMoveComponent component = ownerEntity.GetComponent<KinematicMoveComponent>();
		if (component == null)
		{
			OnActionFail();
			return;
		}
		component.RemoveIgnoredLayer(colliderLayer.value);
		OnActionFinish();
	}
}
