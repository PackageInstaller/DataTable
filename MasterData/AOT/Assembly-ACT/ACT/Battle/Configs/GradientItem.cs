using System;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public struct GradientItem
{
	public uint id;

	[GradientUsage(true)]
	public Gradient gradient;
}
