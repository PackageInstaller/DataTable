using System.Collections.Generic;

namespace BilliardGame;

public static class BilliardGameAudioManager
{
	private const string BILLIARD_SHEET = "minigame_activity_4_3";

	public static Dictionary<int, string> enemyAtkDic_;

	public static void Init()
	{
		enemyAtkDic_ = new Dictionary<int, string>
		{
			[40301] = "minigame_activity_4_3_marble_monster02",
			[40302] = "minigame_activity_4_3_marble_monster01",
			[40303] = "minigame_activity_4_3_marble_monster03",
			[40304] = "minigame_activity_4_3_marble_monster04",
			[40305] = "minigame_activity_4_3_marble_monster06",
			[40306] = "minigame_activity_4_3_marble_monster07",
			[40307] = "minigame_activity_4_3_marble_monster09",
			[40308] = "minigame_activity_4_3_marble_monster08"
		};
	}

	public static void PlayAudioByName(string audioName)
	{
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", audioName, useStream: false);
	}

	public static void PlayEnemyAtkAudio(int enemyID)
	{
		if (enemyAtkDic_.ContainsKey(enemyID))
		{
			AudioManager.Instance.Play("effect", "minigame_activity_4_3", enemyAtkDic_[enemyID], useStream: false);
		}
	}

	public static void Dispose()
	{
		enemyAtkDic_.Clear();
		enemyAtkDic_ = null;
	}
}
