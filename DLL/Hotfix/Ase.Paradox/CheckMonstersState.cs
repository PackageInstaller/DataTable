using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("多怪物状态判断", 0)]
[Category("✫ DragonLost/Monster")]
[Description("检查多个怪物的状态是否满足给定的状态。")]
public class CheckMonstersState : ConditionTaskBase
{
	[Name("怪物组ID", 0)]
	[Description("要检查状态的怪物实体的ID列表。")]
	public BBParameter<List<int>> monsterIds = new List<int>();

	[Name("多怪物的状态", 0)]
	[Description("要检查的怪物状态。")]
	public EntityState monsterState = EntityState.Dead;

	protected override bool OnCheck()
	{
		base.OnCheck();
		foreach (int item in monsterIds.value)
		{
			BaseEntity entity = GetEntity(item, isSyncEntity: false);
			if (entity != null && !entity.CheckEntityState(monsterState))
			{
				return false;
			}
		}
		return true;
	}
}
