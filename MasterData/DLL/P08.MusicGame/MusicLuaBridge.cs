using MusicGame;
using UnityEngine.UI;

public class MusicLuaBridge
{
	public static void Launcher(MusicDataForExchange musicDataForExchange)
	{
		NScene.Load<MusicSceneLoader>().SetGameConfig(musicDataForExchange);
	}

	public static void StartMusicGame()
	{
		(NScene.GetCurrentScene() as MusicSceneLoader)?.StartMusicGame();
	}

	public static void PauseMusicGame()
	{
		(NScene.GetCurrentScene() as MusicSceneLoader)?.PauseMusicGame();
	}

	public static void ResumeMusicGame()
	{
		(NScene.GetCurrentScene() as MusicSceneLoader)?.ResumeMusicGame();
	}

	public static void EndMusicGame()
	{
		(NScene.GetCurrentScene() as MusicSceneLoader)?.EndMusicGame();
	}

	public static void ReStartMusicGame()
	{
		(NScene.GetCurrentScene() as MusicSceneLoader)?.ReStartMusicGame();
	}

	public static string GetCurrentState()
	{
		return (NScene.GetCurrentScene() as MusicSceneLoader)?.GetCurrentState();
	}

	public static CriAtomSource GetMusicPlay()
	{
		return (NScene.GetCurrentScene() as MusicSceneLoader)?.GetMusicPlay();
	}

	public static int GetCurTime()
	{
		MusicSceneLoader musicSceneLoader = NScene.GetCurrentScene() as MusicSceneLoader;
		if (!(musicSceneLoader != null))
		{
			return 0;
		}
		return musicSceneLoader.GetCurTime();
	}

	public static int GetMusicLength()
	{
		MusicSceneLoader musicSceneLoader = NScene.GetCurrentScene() as MusicSceneLoader;
		if (!(musicSceneLoader != null))
		{
			return 0;
		}
		return musicSceneLoader.GetMusicLength();
	}

	public static int GetTrackNum()
	{
		MusicSceneLoader musicSceneLoader = NScene.GetCurrentScene() as MusicSceneLoader;
		if (!(musicSceneLoader != null))
		{
			return 0;
		}
		return musicSceneLoader.GetTrackNum();
	}

	public static void SetProcessSlider(Slider slider)
	{
		(NScene.GetCurrentScene() as MusicSceneLoader)?.SetProcessSlider(slider);
	}
}
