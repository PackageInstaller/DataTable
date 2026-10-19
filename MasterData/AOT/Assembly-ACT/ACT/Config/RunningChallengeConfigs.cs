using System;
using UnityEngine;

namespace ACT.Config;

public class RunningChallengeConfigs : ScriptableObject
{
	[Serializable]
	public struct RunningChallengeMode
	{
		public int id;

		public RunningChallengeConfig config;
	}

	[SerializeField]
	private RunningChallengeMode[] _runningModeConfigs;

	public RunningChallengeMode[] RunningModeConfigs => _runningModeConfigs;
}
