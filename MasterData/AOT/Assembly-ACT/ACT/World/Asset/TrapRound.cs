using System;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public abstract class TrapRound
{
	[SerializeField]
	[Header("出现的落雷个数最小值")]
	private int _countMin;

	[SerializeField]
	[Header("出现的落雷个数最大值")]
	private int _countMax;

	[SerializeField]
	[Header("间隔时间最小值")]
	private float _intervalTimeMin;

	[SerializeField]
	[Header("间隔时间最大值")]
	private float _intervalTimeMax;

	public int GetRandomCount()
	{
		if (_countMin >= _countMax)
		{
			return _countMin;
		}
		return UnityEngine.Random.Range(_countMin, _countMax + 1);
	}

	public float GetRandomIntervalTime()
	{
		if (_intervalTimeMin >= _intervalTimeMax)
		{
			return _intervalTimeMin;
		}
		return UnityEngine.Random.Range(_intervalTimeMin, _intervalTimeMax);
	}
}
