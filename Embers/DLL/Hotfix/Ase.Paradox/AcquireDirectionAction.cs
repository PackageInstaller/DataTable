using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取某个方向", 0)]
[Description("根据给定的实体或者位置点，获取方向向量。")]
[Category("✫ DragonLost/EntityCalculateTool")]
public class AcquireDirectionAction : ActionTaskBase
{
	public enum PositionType
	{
		EntityPosition,
		Point
	}

	[Name("位置类型", 0)]
	[Description("选择是基于实体位置还是基于给定点的位置。")]
	public PositionType positionType;

	[RequiredField]
	[ShowIf("positionType", 0)]
	[Name("实体一号", 0)]
	[Description("用于计算方向的第一个实体的ID。")]
	public BBParameter<int> EntityIdOne;

	[RequiredField]
	[ShowIf("positionType", 0)]
	[Name("实体二号", 0)]
	[Description("用于计算方向的第二个实体的ID。")]
	public BBParameter<int> EntityIdTwo;

	[RequiredField]
	[ShowIf("positionType", 1)]
	[Name("位置一号", 0)]
	[Description("用于计算方向的第一个位置点。")]
	public BBParameter<Vector3> PointOne;

	[RequiredField]
	[ShowIf("positionType", 1)]
	[Name("位置二号", 0)]
	[Description("用于计算方向的第二个位置点。")]
	public BBParameter<Vector3> PointTwo;

	[Name("返回的方向", 0)]
	[Description("计算得到的方向向量。")]
	public BBParameter<Vector3> Direction;

	private EntitySystem _entitySystem;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (positionType == PositionType.EntityPosition)
		{
			_entitySystem = ownerEntity.GetSystem<EntitySystem>();
		}
		if (positionType == PositionType.Point)
		{
			Direction.value = (PointTwo.value - PointOne.value).normalized;
		}
		else
		{
			BaseEntity entity = _entitySystem.GetEntity(EntityIdTwo.value);
			BaseEntity entity2 = _entitySystem.GetEntity(EntityIdOne.value);
			if (entity != null && entity2 != null)
			{
				Direction.value = (entity.transform.position - entity2.transform.position).normalized;
			}
		}
		EndAction();
	}
}
