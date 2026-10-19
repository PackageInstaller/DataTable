using System;
using ACT.Core;

namespace ACT.Battle.Configs;

[Serializable]
public struct PropertyItem
{
	public uint id;

	public PropertyCalculate cal;

	public int descriptCommon;

	public RoundingFunction rounding;
}
