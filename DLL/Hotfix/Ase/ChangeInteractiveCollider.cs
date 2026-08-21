using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase;

[Name("打开关闭交互物碰撞", 0)]
[Description("根据指定的状态打开或关闭交互物体的碰撞。")]
[Category("✫ DragonLost/Interactive")]
public class ChangeInteractiveCollider : ActionTaskBase
{
	[Name("打开或者关闭", 0)]
	[Description("指示是否要打开（true）或关闭（false）交互物体的碰撞。")]
	public BBParameter<bool> isOpen;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity baseEntity = GetOwnerEntity();
		if (baseEntity != null && baseEntity.IsInteractiveEntity)
		{
			(GetOwnerEntity()?.GetComponent<EntityViewComponent>()?.EntityView as InteractiveView)?.ChangeColloderCollision(isOpen.value);
		}
		OnActionFinish();
	}
}
