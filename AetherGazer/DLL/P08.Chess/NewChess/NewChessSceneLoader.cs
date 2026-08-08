using System.Collections;
using Cinemachine;
using UnityEngine;
using UnityEngine.EventSystems;

namespace NewChess;

public class NewChessSceneLoader : NScene
{
	public int mapId;

	public NewMapData mapData = new NewMapData();

	public Int2 bronPos;

	public int direction;

	public NewCacheAssetInfo[] cacheAssetS;

	private NewHexGridCoord coord;

	public NewHexGridCoord hexGridCoord
	{
		get
		{
			return coord;
		}
		set
		{
			coord = value;
		}
	}

	public void SetMapId(int mapId)
	{
		mapData.SetMapId(mapId);
	}

	public void SetMapData(NewGridChangeData[] mapInfoS, bool[] fogInfo)
	{
		mapData.SetMapData(mapInfoS, fogInfo);
	}

	public override void ShowLoadUI()
	{
		LoadingUIManager.inst.ShowLoadUI();
	}

	protected void SetUIProgress(float value)
	{
		LoadingUIManager.inst.SetUIProgress(value);
	}

	public override void CloseLoadUI()
	{
		LoadingUIManager.inst.CloseLoadUI();
	}

	public override IEnumerator OnLoadCoroutine()
	{
		yield return null;
		Asset.Cache(HexTransitionEffect.fxPath);
		Asset.Cache("NewWarChess/fx_pick_hexagon", 10);
		string sceneId = NewChessMapCfgManager.Instance.GetMapConfig().sceneId;
		string path = "Levels/X100";
		AssetBundleLoadOperation ops = Asset.LoadLevelAsync("Levels/" + sceneId, isAddtive: true);
		AssetBundleLoadOperation ops2 = Asset.LoadLevelAsync(path, isAddtive: true);
		while (!ops.IsDone() || !ops2.IsDone())
		{
			yield return null;
		}
		yield return null;
		CinemachineBrain cinemachineBrain = Camera.main.gameObject.AddComponent<CinemachineBrain>();
		cinemachineBrain.m_DefaultBlend.m_Time = 0.5f;
		Camera.main.gameObject.AddComponent<PhysicsRaycaster>();
		NewHexCameraManager.Instance.SetCinemachineBrainParams(cinemachineBrain);
		yield return null;
		mapData.Generate();
		coord.InitMapGameObject();
		yield return null;
		GameObject fogGo = Asset.Instantiate("NewWarChess/NewWarChessFog");
		NewHexFogManager.Instance.Init(fogGo, mapData.fogInfo, mapData.chessMapData.width, mapData.chessMapData.height);
		yield return null;
		if (cacheAssetS != null)
		{
			for (int i = 0; i < cacheAssetS.Length; i++)
			{
				Asset.Cache(cacheAssetS[i].assetPath, cacheAssetS[i].num);
				yield return null;
			}
		}
		GameObject gameObject = Object.Instantiate(Asset.Load<GameObject>("NewWarChess/CameraCtrl"), GameObject.Find("UICamera/Canvas/UIMain").transform);
		gameObject.GetComponent<NewChessUICameraCtrl>().Init(new NewChessCameraCtrlGameLogic());
		NewHexInputManager.Instance.uIPassEvent = gameObject.GetComponent<UIPassEvent>();
		NewHexInputManager.Instance.uIPassEvent.isPassClickInDrag = false;
		yield return null;
		NewMapConfig mapConfig = NewChessMapCfgManager.Instance.GetMapConfig();
		coord.mRole = Asset.Instantiate("Char/" + mapConfig.modelName).GetComponent<NewHexAnimator>();
		coord.mRole.transform.localScale = new Vector3(mapConfig.modelScale, mapConfig.modelScale, mapConfig.modelScale);
		yield return null;
		LuaHelper.CallFunction("PreloadNewChessAsset");
		yield return null;
		NewHexCameraManager.Instance.PlayerTrs = coord.mRole.transform;
		LuaHelper.CallFunction("OnEnterNewChessScene");
		coord.InitRoleBronPoint();
		yield return null;
		coord.InitRoleDirection();
		yield return null;
	}

	private void LateUpdate()
	{
		SetUIProgress(Progress);
	}
}
