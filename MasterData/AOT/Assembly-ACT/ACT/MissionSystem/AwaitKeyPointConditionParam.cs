using System;
using UnityEngine;

namespace ACT.MissionSystem;

[Serializable]
public class AwaitKeyPointConditionParam
{
	public int keyPoint;

	[Header("取反(若没有该KeyPoint则条件达成)")]
	public bool reverseResult;
}
