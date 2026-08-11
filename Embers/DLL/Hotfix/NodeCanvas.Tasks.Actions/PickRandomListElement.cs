using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.Scripting;

namespace NodeCanvas.Tasks.Actions;

[Category("✫ Blackboard/Lists")]
[Preserve]
public class PickRandomListElement<T> : ActionTask
{
	[RequiredField]
	public BBParameter<List<T>> targetList;

	public BBParameter<T> saveAs;

	protected override string info => $"{saveAs} = Random From {targetList}";

	protected override void OnExecute()
	{
		if (targetList.value.Count <= 0)
		{
			EndAction(success: false);
			return;
		}
		saveAs.value = targetList.value[Random.Range(0, targetList.value.Count)];
		EndAction(success: true);
	}
}
