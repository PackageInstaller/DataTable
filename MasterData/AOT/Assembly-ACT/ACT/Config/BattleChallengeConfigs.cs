using System;
using UnityEngine;

namespace ACT.Config;

public class BattleChallengeConfigs : ScriptableObject
{
	[Serializable]
	public struct BattleChallengeMode
	{
		public int id;

		public BattleChallengeConfig config;
	}

	[SerializeField]
	private BattleChallengeMode[] _battleModeConfigs;

	public BattleChallengeMode[] BattleModeConfigs => _battleModeConfigs;
}
