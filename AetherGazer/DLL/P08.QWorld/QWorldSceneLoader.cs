using System;
using System.Collections;
using System.Collections.Generic;
using Unity.HLODSystem;
using UnityEngine;
using UnityEngine.SceneManagement;

public class QWorldSceneLoader : NScene
{
	public QWTeleportManager teleportManager;

	public string qwSceneName;

	private const string EnterWorldSceneFunc = "PostEnterQWorldScene";

	public QWorldUI mWorldUI { get; private set; }

	public SceneSetting sceneSetting => mMap?.sceneSetting;

	public QWCharacterAgent Agent { get; set; }

	protected QWorldMap mMap { get; private set; }

	protected QWorldMapManager mMapManger { get; private set; }

	public int initialCharId => QWorldMap.HeroId;

	public QWorldMapManager GetMapManager()
	{
		return mMapManger;
	}

	public QWorldMap GetMap()
	{
		return mMap;
	}

	public override void ShowLoadUI()
	{
		LoadingUIManager.inst.ShowLoadUI(LoadingUIType.Main);
	}

	public override IEnumerator OnSceneReadyCoroutine()
	{
		AudioManager.Instance.CreateCriAtom();
		AudioManager.Instance.SetListener(Camera.main.gameObject);
		AudioManager.Instance.StopAll();
		yield return null;
		LuaHelper.CallFunction("PlayQWorldBgm");
		QWorldScene.Scene.ResetWorldStateWithPos(Agent.Position);
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
		mMapManger = new QWorldMapManager();
		mMap = new QWorldMap(mMapManger);
		teleportManager = new QWTeleportManager();
		teleportManager.Init();
	}

	public void ResetLODParams(float[] newlod)
	{
		QWorldScene.Scene.ratio = newlod;
	}

	public void RebuildLOD()
	{
		List<LOD> list = new List<LOD>();
		foreach (KeyValuePair<LODGroup, List<LOD>> item2 in mMap.OriginLOD)
		{
			float size = item2.Key.size;
			list.Clear();
			List<LOD> value = item2.Value;
			if (value[0].screenRelativeTransitionHeight != 0f)
			{
				float num = 0f;
				for (int i = 0; i < value.Count; i++)
				{
					LOD item = value[i];
					float num2 = (item.screenRelativeTransitionHeight += item.screenRelativeTransitionHeight * QWorldScene.Scene.ratio[i]);
					list.Add(item);
					num += num2;
				}
				item2.Key.SetLODs(list.ToArray());
				item2.Key.size = size;
			}
		}
		GC.Collect();
	}

	public override IEnumerator OnLoadCoroutine()
	{
		GameObject role = Asset.Instantiate("QWWorld/Chars/QW_Player");
		Agent = role.GetComponent<QWCharacterAgent>();
		Agent.Initialize();
		yield return null;
		IEnumerator mapIEnumerator = mMap.Load(qwSceneName);
		while (mapIEnumerator != null && mapIEnumerator.MoveNext())
		{
			yield return null;
		}
		qwSceneName = mMap.lastSceneName;
		yield return new WaitForEndOfFrame();
		role.transform.position = teleportManager.GetStageOriginTeleport().position;
		role.transform.rotation = teleportManager.GetStageOriginTeleport().rotation;
		Scene sceneByName = SceneManager.GetSceneByName("Common");
		if (sceneByName.IsValid())
		{
			SceneManager.SetActiveScene(sceneByName);
		}
		else
		{
			Debug.LogError("can't find scene by path: " + scenePath);
		}
		LuaHelper.CallFunction("PostEnterQWorldScene", mMap.lastSceneName);
		_ = (bool)GameObject.Find("UICamera/Canvas/UIScreenTap");
		Camera.main.transform.position = new Vector3(-4.48f, 3.7f, -2.8f);
		Camera.main.transform.rotation = Quaternion.Euler(17f, 0f, 0f);
		U3DUtil.Get<HLODCameraRecognizer>(Camera.main.gameObject);
		QWorldWalkingPeopleGroup.globalCulledOverride = false;
		LuaHelper.CallFunction("QWorldUIShowWithBlank");
	}

	public void RegisterWorldUI(QWorldUI worldUI)
	{
		mWorldUI = worldUI;
	}

	public override IEnumerator OnSceneRestartCoroutine(int sceneID)
	{
		isReady = false;
		IEnumerator mapIEnumerator = mMap.Restart(qwSceneName);
		while (mapIEnumerator != null && mapIEnumerator.MoveNext())
		{
			yield return null;
		}
		LuaHelper.CallFunction("PostEnterQWorldScene", mMap.lastSceneName);
		isReady = true;
		yield return new WaitForEndOfFrame();
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
			SetUIProgress(100f);
		}
		catch (Exception ex)
		{
			Debug.Log(ex.Message);
		}
	}

	public override void OnSceneExit(NScene nextScene)
	{
		mMapManger.Dispose();
		mMapManger = null;
		mMap.Dispose();
		mMap = null;
		AudioManager.Instance.StopAll();
	}
}
