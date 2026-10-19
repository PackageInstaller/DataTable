using System;
using UnityEngine;

namespace ACT.Battle.Configs;

[Serializable]
public class ConfigAnimStateTransition
{
	public bool toStateMachine;

	public string stateName;

	[Tooltip("在sub state的entry transition中无效。\n勾选这个就会在结束时间之后满足条件退出\n不勾选这个就会在任意时间满足条件退出")]
	public bool hasExitTime;

	public float transitionExitPercent;

	[Tooltip("在sub state的entry transition中无效")]
	public float transitionOffset;

	[Tooltip("在sub state的entry transition中无效")]
	public float transitionDuration;

	public bool canTransitionToSelf;

	public ConfigAnimCondition[] conditions;
}
