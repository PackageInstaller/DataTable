using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("根据输入修改实体朝向", 0)]
[Description("根据输入的摇杆值修改实体的朝向。")]
[Category("✫ DragonLost/Entity")]
public class ChangeRotationByInput : ActionTaskBase
{
	[Name("摇杆输入值", 0)]
	[Description("摇杆的输入值，通常用来控制实体的移动方向。")]
	public BBParameter<Vector3> inputJoystick;

	protected override void OnExecute()
	{
		base.OnExecute();
		Vector3 velocity = new Vector3(inputJoystick.value.x, 0f, inputJoystick.value.y);
		ownerEntity.GetComponent<MoveComponent>().UpdateRotation(velocity);
		OnActionFinish();
	}
}
