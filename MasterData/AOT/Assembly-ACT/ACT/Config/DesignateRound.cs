using System;
using UnityEngine;

namespace ACT.Config;

[Serializable]
public class DesignateRound : Round
{
	[SerializeField]
	private BreakPointData[] _breakPoints;

	public BreakPointData[] BreakPoints => _breakPoints;
}
