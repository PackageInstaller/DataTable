using System;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class WalkureAreaState
{
	[SerializeField]
	private int _stateId;

	[SerializeField]
	private float _runtTime;

	public int StateId => _stateId;

	public float RunTime => _runtTime;

	private bool CanConfigRunTime()
	{
		return StateId == 0;
	}
}
