using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine.Pool;

namespace Ase.Paradox;

[Name("获取目标阵营的所有实体", 0)]
[Description("根据指定的关系类型，获取目标阵营的所有实体，并将它们添加到目标列表中。")]
[Category("✫ DragonLost/Target")]
public class FindAllRelationEntities : ActionTaskBase
{
	[Name("目标列表", 0)]
	[Description("存储找到的目标实体的列表。")]
	public BBParameter<List<int>> targetIdList;

	[Name("关系类型", 0)]
	[Description("要查找的关系类型。")]
	public RelationTypeEnum RelationTypeEnum;

	[Name("是否附加到列表", 0)]
	[Description("如果为 true，则找到的实体将被添加到现有列表中；否则，列表将被清空。")]
	public bool isAttach;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (!isAttach)
		{
			targetIdList.value.Clear();
		}
		if (RelationTypeEnum == RelationTypeEnum.Self)
		{
			targetIdList.value.Add(ownerEntity.Id);
		}
		else
		{
			List<BaseEntity> list = ownerEntity.GetSystem<EntitySystem>().FindAllRelationEntities(ownerEntity, RelationTypeEnum);
			if (list.Count <= 0)
			{
				OnActionFinish();
				return;
			}
			for (int i = 0; i < list.Count; i++)
			{
				targetIdList.value.Add(list[i].Id);
			}
			CollectionPool<List<BaseEntity>, BaseEntity>.Release(list);
		}
		OnActionFinish();
	}
}
