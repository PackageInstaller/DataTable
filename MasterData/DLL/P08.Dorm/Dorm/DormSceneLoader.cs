using System;
using System.Collections;
using System.Collections.Generic;
using Cinemachine;
using Dorm.Furniture;
using UnityEngine;
using UnityEngine.EventSystems;

namespace Dorm;

public class DormSceneLoader : NScene
{
	public RoomInfo mapFurnitureInfoS;

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
		GameObject gameObject = GameObject.Find("UICamera/Canvas/UIScreenTap");
		if ((bool)gameObject)
		{
			Asset.InstantiateWithoutCache("UI/ScreenTapUI", gameObject.transform);
		}
		yield return null;
		if (sceneName == null)
		{
			Debug.LogError("需要加载的场景信息为空");
			yield return null;
		}
		IEnumerator task = LoadLevelAsync(sceneName);
		while (task.MoveNext())
		{
			yield return task.Current;
		}
	}

	public IEnumerator OnAfterLevelLoad()
	{
		GameObject mainCamObj = Camera.main.gameObject;
		U3DUtil.Get<PhysicsRaycaster>(mainCamObj).eventMask = -5 & ~DormConst.OBSTACLE_LAYER_MASK;
		DormCameraManager.SetCinemachineBrainParams(U3DUtil.Get<CinemachineBrain>(mainCamObj));
		if (DormCameraManager.Instance.triggerPanel != null)
		{
			DormCameraManager.Instance.triggerPanel.SetParent(mainCamObj.transform, worldPositionStays: false);
		}
		yield return null;
		FurnitureManager.Instance.Init();
		yield return null;
		DormRoomManager.Instance.mapFurnitureInfoS = mapFurnitureInfoS;
		mapFurnitureInfoS = null;
		RoomInfo roomInfo = DormRoomManager.Instance.mapFurnitureInfoS;
		int roomID = roomInfo.id;
		DormMapCfg dormMapConfig = DormCfgManager.Instance.GetDormMapConfig(roomID);
		DormCameraManager.Instance.InitCameraSetting(dormMapConfig.previewParams, dormMapConfig.editParams);
		DormCameraManager.Instance.ModifyCameraLookAtByStatus(DormCameraManager.CAMERA_LOOKAT_STATUS.WATCH, isNeedInit: true);
		RoomWallTag.mainCameraTrs = mainCamObj.transform;
		yield return null;
		DormRoomManager.Instance.RefreshColliderS();
		DormRoomManager.Instance.ChangeState(DormRoomManager.RoomState.mFreelook);
		yield return null;
		DormCoordinate.Instance.Init();
		DormCoordinate.Instance.RefreshCoordinate();
		yield return null;
		DormRoomManager.Instance.InitRoomInfo(roomID);
		yield return null;
	}

	public void ChangeLevel(string sceneName, Action afterLevelChanged)
	{
		ShowLoadUI();
		SetUIProgress(0f);
		AtlasManager.UnloadAllSprite();
		Asset.UnloadAllAssetBundles();
		StartCoroutine(LoadLevelAsync(sceneName, delegate
		{
			SetUIProgress(100f);
			CloseLoadUI();
			afterLevelChanged?.Invoke();
		}));
	}

	public IEnumerator LoadLevelAsync(string sceneName, Action afterLoaded = null)
	{
		AssetBundleLoadOperation op = Asset.LoadLevelAsync("Levels/" + sceneName, isAddtive: true);
		while (!op.IsDone())
		{
			yield return null;
		}
		IEnumerator enumerator = OnAfterLevelLoad();
		while (enumerator.MoveNext())
		{
			yield return null;
		}
		afterLoaded?.Invoke();
	}

	private bool GetAllIsDone(List<AssetBundleLoadOperation> opList)
	{
		bool result = true;
		for (int i = 0; i < opList.Count; i++)
		{
			if (!opList[i].IsDone())
			{
				result = false;
			}
		}
		return result;
	}

	private void LateUpdate()
	{
		SetUIProgress(Progress);
	}
}
