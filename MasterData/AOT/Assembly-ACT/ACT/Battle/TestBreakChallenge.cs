using ACT.Config;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class TestBreakChallenge : MonoBehaviour
{
	public BreakChallengeConfig config;

	public void StartChallenge()
	{
		if (config != null)
		{
			Singleton<BreakChallengeManager>.instance.StartChallenge(1, transform);
		}
	}

	public void StopChallenge()
	{
		Singleton<BreakChallengeManager>.instance.StopChallenge(success: false);
	}
}
