using System;
using UnityEngine;

namespace ACT.Config;

public class ComboChallengeConfigs : ScriptableObject
{
	[Serializable]
	public struct ComboChallengeMode
	{
		public int id;

		public ComboChallengeConfig config;
	}

	[SerializeField]
	private ComboChallengeMode[] _comboModeConfigs;

	public ComboChallengeMode[] ComboModeConfigs => _comboModeConfigs;
}
