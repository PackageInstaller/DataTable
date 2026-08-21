using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取实体列表中指定类型的目标实体", 0)]
[Description("获取实体列表中指定类型的目标实体，并返回实体列表ID")]
[Category("✫ DragonLost/Entity")]
public class GetTargetEntitysByList : ActionTaskBase
{
	[Name("实体ID", 0)]
	public BBParameter<List<int>> EntityList;

	[Name("实体类型", 0)]
	public EntityType entityType;

	[ShowIf("entityType", 2)]
	[Name("是否是Boss", 0)]
	public bool isBoss;

	[Name("返回的实体ID列表", 0)]
	public BBParameter<List<int>> TargetEntityList;

	[Name("返回的实体ID数量", 0)]
	public BBParameter<int> TargetEntityCount;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (TargetEntityList == null)
		{
			TargetEntityList = new BBParameter<List<int>>();
			TargetEntityList.value = new List<int>();
		}
		if (TargetEntityCount == null)
		{
			TargetEntityCount = new BBParameter<int>();
		}
		if (EntityList == null || EntityList.value.IsNullOrEmpty())
		{
			EndAction();
			return;
		}
		EntitySystem system = ownerEntity.GetSystem<EntitySystem>();
		if (system == null)
		{
			EndAction();
			return;
		}
		foreach (int item in EntityList.value)
		{
			BaseEntity entity = system.GetEntity(item);
			if (entity != null && entity.GetEntityType() == entityType && (!(entity is MonsterEntity monsterEntity) || monsterEntity.IsBoss == isBoss))
			{
				TargetEntityList.value.Add(item);
			}
		}
		TargetEntityCount.value = TargetEntityList.value.Count;
		EndAction();
	}
}
