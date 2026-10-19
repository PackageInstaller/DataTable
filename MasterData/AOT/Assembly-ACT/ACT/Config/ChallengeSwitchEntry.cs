using System;
using ACT.World.Asset;
using UnityEngine;

namespace ACT.Config;

[Serializable]
public class ChallengeSwitchEntry
{
	[SerializeField]
	private ChallengeType _challengeType;

	[SerializeField]
	private YooAssetReference _switchModeAssetReference;

	public ChallengeType ChallengeType => _challengeType;

	public YooAssetReference SwitchModeAssetReference => _switchModeAssetReference;
}
