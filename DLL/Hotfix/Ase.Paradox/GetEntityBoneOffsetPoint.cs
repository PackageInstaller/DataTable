using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取实体绑点位置偏移后的坐标", 0)]
[Category("✫ DragonLost/Entity")]
[Description("获取实体绑点位置偏移后的世界坐标。")]
public class GetEntityBoneOffsetPoint : ActionTaskBase
{
	[Name("实体ID", 0)]
	public BBParameter<int> entityId;

	[Name("位置偏移量", 0)]
	public BBParameter<Vector3> offset;

	[Name("返回的世界坐标", 0)]
	public BBParameter<Vector3> position;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity baseEntity = ownerEntity?.GetSystem<EntitySystem>()?.GetEntity(entityId.value);
		if (baseEntity == null)
		{
			EndAction();
			return;
		}
		Vector3 vector = TSUtil.TransformPoint(Vector3.zero, baseEntity.transform.eulerAngles, baseEntity.transform.localScale, offset.value);
		position.value = (baseEntity.transform.position + vector).FloorRound();
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance.WriteAuthorityEntityId($"获取实体绑点位置偏移后的坐标, 实体位置：{baseEntity.transform.position}," + $"实体角度：{baseEntity.transform.eulerAngles}," + $"偏移位置：{vector}," + $"最终位置：{position.value}", baseEntity);
		}
		EndAction();
	}
}
