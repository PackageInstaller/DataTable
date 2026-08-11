using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine.Scripting;

namespace NodeCanvas.Tasks.Actions;

[Category("✫ Blackboard/Lists")]
[Preserve]
public class AddElementToList<T> : ActionTask
{
	[RequiredField]
	[BlackboardOnly]
	public BBParameter<List<T>> targetList;

	public BBParameter<T> targetElement;

	protected override string info => $"Add {targetElement} In {targetList}";

	protected override void OnExecute()
	{
		targetList.value.Add(targetElement.value);
		EndAction();
	}
}
