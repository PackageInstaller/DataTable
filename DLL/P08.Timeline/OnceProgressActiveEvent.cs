using System;
using UnityEngine;

[Serializable]
public class OnceProgressActiveEvent
{
	public ECompareType compareType;

	public float percent;

	public bool isRepeat;

	public bool resetActive;

	public string goName;

	[NonSerialized]
	[HideInInspector]
	public bool hasTrigger;
}
