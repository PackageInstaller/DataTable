using System;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0InterationActiveSceneObj : T0InterationFunctionDataBase
{
	public string objPath;

	public bool active;

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		GameObject gameObject = GameObject.Find(objPath);
		if ((bool)gameObject)
		{
			gameObject.SetActive(active);
		}
		base.IsFinish = true;
	}
}
