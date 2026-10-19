using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class AnimMoveControlConfig : IDataToBake
{
	[Range(0f, 1f)]
	public float progressRate;

	[HideInInspector]
	public float progressCheckRadius = 3f;

	[HideInInspector]
	public float failCheckRadius = 10f;

	public List<ProgressAction> progressActions = new List<ProgressAction>();

	public DoActionBases inProgress = new DoActionBases();

	public DoActionBases pauseProgress = new DoActionBases();

	public DoActionBases startRunning = new DoActionBases();

	public DoActionBases finish = new DoActionBases();

	public DoActionBases resetAciton = new DoActionBases();
}
