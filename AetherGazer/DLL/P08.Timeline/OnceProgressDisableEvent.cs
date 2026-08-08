using System;
using UnityEngine;

[Serializable]
public class OnceProgressDisableEvent
{
	public ECompareType compareType;

	public float percent;

	public bool isRepeat;

	public string goName;

	[NonSerialized]
	[HideInInspector]
	public bool hasTrigger;
}
