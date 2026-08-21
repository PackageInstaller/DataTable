using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("召唤实体（疑似弃用）内部代码已被注释", 0)]
[Description("根据实体ID召唤实体，并选择是否将其加入到实体列表中。")]
[Category("✫ DragonLost/Entity")]
public class SummonEntityAction : ActionTaskBase
{
	[Name("实体Id", 0)]
	[Description("要召唤的实体ID列表")]
	public BBParameter<List<int>> entityIds;

	[Name("实体类型", 0)]
	[Description("要召唤的实体类型")]
	public EntityType entityType;

	[Name("是否加入到列表", 0)]
	[Description("指示召唤的实体是否要加入到实体列表中")]
	public bool add2List;

	[Name("实体列表", 0)]
	[ShowIf("add2List", 1)]
	[Description("用于存储召唤的实体的列表")]
	public BBParameter<List<BaseEntity>> entityList;

	protected override async void OnExecute()
	{
		base.OnExecute();
		OnActionFinish();
	}
}
