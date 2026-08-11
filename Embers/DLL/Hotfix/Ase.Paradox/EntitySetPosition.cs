using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("实体设置位置", 0)]
[Description("根据传入的参数设置实体的位置和旋转。")]
[Category("✫ DragonLost/Entity")]
public class EntitySetPosition : ActionTaskBase
{
	[Name("偏移设置", 0)]
	[Description("是否在当前位置的基础上偏移。")]
	public bool offsetSet;

	[Name("设置坐标", 0)]
	[Description("是否设置实体的位置。")]
	public bool setPosition;

	[Name("位置", 0)]
	[Description("要设置的实体的目标位置。")]
	[ShowIf("setPosition", 1)]
	public BBParameter<Vector3> positionParam;

	[Name("设置旋转", 0)]
	[Description("是否设置实体的旋转。")]
	public bool setRotation;

	[Name("旋转", 0)]
	[Description("要设置的实体的目标旋转。")]
	[ShowIf("setRotation", 1)]
	public BBParameter<Vector3> rotationParam;

	protected override void OnExecute()
	{
		base.OnExecute();
		KinematicMoveComponent component = ownerEntity.GetComponent<KinematicMoveComponent>();
		if (component == null)
		{
			OnActionFail();
			return;
		}
		if (setPosition)
		{
			Vector3 position = positionParam.value;
			if (offsetSet)
			{
				position = ownerEntity.transform.position + positionParam.value;
			}
			component.SetPosition(position, "实体设置位置");
		}
		if (setRotation)
		{
			Vector3 euler = rotationParam.value;
			if (offsetSet)
			{
				euler = ownerEntity.transform.eulerAngles + rotationParam.value;
			}
			Quaternion rotation = Quaternion.Euler(euler);
			component.SetRotation(rotation, "实体设置位置");
		}
		OnActionFinish();
	}
}
