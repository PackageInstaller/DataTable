using System;
using UnityEngine;

namespace ACT.Config;

[Serializable]
public abstract class Round
{
	[SerializeField]
	private float _roundTime;

	[SerializeField]
	private float _startIntervalTime;

	[SerializeField]
	private float _endIntervalTime;

	public float RoundTime => _roundTime;

	public float StartIntervalTime => _startIntervalTime;

	public float EndIntervalTime => _endIntervalTime;
}
