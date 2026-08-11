using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取实体朝向偏移的坐标", 0)]
[Description("根据给定的实体、偏移角度和距离，计算出偏移后的位置坐标。")]
[Category("✫ DragonLost/EntityCalculateTool")]
public class AcquireEntityOffsetPositionAction : ActionTaskBase
{
	[RequiredField]
	[Name("偏移角度", 0)]
	[Description("与实体朝向的偏移角度。")]
	public BBParameter<float> Angle;

	[RequiredField]
	[Name("偏移距离", 0)]
	[Description("偏移的距离长度。")]
	public BBParameter<float> Distance;

	[RequiredField]
	[Name("实体Id", 0)]
	[Description("要计算偏移的实体的ID。")]
	public BBParameter<int> EntityId;

	[RequiredField]
	[Name("返回位置", 0)]
	[Description("计算得到的偏移后的位置坐标。")]
	public BBParameter<Vector3> Position;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(EntityId.value, isSyncEntity: false);
		if (entity == null)
		{
			EndAction();
			return;
		}
		Position.value = TSUtil.MoveForward2D(entity.transform.position, entity.transform.rotation.eulerAngles.y + Angle.value, Distance.value);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"获取实体朝向偏移的坐标  {Position.value}  entity.transform.position  {entity.transform.position}  entity.transform.rotation.eulerAngles.y {entity.transform.rotation.eulerAngles.y}" + $"Angle  {Angle.value}  Distance {Distance.value}  实体id {entity.Id}", ownerEntity);
		}
		EndAction();
	}
}
