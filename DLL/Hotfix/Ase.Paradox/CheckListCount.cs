using System.Collections;
using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("检查列表数量", 0)]
[Category("✫ DragonLost/Movement")]
[Description("检查指定列表的数量是否满足特定条件。")]
public class CheckListCount : ConditionTaskBase
{
	[BlackboardOnly]
	[Name("列表", 0)]
	[Description("要检查数量的列表。")]
	public BBParameter<IList> valueA;

	[Name("比较方式", 0)]
	[Description("用于比较列表数量的方式。")]
	public CompareMethod checkType;

	[Name("目标数量", 0)]
	[Description("与列表数量进行比较的目标数量。")]
	public BBParameter<int> valueB;

	protected override string info => $"{valueA} {OperationTools.GetCompareString(checkType)} {valueB}";

	protected override bool OnCheck()
	{
		return OperationTools.Compare(valueA.value.Count, valueB.value, checkType);
	}
}
[Name("检查具体类型列表数量", 0)]
[Category("✫ DragonLost/Movement")]
[Description("检查指定列表的数量是否满足特定条件。")]
public class CheckListCount<T> : ConditionTaskBase
{
	[BlackboardOnly]
	[Name("列表", 0)]
	[Description("要检查数量的列表。")]
	public BBParameter<List<T>> valueA;

	[Name("比较方式", 0)]
	[Description("用于比较列表数量的方式。")]
	public CompareMethod checkType;

	[Name("目标数量", 0)]
	[Description("与列表数量进行比较的目标数量。")]
	public BBParameter<int> valueB;

	protected override string info => $"{valueA} {OperationTools.GetCompareString(checkType)} {valueB}";

	protected override bool OnCheck()
	{
		return OperationTools.Compare(valueA.value.Count, valueB.value, checkType);
	}
}
