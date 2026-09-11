using System.Collections;
using Cinemachine;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Chess;

public class ChessSceneLoader : NScene
{
	public int mapId;

	public MapData mapData = new MapData();

	public Vector2 bronPos;

	public int direction;

	public CacheAssetInfo[] cacheAssetS;

	private HexGridCoord coord;

	public HexGridCoord hexGridCoord
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

	public void SetMapData(GridChangeData[] mapInfoS, bool[] fogInfo)
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
		Asset.Cache("WarChess/fx_pick_hexagon");
		string sceneId = ChessMapCfgManager.Instance.GetMapConfig().sceneId;
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
		HexCameraManager.Instance.SetCinemachineBrainParams(cinemachineBrain);
		yield return null;
		mapData.Generate();
		coord.InitMapGameObject();
		yield return null;
		GameObject fogGo = Asset.Instantiate("WarChess/WarChessFog");
		HexFogManager.Instance.Init(fogGo, mapData.fogInfo, mapData.chessMapData.width, mapData.chessMapData.height);
		yield return null;
		if (cacheAssetS != null)
		{
			for (int i = 0; i < cacheAssetS.Length; i++)
			{
				Asset.Cache(cacheAssetS[i].assetPath, cacheAssetS[i].num);
				yield return null;
			}
		}
		GameObject gameObject = Object.Instantiate(Asset.Load<GameObject>("WarChess/CameraCtrl"), GameObject.Find("UICamera/Canvas/UIMain").transform);
		gameObject.GetComponent<ChessUICameraCtrl>().Init(new ChessCameraCtrlGameLogic());
		HexInputManager.Instance.uIPassEvent = gameObject.GetComponent<UIPassEvent>();
		HexInputManager.Instance.uIPassEvent.isPassClickInDrag = false;
		yield return null;
		HexBulletManager.Instance.Init("WarChess/Bullet");
		yield return null;
		MapConfig mapConfig = ChessMapCfgManager.Instance.GetMapConfig();
		coord.mRole = Asset.Instantiate("Char/" + mapConfig.modelName).GetComponent<HexAnimator>();
		coord.mRole.transform.localScale = new Vector3(mapConfig.modelScale, mapConfig.modelScale, mapConfig.modelScale);
		yield return null;
		LuaHelper.CallFunction("PreloadChessAsset");
		yield return null;
		HexCameraManager.Instance.PlayerTrs = coord.mRole.transform;
		LuaHelper.CallFunction("OnEnterChessScene");
		coord.InitRoleBronPoint();
		yield return null;
		yield return null;
		coord.InitRoleDirection();
		yield return null;
		LuaHelper.CallFunction("SetUpChess");
		GameObject gameObject2 = GameObject.Find("UICamera/Canvas/UIScreenTap");
		if ((bool)gameObject2)
		{
			Asset.InstantiateWithoutCache("UI/ScreenTapUI", gameObject2.transform);
		}
	}

	private void LateUpdate()
	{
		SetUIProgress(Progress);
	}
}
