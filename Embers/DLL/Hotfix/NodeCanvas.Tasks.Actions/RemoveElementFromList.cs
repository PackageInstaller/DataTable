using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine.Scripting;

namespace NodeCanvas.Tasks.Actions;

[Category("✫ Blackboard/Lists")]
[Description("Remove an element from the target list")]
[Preserve]
public class RemoveElementFromList<T> : ActionTask
{
	[RequiredField]
	[BlackboardOnly]
	public BBParameter<List<T>> targetList;

	public BBParameter<T> targetElement;

	protected override string info => $"Remove {targetElement} From {targetList}";

	protected override void OnExecute()
	{
		targetList.value.Remove(targetElement.value);
		EndAction(success: true);
	}
}
