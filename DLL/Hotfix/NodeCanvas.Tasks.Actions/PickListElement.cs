using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine.Scripting;

namespace NodeCanvas.Tasks.Actions;

[Category("✫ Blackboard/Lists")]
[Preserve]
public class PickListElement<T> : ActionTask
{
	[RequiredField]
	[BlackboardOnly]
	public BBParameter<List<T>> targetList;

	public BBParameter<int> index;

	[BlackboardOnly]
	public BBParameter<T> saveAs;

	protected override string info => $"{saveAs} = {targetList} [{index}]";

	protected override void OnExecute()
	{
		if (index.value < 0 || index.value >= targetList.value.Count)
		{
			EndAction(success: false);
			return;
		}
		saveAs.value = targetList.value[index.value];
		EndAction(success: true);
	}
}
