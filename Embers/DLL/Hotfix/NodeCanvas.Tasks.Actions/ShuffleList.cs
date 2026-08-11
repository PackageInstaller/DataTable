using System.Collections;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("✫ Blackboard/Lists")]
public class ShuffleList : ActionTask
{
	[RequiredField]
	[BlackboardOnly]
	public BBParameter<IList> targetList;

	protected override void OnExecute()
	{
		IList value = targetList.value;
		for (int num = value.Count - 1; num > 0; num--)
		{
			int index = (int)Mathf.Floor(Random.value * (float)(num + 1));
			object value2 = value[num];
			value[num] = value[index];
			value[index] = value2;
		}
		EndAction();
	}
}
