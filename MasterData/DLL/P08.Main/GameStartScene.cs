using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using CriWare;
using UnityEngine;
using UnityEngine.Rendering;

public class GameStartScene : MainSceneLoader
{
	private GameObject hotFixedUI;

	public override void ShowLoadUI()
	{
		hotFixedUI = GameObject.Find("UICamera/Canvas/HotFixedUI");
		if (null != hotFixedUI)
		{
			hotFixedUI.SetActive(value: true);
			LoadingPanel component = hotFixedUI.GetComponent<LoadingPanel>();
			if (component != null)
			{
				component.SetText("SCENE_LOADING".GetGameMainTextString());
			}
			hotFixedUI.transform.SetParent(GameObject.Find("UICamera_DontDestroy/Canvas/UIMain").transform, worldPositionStays: false);
			component.MuteReplayBtn();
		}
	}

	protected override void SetUIProgress(float value)
	{
		if (null != hotFixedUI)
		{
			hotFixedUI.GetComponent<LoadingPanel>().SetLoadingProgress(value);
		}
	}

	public override void OnSceneEnter()
	{
		ReloadAcf();
		if (GameToSDK.clientInfo != null && GameToSDK.clientInfo.configS != null && GameToSDK.clientInfo.configS.ContainsKey("HOT_UPDATE_RENDER_PIPLINE"))
		{
			SwitchHotUpdateRenderPipeline();
		}
		ClearOldVersionVedio();
	}

	public override void CloseLoadUI()
	{
		if (null != hotFixedUI)
		{
			UnityEngine.Object.Destroy(hotFixedUI);
		}
		Resources.UnloadUnusedAssets();
		GC.Collect();
		GC.Collect();
		GC.Collect();
		LuaHelper.CallFunction("LuaGcCollect");
	}

	public override void OnSceneLoaded()
	{
		GameMgr.Init();
	}

	public override void OnSceneReady()
	{
		GamepadManager.Instance.UseController();
		LuaHelper.CallFunction("GameInit");
	}

	private void SwitchHotUpdateRenderPipeline()
	{
		string text = "";
		string text2 = "";
		text = "comsingle/render/replicarenderpipeline_pc.ys";
		text2 = "Assets/ComSingle/ABResources/Render/ReplicaRenderPipeline_PC.asset";
		if (string.IsNullOrEmpty(text) || string.IsNullOrEmpty(text2))
		{
			Debug.Log("SwitchHotUpdateRenderPipeline Fail");
			return;
		}
		Debug.Log("SwitchHotUpdateRenderPipeline Process");
		RenderPipelineAsset renderPipelineAsset = AssetManager.Load<RenderPipelineAsset>(text, text2);
		if (null != renderPipelineAsset)
		{
			GraphicsSettings.defaultRenderPipeline = renderPipelineAsset;
			Debug.Log("SwitchHotUpdateRenderPipeline Success");
			AssetManager.TagDontDestroyAssetbundle(text, isLoad: true);
		}
	}

	public void ReloadAcf()
	{
		AudioManager.Instance.CreateCriAtom();
		CriAtom mCriAtom = AudioManager.Instance.mCriAtom;
		if (mCriAtom.acfFile.Length != 0)
		{
			string pFilePath = mCriAtom.acfFile;
			CriAtomEx.UnregisterAcf();
			if (!CriWareExtension.TryGetFilePath(pFilePath, out pFilePath) && Common.IsStreamingAssetsPath(pFilePath))
			{
				pFilePath = Path.Combine(Common.streamingAssetsPath, pFilePath);
			}
			CriAtomEx.RegisterAcf(null, pFilePath);
			Debug.Log("Reload acf by path : " + pFilePath + "  | acfFile : " + mCriAtom.acfFile);
		}
		else
		{
			Debug.Log("Reload acf fail");
		}
	}

	private void ClearOldVersionVedio()
	{
		if (GameToSDK.vClientVersionInfo == null)
		{
			return;
		}
		string text = Path.Combine(Application.persistentDataPath, GameToSDK.pvName);
		List<string> list = Directory.GetFiles(Application.persistentDataPath, "*.usm", SearchOption.TopDirectoryOnly).ToList();
		list.Add(Path.Combine(Application.persistentDataPath, "3.2pv"));
		list.Add(Path.Combine(Application.persistentDataPath, "3.5 PV"));
		list.Add(Path.Combine(Application.persistentDataPath, "3.7 PV"));
		foreach (string item in list)
		{
			if (File.Exists(item) && item != text)
			{
				File.Delete(item);
			}
		}
	}
}
