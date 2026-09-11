using System;
using System.Collections;
using LuaInterface;
using UnityEngine;
using UnityEngine.SceneManagement;

public class MainSceneLoader : NScene
{
	private static GlobalStaticLoader globalLoader;

	public override void ShowLoadUI()
	{
		LoadingUIManager.inst.ShowLoadUI(LoadingUIType.Main);
	}

	public override IEnumerator OnSceneReadyCoroutine()
	{
		AudioManager.Instance.CreateCriAtom();
		AudioManager.Instance.SetListener(Camera.main.gameObject);
		object[] result = LuaHelper.CallFunction("GetInitAssetList");
		LuaHelper.CallFunction("EnterMainScene");
		yield return null;
		LuaTable luaTable = result[0] as LuaTable;
		object[] assetList = luaTable.ToArray();
		int i = 0;
		while (i < assetList.Length)
		{
			Asset.Load(assetList[i].ToString());
			i++;
			yield return new WaitForSeconds(0.1f);
		}
		yield return null;
	}

	protected virtual void SetUIProgress(float value)
	{
		LoadingUIManager.inst.SetUIProgress(value);
	}

	public override void CloseLoadUI()
	{
		Debug.Log("===========================close loading ui===================================");
		LoadingUIManager.inst.CloseLoadUI();
	}

	public override void OnSceneEnter()
	{
	}

	private void LateUpdate()
	{
		SetUIProgress(Progress);
	}

	public override IEnumerator OnLoadCoroutine()
	{
		string path = "Levels/X100";
		AssetBundleLoadOperation ops = Asset.LoadLevelAsync(path, isAddtive: true);
		while (!ops.IsDone())
		{
			yield return null;
		}
		if (globalLoader == null)
		{
			globalLoader = new GlobalStaticLoader();
			IEnumerator it = globalLoader.Load();
			while (it.MoveNext())
			{
				yield return null;
			}
			yield return null;
		}
		yield return new WaitForEndOfFrame();
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
	}

	public override void OnSceneReady()
	{
		base.OnSceneReady();
	}

	public override void OnSceneLoaded()
	{
		Debug.Log("------------");
		try
		{
			LuaHelper.CallFunction("RefreshUI");
			LuaHelper.CallFunction("OnQuitBattleSuccess");
			SetUIProgress(100f);
		}
		catch (Exception ex)
		{
			Debug.Log(ex.Message);
		}
	}

	public override void OnSceneExit(NScene nextScene)
	{
		LuaHelper.CallFunction("ExitMainScene");
	}
}
