using System;
using System.Collections.Generic;
using Sirenix.OdinInspector;
using UnityEngine;

namespace Dorm.Character.Animation;

[ExecuteAlways]
[DisallowMultipleComponent]
public class AnimationClipCollectInfo : SerializedMonoBehaviour
{
	[Serializable]
	public class ActionInfo
	{
		public string name;

		public int nameHash;

		public ActionInfo(string name, int nameHash)
		{
			this.name = name;
			this.nameHash = nameHash;
		}
	}

	public Animator animator;

	public Dictionary<string, ActionInfo[]>[] clipIDs;

	public bool PickAnime(int layerIdx, string animeName, out ActionInfo pick)
	{
		if (layerIdx >= 0 && layerIdx < clipIDs.Length && clipIDs[layerIdx].TryGetValue(animeName, out var value))
		{
			pick = value[UnityEngine.Random.Range(0, value.Length)];
			return true;
		}
		pick = null;
		return false;
	}
}
