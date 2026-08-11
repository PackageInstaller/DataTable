using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("GameObject")]
public class RemoveComponent<T> : ActionTask<Transform> where T : Component
{
	[Tooltip("DestroyImmediately is recomended if you are destroying objects in use of the framework.")]
	public bool immediately;

	protected override string info => $"Remove '{typeof(T).Name}'";

	protected override void OnExecute()
	{
		T component = base.agent.GetComponent<T>();
		if (component != null)
		{
			if (immediately)
			{
				Object.DestroyImmediate(component);
			}
			else
			{
				Object.Destroy(component);
			}
			EndAction(success: true);
		}
		else
		{
			EndAction(success: false);
		}
	}
}
