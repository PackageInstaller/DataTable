using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取某段距离", 0)]
[Description("根据给定的实体或者位置点，获取两者之间的距离。")]
[Category("✫ DragonLost/EntityCalculateTool")]
public class AcquireDistanceAction : ActionTaskBase
{
	private EntitySystem _entitySystem;

	[Name("返回的距离", 0)]
	[Description("计算得到的距离值。")]
	public BBParameter<float> Distance;

	[RequiredField]
	[HideIf("PositionType", 1)]
	[Name("实体一号", 0)]
	[Description("用于计算距离的第一个实体的ID。")]
	public BBParameter<int> EntityIdOne;

	[RequiredField]
	[ShowIf("PositionType", 0)]
	[Name("实体二号", 0)]
	[Description("用于计算距离的第二个实体的ID。")]
	public BBParameter<int> EntityIdTwo;

	[RequiredField]
	[HideIf("PositionType", 0)]
	[Name("位置一号", 0)]
	[Description("用于计算距离的第一个位置点。")]
	public BBParameter<Vector3> PointOne;

	[RequiredField]
	[ShowIf("PositionType", 1)]
	[Name("位置二号", 0)]
	[Description("用于计算距离的第二个位置点。")]
	public BBParameter<Vector3> PointTwo;

	[Name("位置类型", 0)]
	[Description("选择是基于实体位置、位置点还是二者之间任选其一的距离计算方式。")]
	public DistancePositionType PositionType;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (PositionType == DistancePositionType.EntityPosition || PositionType == DistancePositionType.EntityOrPoint)
		{
			_entitySystem = ownerEntity.GetSystem<EntitySystem>();
		}
		if (PositionType == DistancePositionType.Point)
		{
			Distance.value = Vector3.Distance(PointTwo.value, PointOne.value);
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance?.WriteAuthorityEntityId($"获取某段距离 DistancePositionType PointTwo {PointTwo.value}  PointOne  {PointOne.value}", ownerEntity);
			}
		}
		else if (PositionType == DistancePositionType.EntityPosition)
		{
			BaseEntity entity = GetEntity(EntityIdTwo.value, isSyncEntity: true);
			BaseEntity entity2 = GetEntity(EntityIdOne.value, isSyncEntity: true);
			if (entity == null || entity2 == null)
			{
				EndAction();
				return;
			}
			Distance.value = Vector3.Distance(entity.transform.position, entity2.transform.position);
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance?.WriteAuthorityEntityId($"获取某段距离 entity2 {entity.transform.position}  entity1  {entity2.transform.position}", ownerEntity);
			}
		}
		else
		{
			BaseEntity entity3 = GetEntity(EntityIdOne.value, isSyncEntity: true);
			if (entity3 == null)
			{
				EndAction();
				return;
			}
			Distance.value = Vector3.Distance(entity3.transform.position, PointOne.value);
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance?.WriteAuthorityEntityId($"获取某段距离 PointOne {PointOne.value}  entity1  {entity3.transform.position}", ownerEntity);
			}
		}
		EndAction();
	}
}
