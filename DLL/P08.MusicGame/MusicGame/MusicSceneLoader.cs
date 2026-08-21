using System.Collections;
using System.Globalization;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace MusicGame;

public class MusicSceneLoader : NScene
{
	public MusicGameStruct gameData;

	public MusicController musicController;

	public MusicDataForExchange exchangeData;

	public override IEnumerator OnLoadCoroutine()
	{
		CultureInfo info = CultureInfo.CurrentCulture;
		CultureInfo.CurrentCulture = CultureInfo.InvariantCulture;
		yield return null;
		AssetBundleLoadOperation ops = Asset.LoadLevelAsync("Levels/X106", isAddtive: true);
		while (!ops.IsDone())
		{
			yield return null;
		}
		Camera.main.gameObject.AddComponent<PhysicsRaycaster>();
		yield return null;
		gameData = MusicGameStruct.LoadFromFile(exchangeData.musicPath);
		LuaHelper.CallFunction("MusicToLuaBridge.SetUpMusic");
		yield return null;
		musicController = Object.FindObjectOfType<MusicController>();
		musicController.InitConfig(exchangeData);
		musicController.InitSound(exchangeData.cueSheetName, exchangeData.cueName, exchangeData.awbFile, exchangeData.aisacKey, exchangeData.aisacValue);
		yield return null;
		CultureInfo.CurrentCulture = info;
	}

	public int GetTrackNum()
	{
		return gameData.GetTrackNum();
	}

	public override void OnSceneLoaded()
	{
		LuaHelper.CallFunction("MusicToLuaBridge.OnMusicSceneLoaded");
	}

	public override void OnSceneExit(NScene nextScene)
	{
		base.OnSceneExit(nextScene);
		LuaHelper.CallFunction("MusicToLuaBridge.OnMusicSceneExit");
		musicController.DisposeSound();
	}

	public override void ShowLoadUI()
	{
		LoadingUIManager.inst.ShowLoadUI();
	}

	protected void SetUIProgress(float value)
	{
		LoadingUIManager.inst.SetUIProgress(value);
	}

	private void LateUpdate()
	{
		SetUIProgress(Progress);
	}

	public override void CloseLoadUI()
	{
		LoadingUIManager.inst.CloseLoadUI();
	}

	public void SetGameConfig(MusicDataForExchange data)
	{
		exchangeData = data;
	}

	public void StartMusicGame()
	{
		musicController.StartMusicGame(gameData);
	}

	public void PauseMusicGame()
	{
		musicController.PauseMusicGame();
	}

	public void ResumeMusicGame()
	{
		musicController.ResumeMusicGame();
	}

	public void EndMusicGame()
	{
		musicController.EndMusicGame();
	}

	public void ReStartMusicGame()
	{
		musicController.ReStartMusicGame();
	}

	public string GetCurrentState()
	{
		return musicController.CurrentState.ToString();
	}

	public CriAtomSource GetMusicPlay()
	{
		return musicController.GetMusicPlay();
	}

	public int GetCurTime()
	{
		return musicController.GetCurTime();
	}

	public int GetMusicLength()
	{
		return musicController.GetMusicLength();
	}

	public void SetProcessSlider(Slider slider)
	{
		musicController.SetProcessSlider(slider);
	}
}
