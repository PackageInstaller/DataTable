using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("修改运动开关", 0)]
[Description("修改指定实体的运动开关状态，包括移动和旋转。")]
[Category("✫ DragonLost/Entity")]
public class ChangeMoveEnable : ActionTaskBase
{
	[Name("移动开关", 0)]
	[Description("指定是否允许实体移动。")]
	public BBParameter<bool> moveEnable;

	[Name("旋转开关", 0)]
	[Description("指定是否允许实体旋转。")]
	public BBParameter<bool> rotateEnable = new BBParameter<bool>(value: true);

	protected override void OnExecute()
	{
		base.OnExecute();
		MoveComponent component = ownerEntity.GetComponent<MoveComponent>();
		if (component == null)
		{
			OnActionFail();
			return;
		}
		component.ChangeMovementEnable(moveEnable.value, rotateEnable.value);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"行为树开关移动状态 ： {moveEnable.value} 旋转状态 ：{rotateEnable.value} ", ownerEntity);
		}
		OnActionFinish();
	}
}
