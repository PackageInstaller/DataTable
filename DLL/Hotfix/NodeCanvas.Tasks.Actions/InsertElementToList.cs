using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine.Scripting;

namespace NodeCanvas.Tasks.Actions;

[Category("✫ Blackboard/Lists")]
[Preserve]
public class InsertElementToList<T> : ActionTask
{
	[RequiredField]
	[BlackboardOnly]
	public BBParameter<List<T>> targetList;

	public BBParameter<T> targetElement;

	public BBParameter<int> targetIndex;

	protected override string info => $"Insert {targetElement} in {targetList} at {targetIndex}";

	protected override void OnExecute()
	{
		int value = targetIndex.value;
		List<T> value2 = targetList.value;
		if (value < 0 || value >= value2.Count)
		{
			EndAction(success: false);
			return;
		}
		value2.Insert(value, targetElement.value);
		EndAction(success: true);
	}
}
