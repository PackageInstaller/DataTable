using System;
using System.Collections.Generic;
using UnityEngine;

[DisallowMultipleComponent]
public class DormCommonInteractionAnimationLibrary : MonoBehaviour
{
	[Serializable]
	public class Entry
	{
		public DormCommonInteractionAnimationType actionType;

		public GameObject timelinePrefab;
	}

	public GameObject idleShowTimelinePrefab;

	[Space]
	public GameObject catchTimelinePrefab;

	public GameObject idleTimelinePrefab;

	[Space]
	public GameObject openTimelinePrefab;

	[Space]
	public GameObject closeTimelinePrefab;

	[Space]
	public List<Entry> entries = new List<Entry>();

	public GameObject GetAnimationTimeline(DormCommonInteractionAnimationType animationType)
	{
		if (entries == null)
		{
			return null;
		}
		for (int i = 0; i < entries.Count; i++)
		{
			if (entries.get_Item(i) != null && entries.get_Item(i).actionType == animationType)
			{
				return entries.get_Item(i).timelinePrefab;
			}
		}
		return null;
	}
}
