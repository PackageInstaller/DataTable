using System;
using UnityEngine;

namespace ACT.Config;

public class BreakChallengeConfigs : ScriptableObject
{
	[Serializable]
	public struct BreakChallengeMode
	{
		public int id;

		public BreakChallengeConfig config;
	}

	[SerializeField]
	private BreakChallengeMode[] _BreakModeConfigs;

	public BreakChallengeMode[] BreakModeConfigs => _BreakModeConfigs;
}
