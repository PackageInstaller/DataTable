using System;
using UnityEngine;

namespace ACT.Config;

[Serializable]
public class RandomRound : Round
{
	[SerializeField]
	private int _randomCount = 1;

	[SerializeField]
	private BreakPointData[] _randomBreakPoints;

	public int RandomCount => _randomCount;

	public BreakPointData[] RandomBreakPoints => _randomBreakPoints;
}
