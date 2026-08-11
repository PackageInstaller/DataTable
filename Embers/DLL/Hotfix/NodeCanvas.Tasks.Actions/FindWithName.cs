using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("GameObject")]
public class FindWithName : ActionTask
{
	[RequiredField]
	public BBParameter<string> gameObjectName;

	[BlackboardOnly]
	public BBParameter<GameObject> saveAs;

	protected override string info => "Find Object " + gameObjectName?.ToString() + " as " + saveAs;

	protected override void OnExecute()
	{
		saveAs.value = GameObject.Find(gameObjectName.value);
		EndAction();
	}
}
