using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("GameObject")]
[Description("Note that this is very slow")]
public class FindObjectOfType<T> : ActionTask where T : Component
{
	[BlackboardOnly]
	public BBParameter<T> saveComponentAs;

	[BlackboardOnly]
	public BBParameter<GameObject> saveGameObjectAs;

	protected override void OnExecute()
	{
		T val = Object.FindObjectOfType<T>();
		if (val != null)
		{
			saveComponentAs.value = val;
			saveGameObjectAs.value = val.gameObject;
			EndAction(success: true);
		}
		else
		{
			EndAction(success: false);
		}
	}
}
