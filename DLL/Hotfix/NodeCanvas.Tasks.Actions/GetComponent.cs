using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("GameObject")]
public class GetComponent<T> : ActionTask<Transform> where T : Component
{
	[BlackboardOnly]
	public BBParameter<T> saveAs;

	protected override string info => $"Get {typeof(T).Name} as {saveAs.ToString()}";

	protected override void OnExecute()
	{
		T component = base.agent.GetComponent<T>();
		saveAs.value = component;
		EndAction(component != null);
	}
}
