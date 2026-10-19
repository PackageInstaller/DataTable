using ACT.World.Asset;
using UnityEngine;

namespace ACT.Config;

[CreateAssetMenu(fileName = "ChallengeSwitchConfig", menuName = "ACT/Config/ChallengeSwitchConfig")]
public class ChallengeSwitchConfig : ScriptableObject
{
	[SerializeField]
	private ChallengeSwitchEntry[] _entries;

	public YooAssetReference GetSwitchModelGuid(ChallengeType type)
	{
		if (_entries == null)
		{
			return null;
		}
		ChallengeSwitchEntry[] entries = _entries;
		foreach (ChallengeSwitchEntry challengeSwitchEntry in entries)
		{
			if (challengeSwitchEntry.ChallengeType == type)
			{
				return challengeSwitchEntry.SwitchModeAssetReference;
			}
		}
		return null;
	}
}
