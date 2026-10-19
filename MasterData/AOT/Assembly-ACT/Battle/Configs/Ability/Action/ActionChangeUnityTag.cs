using ACT.Battle.Configs;
using Bamboo.ECS;
using UnityEngine;

namespace Battle.Configs.Ability.Action;

public class ActionChangeUnityTag : ConfigAction
{
	public string tag;

	public override void Do(ActionMemory memory)
	{
		GameObject root = memory.target.entity.GetRoot();
		if (root != null && !string.IsNullOrEmpty(tag))
		{
			SetTagRecursively(root.transform, tag);
		}
	}

	private static void SetTagRecursively(Transform rootTransform, string newTag)
	{
		rootTransform.gameObject.tag = newTag;
		for (int i = 0; i < rootTransform.childCount; i++)
		{
			SetTagRecursively(rootTransform.GetChild(i), newTag);
		}
	}
}
