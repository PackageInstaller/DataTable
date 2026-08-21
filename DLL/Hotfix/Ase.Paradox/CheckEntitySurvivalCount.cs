using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("检查列表中实体存活数量", 0)]
[Category("✫ DragonLost/Movement")]
[Description("检查给定实体ID列表中存活实体的数量是否满足指定条件。")]
public class CheckEntitySurvivalCount : ConditionTaskBase
{
	[BlackboardOnly]
	[Name("实体ID列表", 0)]
	[Description("存储实体ID列表的黑板参数。")]
	public BBParameter<List<int>> valueA;

	[Name("比较方式", 0)]
	[Description("要比较的实体存活数量。")]
	public CompareMethod checkType;

	[Name("比较值", 0)]
	[Description("用于比较的值。")]
	public BBParameter<int> valueB;

	protected override string info => $"{valueA} {OperationTools.GetCompareString(checkType)} {valueB}";

	protected override bool OnCheck()
	{
		int num = 0;
		if (valueA.value == null)
		{
			return OperationTools.Compare(num, valueB.value, checkType);
		}
		foreach (int item in valueA.value)
		{
			BaseEntity entity = GetEntity(item, isSyncEntity: true);
			if (entity != null && entity.IsSurvival)
			{
				num++;
			}
		}
		return OperationTools.Compare(num, valueB.value, checkType);
	}
}
