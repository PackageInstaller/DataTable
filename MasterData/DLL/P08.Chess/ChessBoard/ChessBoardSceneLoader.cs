using System.Collections;
using Cinemachine;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ChessBoard;

public class ChessBoardSceneLoader : NScene
{
	public int mapId;

	public ChessBoardMap mapData = new ChessBoardMap();

	public Int2 bronPos;

	public int direction;

	private ChessBoardHexGridCoord coord;

	public ChessBoardHexGridCoord hexGridCoord
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

	public void SetMapChangeData(ChessBoardGirdChangeData[] serverMapInfoS, ChessBoardThingChangeData[] serverThingInfoS, ChessBoardBanDirChangeData[] serverBanDirInfoS)
	{
		mapData.SetMapChangeData(serverMapInfoS, serverThingInfoS, serverBanDirInfoS);
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
		string sceneId = ChessBoardMapCfgManager.Instance.GetMapConfig().sceneId;
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
		ChessBoardCameraManager.Instance.SetCinemachineBrainParams(cinemachineBrain);
		yield return null;
		mapData.Generate();
		coord.InitMapGameObject();
		yield return null;
		GameObject gameObject = Object.Instantiate(Asset.Load<GameObject>("ChessBoard/CameraCtrl"), GameObject.Find("UICamera/Canvas/UIMain").transform);
		gameObject.GetComponent<ChessBoardUICameraCtrl>().Init(new ChessBoardCameraCtrlGameLogic());
		ChessBoardInputManager.Instance.uIPassEvent = gameObject.GetComponent<UIPassEvent>();
		ChessBoardInputManager.Instance.uIPassEvent.isPassClickInDrag = false;
		yield return null;
		MapConfig mapConfig = ChessBoardMapCfgManager.Instance.GetMapConfig();
		coord.heroEntity = Asset.Instantiate("Char/" + mapConfig.modelName).GetComponent<ChessBoardHeroEntity>();
		coord.heroEntity.transform.localScale = new Vector3(mapConfig.modelScale, mapConfig.modelScale, mapConfig.modelScale);
		ChessBoardCameraManager.Instance.PlayerTrs = coord.heroEntity.transform;
		ChessBoardCameraManager.Instance.PlayerDiceTrs = coord.heroEntity.diceLookAtPoint;
		coord.InitRoleBronPoint();
		coord.InitRoleDirection();
		yield return null;
		ChessBoardNPCManager.Instance.InitNPC();
		LuaHelper.CallFunction("OnEnterChessBoardScene");
		yield return null;
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
