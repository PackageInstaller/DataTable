using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取实体列表中最近或最远的实体", 0)]
[Description("从给定的实体列表中获取与目标实体最近或最远的实体。")]
[Category("✫ DragonLost/Entity")]
public class GetEntityByDistance : ActionTaskBase
{
	[Name("返回的实体ID", 0)]
	[Description("存储获取到的最近或最远实体的ID。")]
	public BBParameter<int> entityId;

	[Name("实体列表", 0)]
	[Description("用于搜索最近或最远实体的实体列表。")]
	public BBParameter<List<int>> entityIdList;

	[Name("最近", 0)]
	[Description("选择是否获取最近的实体。如果为True，则获取最近的实体，否则获取最远的实体。")]
	public bool isNearset;

	[Name("目标实体", 0)]
	[Description("用于比较距离的目标实体。")]
	public BBParameter<int> targetEntityId;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (entityIdList == null || entityIdList.value == null)
		{
			OnActionFail("用于搜索最近或最远实体的实体列表为 null");
			return;
		}
		BaseEntity entity = GetEntity(targetEntityId.value, isSyncEntity: true);
		if (isNearset)
		{
			float num = float.MaxValue;
			BaseEntity baseEntity = null;
			foreach (int item in entityIdList.value)
			{
				BaseEntity entity2 = GetEntity(item, isSyncEntity: true);
				if (entity != null && entity2 != null)
				{
					float num2 = Vector3.SqrMagnitude(entity2.transform.position - entity.transform.position);
					if (num2 < num)
					{
						baseEntity = entity2;
						num = num2;
					}
				}
			}
			entityId.value = baseEntity?.Id ?? 0;
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance?.WriteAuthorityEntityId($"获取实体列表中最近或最远的实体 {entityId.value}", ownerEntity);
			}
		}
		else
		{
			float num3 = float.MinValue;
			BaseEntity baseEntity2 = null;
			foreach (int item2 in entityIdList.value)
			{
				BaseEntity entity3 = GetEntity(item2, isSyncEntity: true);
				if (entity != null && entity3 != null)
				{
					float num4 = Vector3.SqrMagnitude(entity3.transform.position - entity.transform.position);
					if (num4 > num3)
					{
						baseEntity2 = entity3;
						num3 = num4;
					}
				}
			}
			entityId.value = baseEntity2?.Id ?? 0;
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance?.WriteAuthorityEntityId($"获取实体列表中最近或最远的实体 {entityId.value}", ownerEntity);
			}
		}
		EndAction();
	}
}
