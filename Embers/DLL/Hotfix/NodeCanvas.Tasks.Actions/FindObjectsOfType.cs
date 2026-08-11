using System.Collections.Generic;
using System.Linq;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("GameObject")]
[Description("Note that this is very slow")]
public class FindObjectsOfType<T> : ActionTask where T : Component
{
	[BlackboardOnly]
	public BBParameter<List<GameObject>> saveGameObjects;

	[BlackboardOnly]
	public BBParameter<List<T>> saveComponents;

	protected override void OnExecute()
	{
		T[] array = Object.FindObjectsOfType<T>();
		if (array != null && array.Length != 0)
		{
			saveGameObjects.value = array.Select((T o) => o.gameObject).ToList();
			saveComponents.value = array.ToList();
			EndAction(success: true);
		}
		else
		{
			EndAction(success: false);
		}
	}
}
