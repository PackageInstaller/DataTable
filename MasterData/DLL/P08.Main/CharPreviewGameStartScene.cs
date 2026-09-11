using System.Collections;
using UnityEngine;
using UnityEngine.SceneManagement;

public class CharPreviewGameStartScene : MainSceneLoader
{
	public override void ShowLoadUI()
	{
	}

	protected override void SetUIProgress(float value)
	{
	}

	public override void CloseLoadUI()
	{
	}

	public override void OnSceneLoaded()
	{
		GameMgr.Init();
	}

	public override void OnSceneReady()
	{
		LuaHelper.CallFunction("CharPreviewGameInit");
	}

	public override IEnumerator OnLoadCoroutine()
	{
		Scene sceneByName = SceneManager.GetSceneByName("Common");
		if (sceneByName.IsValid())
		{
			SceneManager.SetActiveScene(sceneByName);
		}
		else
		{
			Debug.LogError("can't find scene by path: " + scenePath);
		}
		GameObject gameObject = GameObject.Find("UICamera/Canvas/UIScreenTap");
		if ((bool)gameObject)
		{
			GameObject gameObject2 = Asset.InstantiateWithoutCache("UI/ScreenTapUI", gameObject.transform);
			if (gameObject2 != null)
			{
				gameObject2.GetComponentOrAdd<PCCursorCreator>();
			}
		}
		yield break;
	}
}
