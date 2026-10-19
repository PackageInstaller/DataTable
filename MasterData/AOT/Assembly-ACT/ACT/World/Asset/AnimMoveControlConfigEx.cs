using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class AnimMoveControlConfigEx : IDataToBake
{
	[Range(0f, 1f)]
	public float captureUpRate;

	[Range(0f, 1f)]
	public float captureDownRate;

	[Range(0f, 1f)]
	public float dangerRange;

	[Range(0f, 1f)]
	public float routeAnimSpeed;

	[Range(0f, 1f)]
	public float speedChangeRange;

	public float speedChangeDuration;

	[HideInInspector]
	public float captureCheckRadius = 3f;

	[HideInInspector]
	public Bounds[] failCheckBounds;

	public List<ProgressAction> progressActions = new List<ProgressAction>();

	public DoActionBases inProgress = new DoActionBases();

	public DoActionBases pauseProgress = new DoActionBases();

	public DoActionBases startRunning = new DoActionBases();

	public DoActionBases success = new DoActionBases();

	public DoActionBases resetAciton = new DoActionBases();
}
