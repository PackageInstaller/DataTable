using System;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0InterationSetEntityParent : T0InterationFunctionDataBase
{
	public enum FindTrsMode
	{
		FromEntity,
		FindInScene,
		ToT0ContentRoot,
		MainCamera
	}

	public bool stayWorldPosition;

	public int judgeEntityID;

	public FindTrsMode findTrsMode;

	public string root;

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		Transform transform = null;
		switch (findTrsMode)
		{
		case FindTrsMode.FromEntity:
			transform = T0WorldHelper.GetTrsByEntityID(judgeEntityID, ignoreMissing: true);
			break;
		case FindTrsMode.FindInScene:
		{
			GameObject gameObject = GameObject.Find(root);
			if ((bool)gameObject)
			{
				transform = gameObject.transform;
			}
			break;
		}
		case FindTrsMode.ToT0ContentRoot:
			transform = T0WorldScene.Scene.T0EntityContent;
			break;
		case FindTrsMode.MainCamera:
			transform = Camera.main.transform;
			break;
		}
		T0WorldHelper.GetTrsByEntityID(entityID).SetParent(transform, stayWorldPosition);
		base.IsFinish = true;
	}
}
