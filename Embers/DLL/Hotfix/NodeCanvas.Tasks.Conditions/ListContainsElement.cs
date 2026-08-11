using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine.Scripting;

namespace NodeCanvas.Tasks.Conditions;

[Category("✫ Blackboard/Lists")]
[Description("Check if an element is contained in the target list")]
[Preserve]
public class ListContainsElement<T> : ConditionTask
{
	[RequiredField]
	[BlackboardOnly]
	public BBParameter<List<T>> targetList;

	public BBParameter<T> checkElement;

	protected override string info => targetList?.ToString() + " contains " + checkElement;

	protected override bool OnCheck()
	{
		return targetList.value.Contains(checkElement.value);
	}
}
