using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("筛选列表中存活的实体", 0)]
[Description("从输入的实体列表中筛选出存活的实体，并将它们存储在返回的列表中。同时返回存活实体的数量。")]
[Category("✫ DragonLost/Entity")]
public class GetFilterSurvivalListAction : ActionTaskBase
{
	[Name("输入的实体列表", 0)]
	[Description("要进行筛选的实体ID列表。")]
	public BBParameter<List<int>> inputEntityIds = new BBParameter<List<int>>();

	[Name("返回的存活实体列表", 0)]
	[Description("存储筛选出的存活实体的ID列表。")]
	public BBParameter<List<int>> outputEntityIds = new BBParameter<List<int>>();

	[Name("存活数量", 0)]
	[Description("存活实体的数量。")]
	public BBParameter<int> survivalCount = new BBParameter<int>();

	[Space(8)]
	[Name("是否筛选", 0)]
	public bool isFilter;

	[ShowIf("isFilter", true)]
	[Name("筛选类型列表", 0)]
	public List<EntityType> entityTypeList = new List<EntityType>();

	protected override void OnExecute()
	{
		base.OnExecute();
		survivalCount.value = 0;
		if (inputEntityIds != null && !inputEntityIds.value.IsNullOrEmpty())
		{
			if (outputEntityIds == null)
			{
				outputEntityIds = new BBParameter<List<int>>();
			}
			outputEntityIds.value = new List<int>();
			if (isFilter)
			{
				if (entityTypeList.IsNullOrEmpty())
				{
					OnActionFail("节点[筛选列表中存活的实体] 筛选列表为空");
					return;
				}
				for (int i = 0; i < inputEntityIds.value.Count; i++)
				{
					BaseEntity entity = GetEntity(inputEntityIds.value[i], isSyncEntity: true);
					if (entity != null && entity.IsSurvival)
					{
						StateComponent component = entity.GetComponent<StateComponent>();
						if (component != null && !component.IsNearDeathState() && entityTypeList.Contains(entity.GetEntityType()))
						{
							outputEntityIds.value.Add(inputEntityIds.value[i]);
						}
					}
				}
			}
			else
			{
				for (int j = 0; j < inputEntityIds.value.Count; j++)
				{
					BaseEntity entity2 = GetEntity(inputEntityIds.value[j], isSyncEntity: true);
					if (entity2 != null && entity2.IsSurvival)
					{
						StateComponent component2 = entity2.GetComponent<StateComponent>();
						if (component2 != null && !component2.IsNearDeathState())
						{
							outputEntityIds.value.Add(inputEntityIds.value[j]);
						}
					}
				}
			}
		}
		survivalCount.value = outputEntityIds.value.Count;
		OnActionFinish();
	}
}
