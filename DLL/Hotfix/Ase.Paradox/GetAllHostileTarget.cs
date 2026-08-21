using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine.Pool;

namespace Ase.Paradox;

[Name("获取所有敌对目标", 0)]
[Description("获取当前实体的所有敌对目标，并存储在指定的列表中。")]
[Category("✫ DragonLost/Target")]
public class GetAllHostileTarget : ActionTaskBase
{
	[Name("敌对列表", 0)]
	[Description("存储敌对目标的列表。")]
	public BBParameter<List<BaseEntity>> targetList;

	protected override void OnExecute()
	{
		base.OnExecute();
		List<BaseEntity> list = ownerEntity.GetSystem<EntitySystem>().FindAllRelationEntities(ownerEntity);
		if (list.Count <= 0)
		{
			OnActionFinish();
			return;
		}
		targetList.value.Clear();
		targetList.value.AddRange(list);
		CollectionPool<List<BaseEntity>, BaseEntity>.Release(list);
		OnActionFinish();
	}
}
