using System;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public struct ColorItem
{
	public uint id;

	[ColorUsage(true, true)]
	public Color color;
}
