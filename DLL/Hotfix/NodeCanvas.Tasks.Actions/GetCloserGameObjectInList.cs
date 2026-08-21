using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("✫ Blackboard/Lists")]
[Description("Get the closer game object to the agent from within a list of game objects and save it in the blackboard.")]
public class GetCloserGameObjectInList : ActionTask<Transform>
{
	[RequiredField]
	public BBParameter<List<GameObject>> list;

	[BlackboardOnly]
	public BBParameter<GameObject> saveAs;

	protected override string info => "Get Closer from '" + list?.ToString() + "' as " + saveAs;

	protected override void OnExecute()
	{
		if (list.value.Count == 0)
		{
			EndAction(success: false);
			return;
		}
		float num = float.PositiveInfinity;
		GameObject value = null;
		foreach (GameObject item in list.value)
		{
			float num2 = Vector3.Distance(base.agent.position, item.transform.position);
			if (num2 < num)
			{
				num = num2;
				value = item;
			}
		}
		saveAs.value = value;
		EndAction(success: true);
	}
}
