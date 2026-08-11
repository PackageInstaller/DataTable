using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("GameObject")]
[Description("Find the closest game object of tag to the agent")]
public class FindClosestWithTag : ActionTask<Transform>
{
	[TagField]
	[RequiredField]
	public BBParameter<string> searchTag;

	public BBParameter<bool> ignoreChildren;

	[BlackboardOnly]
	public BBParameter<GameObject> saveObjectAs;

	[BlackboardOnly]
	public BBParameter<float> saveDistanceAs;

	protected override void OnExecute()
	{
		GameObject[] array = GameObject.FindGameObjectsWithTag(searchTag.value);
		if (array.Length == 0)
		{
			saveObjectAs.value = null;
			saveDistanceAs.value = 0f;
			EndAction(success: false);
			return;
		}
		GameObject value = null;
		float num = float.PositiveInfinity;
		GameObject[] array2 = array;
		foreach (GameObject gameObject in array2)
		{
			if (!(gameObject.transform == base.agent) && (!ignoreChildren.value || !gameObject.transform.IsChildOf(base.agent)))
			{
				float num2 = Vector3.Distance(gameObject.transform.position, base.agent.position);
				if (num2 < num)
				{
					num = num2;
					value = gameObject;
				}
			}
		}
		saveObjectAs.value = value;
		saveDistanceAs.value = num;
		EndAction();
	}
}
