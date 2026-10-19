using System;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public class ConfigEndureLevel
{
	public float start;

	public float end;

	public ConfigMotionFrameRange frameRange;

	[Tooltip("动作值，小于动作值的受击，不触发受击")]
	public EndureType endureLevel;
}
