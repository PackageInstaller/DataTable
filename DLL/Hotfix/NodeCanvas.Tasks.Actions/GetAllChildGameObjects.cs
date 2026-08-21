using System.Collections.Generic;
using System.Linq;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("GameObject")]
public class GetAllChildGameObjects : ActionTask<Transform>
{
	[BlackboardOnly]
	public BBParameter<List<GameObject>> saveAs;

	public bool recursive;

	protected override string info => string.Format("{0} = {1} Children Of {2}", saveAs, recursive ? "All" : "First", base.agentInfo);

	protected override void OnExecute()
	{
		List<Transform> list = new List<Transform>();
		foreach (Transform item in base.agent.transform)
		{
			list.Add(item);
			if (recursive)
			{
				list.AddRange(Get(item));
			}
		}
		saveAs.value = list.Select((Transform t) => t.gameObject).ToList();
		EndAction();
	}

	private List<Transform> Get(Transform parent)
	{
		List<Transform> list = new List<Transform>();
		foreach (Transform item in parent)
		{
			list.Add(item);
			list.AddRange(Get(item));
		}
		return list;
	}
}
