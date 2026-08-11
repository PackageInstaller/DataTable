using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace NodeCanvas.Tasks.Conditions;

[Category("✫ Blackboard/Lists")]
public class TListIsEmpty<T> : ConditionTask
{
	[RequiredField]
	[BlackboardOnly]
	public BBParameter<List<T>> targetList;

	protected override string info => $"{targetList} Is Empty";

	protected override bool OnCheck()
	{
		BBParameter<List<T>> bBParameter = targetList;
		if (bBParameter == null)
		{
			return false;
		}
		return bBParameter.value.Count == 0;
	}
}
