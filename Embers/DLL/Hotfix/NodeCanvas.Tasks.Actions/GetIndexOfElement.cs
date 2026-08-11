using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine.Scripting;

namespace NodeCanvas.Tasks.Actions;

[Category("✫ Blackboard/Lists")]
[Preserve]
public class GetIndexOfElement<T> : ActionTask
{
	[RequiredField]
	[BlackboardOnly]
	public BBParameter<List<T>> targetList;

	public BBParameter<T> targetElement;

	[BlackboardOnly]
	public BBParameter<int> saveIndexAs;

	protected override void OnExecute()
	{
		saveIndexAs.value = targetList.value.IndexOf(targetElement.value);
		EndAction(success: true);
	}
}
