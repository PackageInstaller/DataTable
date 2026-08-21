using System;
using System.Collections.Generic;
using System.Linq;
using Cinemachine;
using Dorm;
using Dorm.Character;
using Dorm.Furniture;
using Dorm.UI;
using LuaInterface;
using UnityEngine;
using UnityEngine.SceneManagement;

public static class DormLuaBridge
{
	private static Bounds? dormSpawnBounds;

	private const float OffsetY = 5f;

	private static Lazy<DormStickController> dormStickController = new Lazy<DormStickController>();

	private const string LUA_INVOKE_DORM_EVENT = "Dorm.InvokeEvent";

	public static DormStickController DormStickController => dormStickController.Value;

	public static void Launcher(DormDataForExchange dormDataForExchange, Action callback)
	{
		callback?.Invoke();
		switch (dormDataForExchange.sceneType)
		{
		case 1:
			UpdateSceneInfo(NScene.Load<CanteenScene>(), dormDataForExchange);
			break;
		case 2:
		case 3:
			UpdateSceneInfo(NScene.Load<DormScene>(), dormDataForExchange);
			break;
		}
	}

	public static void ChangeDormScene(DormDataForExchange dormDataForExchange, Action callback)
	{
		Debug.Log("NScene.GetCurrentScene().sceneName = " + NScene.GetCurrentScene().sceneName);
		DormSceneLoader obj = NScene.GetCurrentScene() as DormSceneLoader;
		SceneManager.UnloadSceneAsync(obj.sceneName);
		obj.ChangeLevel(dormDataForExchange.sceneName, callback);
		UpdateSceneInfo(obj, dormDataForExchange);
	}

	private static void UpdateSceneInfo(DormSceneLoader scene, DormDataForExchange dormDataForExchange)
	{
		scene.sceneName = dormDataForExchange.sceneName;
		scene.mapFurnitureInfoS = dormDataForExchange.mapFurnitureInfoS;
		DormCfgManager.Instance.SetFurnitureConfig(dormDataForExchange.furnitureConfigs);
		DormCfgManager.Instance.SetDormMapConfig(dormDataForExchange.dormMapCfg);
	}

	public static void RefreshIsCanPlace(int furnitureEntityID, bool canPlace)
	{
		FurnitureEntity goodsEntity = FurnitureManager.Instance.Get(furnitureEntityID);
		FurnitureManager.Instance.RefreshIsCanPlace(goodsEntity, canPlace);
	}

	internal static void ChangeFurnitureState(FurnitureEntity furniture, FurnitureEntity.FurnitureStatus state, bool ignoreCheckCanPlace = false)
	{
		FurnitureManager.Instance.ChangeFurnitureState(furniture, state, ignoreCheckCanPlace);
	}

	public static void ChangeFurnitureState(int furnitureEntityID, int state, bool ignoreCheckCanPlace = false)
	{
		ChangeFurnitureState(FurnitureManager.Instance.Get(furnitureEntityID), (FurnitureEntity.FurnitureStatus)state, ignoreCheckCanPlace);
	}

	internal static void BeginDragFurniture(FurnitureEntity furniture)
	{
		FurnitureEventTrigger component = furniture.MainColliderTrs.GetComponent<FurnitureEventTrigger>();
		if (component != null)
		{
			component.isStartByDragMode = true;
		}
	}

	public static void BeginDragFurniture(int furnitureEntityID)
	{
		BeginDragFurniture(FurnitureManager.Instance.Get(furnitureEntityID));
	}

	internal static bool IsWallTileType(TileType myTileType)
	{
		if (myTileType != TileType.WALL_FRONT && myTileType != TileType.WALL_BEHIND && myTileType != TileType.WALL_LEFT)
		{
			return myTileType == TileType.WALL_RIGHT;
		}
		return true;
	}

	public static int GenerateFurniture(int cfgID, uint state, string path, int width, int height, int depth, bool mustTouchGround, bool complex = false)
	{
		FurnitureEntity furnitureEntity = FurnitureManager.Instance.GenerateFurniture(path, complex);
		TileType tileType = TileType.FLOOR;
		if (DormRoomManager.Instance != null)
		{
			furnitureEntity.trs.parent = DormRoomManager.Instance.GetTrsByType(tileType);
		}
		furnitureEntity.TileType = tileType;
		FurnitureTag tag = furnitureEntity.tag;
		tag.id = cfgID;
		tag.state = state;
		tag.forceLayOnGrount = mustTouchGround;
		tag.Size = new Vector3Int(width, height, depth);
		return furnitureEntity.entityId;
	}

	public static void SnapWallMountFurniture(int eid)
	{
		RoomWallTag availableWall = DormCoordinate.Instance.GetAvailableWall();
		FurnitureEntity furnitureEntity = FurnitureManager.Instance.Get(eid);
		furnitureEntity.TileType = availableWall.tileType;
		if (furnitureEntity.WallMountLayOnGround)
		{
			furnitureEntity.trs.localPosition = DormCoordinate.Instance.FindNearestPosition(availableWall.tileType, availableWall.defaultSetPoint, isLimit: true, wallMountLayOnGround: true, furnitureEntity.width, furnitureEntity.height);
		}
		else
		{
			furnitureEntity.trs.localPosition = availableWall.defaultSetPoint;
		}
		furnitureEntity.trs.parent = DormRoomManager.Instance.GetTrsByType(availableWall.tileType);
		furnitureEntity.trs.forward = availableWall.transform.forward;
	}

	public static bool RemoveFurniture(int furnitrueEntityID, bool needRemoveFootPrint = true)
	{
		return FurnitureManager.Instance.RemoveFurniture(furnitrueEntityID, needRemoveFootPrint);
	}

	public static void BeginGrabPlayerEntity(int entityID, int? followPointer)
	{
		DormEntityTrigger dormEntityTrigger = DormEntityManager.TryGetPlayer(entityID)?.Trigger;
		if ((bool)dormEntityTrigger)
		{
			dormEntityTrigger.FollowingPointer = followPointer ?? DormEntityTrigger.GetAnyValidPointerCanFollow();
			if (DormEntityTrigger.IsInputActive(dormEntityTrigger.FollowingPointer, out var inputPos, out var _))
			{
				dormEntityTrigger.BeginGrab(Camera.main, inputPos);
			}
			else
			{
				dormEntityTrigger.BeginGrab();
			}
		}
	}

	public static void EndGrabPlayerEntity(int entityID)
	{
		DormEntityManager.TryGetPlayer(entityID)?.Trigger.EndGrab();
	}

	public static void TryGrabPlayerOutOfStuck(int entityID, bool queue = false)
	{
		DormPlayerEntity dormPlayerEntity = DormEntityManager.TryGetPlayer(entityID);
		DormEntityTrigger.GrabOutOfStuckCmdTask grabOutOfStuckCmdTask = dormPlayerEntity?.Trigger.grabOutStuckCmd;
		if (grabOutOfStuckCmdTask != null)
		{
			dormPlayerEntity.entity.CmdExecuter.SendCmd(grabOutOfStuckCmdTask, queue);
		}
	}

	public static void ChangeRoomState(bool isInEditMode)
	{
		DormRoomManager.Instance.ChangeState((!isInEditMode) ? DormRoomManager.RoomState.mFreelook : DormRoomManager.RoomState.mEditFurniture);
		DormCameraManager.Instance.ModifyCameraLookAtByStatus(isInEditMode ? DormCameraManager.CAMERA_LOOKAT_STATUS.EDIT : DormCameraManager.CAMERA_LOOKAT_STATUS.WATCH, isNeedInit: true);
	}

	public static bool InDormSpawnBounds(Vector3 pos)
	{
		if (dormSpawnBounds.HasValue)
		{
			pos.y = dormSpawnBounds.Value.center.y;
			return dormSpawnBounds.Value.Contains(pos);
		}
		return true;
	}

	public static void CalcDormSpawnBounds()
	{
		dormSpawnBounds = null;
		if (!DormRoomManager.Instance)
		{
			return;
		}
		List<RoomWallTag> wallTags = DormRoomManager.Instance.wallTags;
		if (wallTags == null || wallTags.Count <= 0)
		{
			return;
		}
		wallTags[0].collider.enabled = true;
		Bounds bounds = wallTags[0].collider.bounds;
		if (wallTags.Count > 1)
		{
			for (int i = 1; i < wallTags.Count; i++)
			{
				wallTags[i].collider.enabled = true;
				bounds.Encapsulate(wallTags[i].collider.bounds);
			}
		}
		dormSpawnBounds = bounds;
	}

	public static Vector3? FindSpawnPos(float entityRadius, int maxTry = 5, bool ignoreGroundTest = false)
	{
		RoomWallTag floorRoomWallTag = DormCoordinate.Instance.floorRoomWallTag;
		Vector3 originalPointWorldPos = floorRoomWallTag.originalPointWorldPos;
		for (int i = 0; i < maxTry; i++)
		{
			int num = UnityEngine.Random.Range(1, floorRoomWallTag.width);
			int num2 = UnityEngine.Random.Range(1, floorRoomWallTag.height);
			Vector3 vector = new Vector3(num, 0f, num2) * 0.25f + originalPointWorldPos;
			if (TestCanSpawn(vector, entityRadius, ignoreGroundTest))
			{
				return vector;
			}
		}
		return null;
	}

	internal static IEnumerable<Vector3> IterateSurroundingTile(Vector3 grabingPos, float range, float step)
	{
		Vector3Int gridIdx = Vector3Int.RoundToInt(grabingPos / step);
		gridIdx.y = 0;
		yield return (Vector3)gridIdx * step;
		for (int i = 1; i <= Mathf.CeilToInt(range / step); i++)
		{
			for (int j = 0; j < i; j++)
			{
				yield return (gridIdx + new Vector3(j, 0f, -i)) * step;
				yield return (gridIdx + new Vector3(-1 - j, 0f, -i)) * step;
				yield return (gridIdx + new Vector3(-i, 0f, -j)) * step;
				yield return (gridIdx + new Vector3(-i, 0f, 1 + j)) * step;
				yield return (gridIdx + new Vector3(-j, 0f, i)) * step;
				yield return (gridIdx + new Vector3(1 + j, 0f, i)) * step;
				yield return (gridIdx + new Vector3(i, 0f, -j)) * step;
				yield return (gridIdx + new Vector3(i, 0f, 1 + j)) * step;
			}
		}
	}

	public static Vector3? FindSpawnPosNearBy(int eid, float range = 3.5f)
	{
		DormRoomManager.Instance.ChangeState(DormRoomManager.RoomState.mEditFurniture);
		DormEntity dormEntity = DormEntityManager.Instance.TryGet(eid);
		Vector3 worldPos = dormEntity.GetWorldPos();
		float step = 0.25f;
		Vector3? result = null;
		foreach (Vector3 item in IterateSurroundingTile(worldPos, range, step))
		{
			if (TestCanSpawn(item, dormEntity.radius, ignoreGroundTest: false, out var groundHeight))
			{
				result = new Vector3(item.x, groundHeight, item.z);
				break;
			}
		}
		DormRoomManager.Instance.ChangeState(DormRoomManager.RoomState.mFreelook);
		return result;
	}

	public static bool TestCanSpawn(Vector3 pos, float radius, bool ignoreGroundTest)
	{
		float groundHeight;
		return TestCanSpawn(pos, radius, ignoreGroundTest, out groundHeight);
	}

	public static bool TestCanSpawn(Vector3 pos, float radius, bool ignoreGroundTest, out float groundHeight)
	{
		int ignoreGroundRaycastLayer = DormEntityAction.ignoreGroundRaycastLayer;
		groundHeight = pos.y;
		if (!ignoreGroundTest)
		{
			if (!Physics.Raycast(new Ray(new Vector3(pos.x, 5f, pos.z), Vector3.down), out var hitInfo, float.MaxValue, LayerMask.GetMask("ground")))
			{
				return false;
			}
			pos = hitInfo.point;
			groundHeight = pos.y;
			RoomWallTag component = hitInfo.collider.GetComponent<RoomWallTag>();
			if ((bool)component && component.tileType != TileType.FLOOR)
			{
				return false;
			}
		}
		if (InDormSpawnBounds(pos))
		{
			return !Physics.CheckSphere(pos, radius, ignoreGroundRaycastLayer, QueryTriggerInteraction.Ignore);
		}
		return false;
	}

	public static bool SaveChange()
	{
		if (FurnitureManager.Instance.editingFurniture != null)
		{
			FurnitureEntity editingFurniture = FurnitureManager.Instance.editingFurniture;
			FurnitureManager.Instance.UpdateAllFurnitureInteractArea();
			if (editingFurniture.isCanPlace)
			{
				FurnitureManager.FillFurnitureOccupy(editingFurniture);
				FurnitureManager.Instance.ChangeFurnitureState(editingFurniture, FurnitureEntity.FurnitureStatus.mPlaced);
				FurnitureManager.Instance.ClearEditingFurniture();
				if (editingFurniture.parent != null && !editingFurniture.parent.suitChangeFlag)
				{
					editingFurniture.parent.suitChangeFlag = true;
				}
				return true;
			}
		}
		return false;
	}

	public static bool GetIsCanPlace()
	{
		if (FurnitureManager.Instance.editingFurniture != null)
		{
			return FurnitureManager.Instance.editingFurniture.isCanPlace;
		}
		return false;
	}

	public static void ClearEditingFurniture()
	{
		FurnitureManager.Instance.ClearEditingFurniture();
	}

	internal static void ChangeFurnitureTileType(FurnitureEntity furnitureEntity, TileType tileType)
	{
		if (IsWallTileType(tileType) && furnitureEntity.TileType != tileType)
		{
			RemoveFurnitureFromWallDitherAlphaControl(furnitureEntity.trs, furnitureEntity.TileType);
			furnitureEntity.trs.SetParent(DormRoomManager.Instance.GetTrsByType(tileType), worldPositionStays: true);
			AddFurnitureToWallDitherAlphaControl(furnitureEntity.trs, tileType);
		}
		furnitureEntity.TileType = tileType;
	}

	public static bool CancelChange(out int cancledEditing)
	{
		if (FurnitureManager.Instance.editingFurniture != null)
		{
			FurnitureEntity editingFurniture = FurnitureManager.Instance.editingFurniture;
			if (!FurnitureManager.Instance.isChangePosition)
			{
				cancledEditing = editingFurniture.entityId;
				RemoveFurnitureFromWallDitherAlphaControl(editingFurniture.trs, editingFurniture.TileType);
				FurnitureManager.Instance.ClearEditingFurniture();
				return true;
			}
			FurnitureManager.Instance.ChangeFurnitureState(editingFurniture, FurnitureEntity.FurnitureStatus.mPlaced);
			ChangeFurnitureTileType(editingFurniture, FurnitureManager.Instance.editingFurnitureTileTypeTmp);
			editingFurniture.trs.forward = FurnitureManager.Instance.editingFurnitureForwardTmp;
			editingFurniture.trs.position = FurnitureManager.Instance.editingFurniturePosTmp;
			editingFurniture.trs.localEulerAngles = FurnitureManager.Instance.editingFurnitureRotationTmp;
			editingFurniture.isChangePosition = false;
			FurnitureManager.Instance.ClearEditingFurniture();
		}
		cancledEditing = 0;
		return false;
	}

	public static void ClearFurnitureOccupy()
	{
		DormCoordinate.Instance.ClearAllOccupy();
	}

	public static void RecoverRoomFurnitureOccupy(int idx, int entityID)
	{
		FurnitureInfo furnitureInfo = DormRoomManager.Instance.mapFurnitureInfoS.furnitureInfoS[idx];
		TileType tileType = (TileType)furnitureInfo.tileType;
		FurnitureEntity furnitureEntity = FurnitureManager.Instance.Get(entityID);
		furnitureEntity.TileType = tileType;
		furnitureEntity.trs.parent = DormRoomManager.Instance.GetTrsByType(tileType);
		Vector3 realPositionByType = DormCoordinate.Instance.GetRealPositionByType(tileType, furnitureInfo.pos);
		Vector3 localEulerAngles = DormCoordinate.Instance.GetRealRotationByType(tileType, furnitureInfo.rotation);
		furnitureEntity.trs.position = realPositionByType;
		furnitureEntity.trs.localEulerAngles = localEulerAngles;
		RoomWallTag roomWallTagByType = DormCoordinate.Instance.GetRoomWallTagByType(tileType);
		if (roomWallTagByType != null)
		{
			furnitureEntity.trs.forward = roomWallTagByType.transform.forward;
		}
		FurnitureManager.FillFurnitureOccupy(furnitureEntity);
	}

	public static void RecoverRoomFurnitureOccupyByLua(int entityID)
	{
		FurnitureManager.FillFurnitureOccupy(FurnitureManager.Instance.Get(entityID));
	}

	public static void ReleaseRoomFurnitureOccupyByLua(int entityID)
	{
		FurnitureManager.RemoveFurnitureOccupy(FurnitureManager.Instance.Get(entityID));
	}

	public static void ClearCurrentRoom()
	{
		DormRoomManager.Instance.ClearCurrentRoom();
	}

	public static void SyncRoomFurniture(FurnitureInfo[] furnitureInfoS)
	{
		DormRoomManager.Instance.mapFurnitureInfoS.furnitureInfoS = furnitureInfoS;
	}

	public static int StorageFurniture()
	{
		if (FurnitureManager.Instance.editingFurniture != null)
		{
			int entityId = FurnitureManager.Instance.editingFurniture.entityId;
			FurnitureManager.Instance.ClearEditingFurniture();
			return entityId;
		}
		return -1;
	}

	public static bool CheckFurnitureConnectReady(int furniture, int otherFurniture)
	{
		FurnitureEntity furnitureEntity = FurnitureManager.Instance.Get(furniture);
		FurnitureEntity entity = FurnitureManager.Instance.Get(otherFurniture);
		FurnitureConnectInterace otherConnectedInterface;
		return furnitureEntity.ConnectReady(entity, out otherConnectedInterface);
	}

	private static void SnapFurnitureToGridAfterRotate(FurnitureEntity furnitureEntity, Vector3 rotateAxis)
	{
		bool flag = Mathf.RoundToInt(Vector3.Dot(rotateAxis, furnitureEntity.trs.localEulerAngles) / 90f) % 2 == 1;
		int width = (flag ? furnitureEntity.height : furnitureEntity.width);
		int height = (flag ? furnitureEntity.width : furnitureEntity.height);
		bool wallMountLayOnGround = furnitureEntity.WallMountLayOnGround;
		furnitureEntity.trs.position = DormCoordinate.Instance.FindNearestPosition(furnitureEntity.TileType, furnitureEntity.trs.position, isLimit: true, wallMountLayOnGround, width, height, flag);
	}

	public static bool RotateFurniture()
	{
		if (FurnitureManager.Instance.editingFurniture != null)
		{
			FurnitureEntity editingFurniture = FurnitureManager.Instance.editingFurniture;
			Vector3 rotationAxisByType = DormCoordinate.Instance.GetRotationAxisByType(editingFurniture.TileType);
			RotateFurniture(editingFurniture, rotationAxisByType);
			SnapFurnitureToGridAfterRotate(editingFurniture, rotationAxisByType);
			FurnitureManager.Instance.RefreshIsCanPlace(editingFurniture);
			FurnitureManager.RefreshFurnitureInteractPosVfx(editingFurniture);
			return true;
		}
		return false;
	}

	public static bool RotateFurniture(FurnitureEntity furnitureEntity, Vector3 rotateAxis)
	{
		float num = Vector3.Dot(rotateAxis, furnitureEntity.trs.localEulerAngles);
		Vector3 localEulerAngles = Mathf.Ceil(((360f + num % 360f) % 360f + 10f) / 90f) * 90f * rotateAxis;
		furnitureEntity.trs.localEulerAngles = localEulerAngles;
		return true;
	}

	public static void UpdateAllFurnitureInteractAreaEnabled()
	{
		FurnitureManager.Instance.UpdateAllFurnitureInteractArea();
	}

	internal static void UpdateWallMountDitherAlphaControl(TileType tileType)
	{
		SceneDitherControl component = DormRoomManager.Instance.GetTrsByType(tileType).GetComponent<SceneDitherControl>();
		if ((bool)component)
		{
			component.UpdateRenderer();
		}
	}

	public static void UpdateWallMountDitherAlphaControl(int tileType)
	{
		UpdateWallMountDitherAlphaControl((TileType)tileType);
	}

	public static TileType GetCurFurnitureTileType(int furnitureEntityID)
	{
		return FurnitureManager.Instance.Get(furnitureEntityID).TileType;
	}

	public static void UpdateAllWallMountDitherAlphaControl()
	{
		UpdateWallMountDitherAlphaControl(TileType.WALL_BEHIND);
		UpdateWallMountDitherAlphaControl(TileType.WALL_FRONT);
		UpdateWallMountDitherAlphaControl(TileType.WALL_LEFT);
		UpdateWallMountDitherAlphaControl(TileType.WALL_RIGHT);
	}

	public static void AddFurnitureToWallDitherAlphaControl(int furnitureEID)
	{
		FurnitureEntity furnitureEntity = FurnitureManager.Instance.Get(furnitureEID);
		AddFurnitureToWallDitherAlphaControl(furnitureEntity.trs, furnitureEntity.TileType);
	}

	internal static void AddFurnitureToWallDitherAlphaControl(Transform trs, TileType tileType)
	{
		SceneDitherControl component = DormRoomManager.Instance.GetTrsByType(tileType).GetComponent<SceneDitherControl>();
		if ((bool)component)
		{
			component.AddRenderer(trs.GetComponentsInChildren<Renderer>(includeInactive: true));
		}
	}

	public static void RemoveFurnitureFromWallDitherAlphaControl(int furnitureEID)
	{
		FurnitureEntity furnitureEntity = FurnitureManager.Instance.Get(furnitureEID);
		RemoveFurnitureFromWallDitherAlphaControl(furnitureEntity.trs, furnitureEntity.TileType);
	}

	internal static void RemoveFurnitureFromWallDitherAlphaControl(Transform trs, TileType tileType)
	{
		SceneDitherControl component = DormRoomManager.Instance.GetTrsByType(tileType).GetComponent<SceneDitherControl>();
		if ((bool)component)
		{
			component.RemoveRenderer(trs.GetComponentsInChildren<Renderer>(includeInactive: true));
		}
	}

	public static FurnitureInfo[] GetPlacedFurnitureInfo(bool includeSuit = false)
	{
		FurnitureTag[] array;
		FurnitureTag[] array2;
		FurnitureTag[] array3;
		FurnitureTag[] array4;
		FurnitureTag[] array5;
		if (!includeSuit)
		{
			array = RemovmSuitFurList(DormRoomManager.Instance.GetTrsByType(TileType.WALL_FRONT).GetComponentsInChildren<FurnitureTag>());
			array2 = RemovmSuitFurList(DormRoomManager.Instance.GetTrsByType(TileType.WALL_BEHIND).GetComponentsInChildren<FurnitureTag>());
			array3 = RemovmSuitFurList(DormRoomManager.Instance.GetTrsByType(TileType.WALL_LEFT).GetComponentsInChildren<FurnitureTag>());
			array4 = RemovmSuitFurList(DormRoomManager.Instance.GetTrsByType(TileType.WALL_RIGHT).GetComponentsInChildren<FurnitureTag>());
			array5 = RemovmSuitFurList(DormRoomManager.Instance.GetTrsByType(TileType.FLOOR).GetComponentsInChildren<FurnitureTag>());
		}
		else
		{
			array = RemovmSuitFurList(DormRoomManager.Instance.GetTrsByType(TileType.WALL_FRONT).GetComponentsInChildren<FurnitureTag>(), includeSuitPre: false);
			array2 = RemovmSuitFurList(DormRoomManager.Instance.GetTrsByType(TileType.WALL_BEHIND).GetComponentsInChildren<FurnitureTag>(), includeSuitPre: false);
			array3 = RemovmSuitFurList(DormRoomManager.Instance.GetTrsByType(TileType.WALL_LEFT).GetComponentsInChildren<FurnitureTag>(), includeSuitPre: false);
			array4 = RemovmSuitFurList(DormRoomManager.Instance.GetTrsByType(TileType.WALL_RIGHT).GetComponentsInChildren<FurnitureTag>(), includeSuitPre: false);
			array5 = RemovmSuitFurList(DormRoomManager.Instance.GetTrsByType(TileType.FLOOR).GetComponentsInChildren<FurnitureTag>(), includeSuitPre: false);
		}
		FurnitureInfo[] array6 = new FurnitureInfo[array.Length + array2.Length + array3.Length + array4.Length + array5.Length];
		int index = 0;
		index = DealWithFurnitureInfo(array6, array, index);
		index = DealWithFurnitureInfo(array6, array2, index);
		index = DealWithFurnitureInfo(array6, array3, index);
		index = DealWithFurnitureInfo(array6, array4, index);
		index = DealWithFurnitureInfo(array6, array5, index);
		return array6;
	}

	public static FurnitureInfo[] GetAllPlaceFurSuitInfo()
	{
		List<FurnitureInfo> list = new List<FurnitureInfo>();
		foreach (KeyValuePair<int, FurnitureEntity> mEntity in FurnitureManager.Instance.mEntityS)
		{
			if (mEntity.Value.child.Count > 0)
			{
				FurnitureInfo furnitureInfo = new FurnitureInfo();
				FurnitureTag tag = mEntity.Value.tag;
				if (mEntity.Value.suitChangeFlag || tag.id == 0)
				{
					furnitureInfo.id = mEntity.Value.entityId;
				}
				else
				{
					furnitureInfo.id = tag.id;
				}
				furnitureInfo.oriSuitID = mEntity.Value.oriSuitID;
				TileType tileType = tag.FurnitureEntity.TileType;
				furnitureInfo.tileType = (ushort)tileType;
				furnitureInfo.pos = DormCoordinate.Instance.GetPositionByType(tileType, tag.transform.position);
				furnitureInfo.rotation = DormCoordinate.Instance.GetRotationByType(tileType, tag.transform.localEulerAngles);
				furnitureInfo.state = tag.state;
				list.Add(furnitureInfo);
			}
		}
		FurnitureInfo[] array = new FurnitureInfo[list.Count];
		int num = 0;
		foreach (FurnitureInfo item in list)
		{
			array[num] = item;
			num++;
		}
		return array;
	}

	private static FurnitureTag[] RemovmSuitFurList(FurnitureTag[] furList, bool includeSuitPre = true)
	{
		List<FurnitureTag> list = new List<FurnitureTag>(furList);
		if (includeSuitPre)
		{
			list.RemoveAll((FurnitureTag info) => info.FurnitureEntity.parent != null || info.FurnitureEntity.child.Count > 0);
		}
		else
		{
			list.RemoveAll((FurnitureTag info) => info.FurnitureEntity.child.Count > 0);
		}
		furList = list.ToArray();
		return furList;
	}

	private static int DealWithFurnitureInfo(FurnitureInfo[] furnitureInfoS, FurnitureTag[] furnitureS, int index)
	{
		for (int i = 0; i < furnitureS.Length; i++)
		{
			FurnitureInfo furnitureInfo = new FurnitureInfo();
			FurnitureTag furnitureTag = furnitureS[i];
			furnitureInfo.id = furnitureTag.id;
			TileType tileType = furnitureTag.FurnitureEntity.TileType;
			furnitureInfo.tileType = (ushort)tileType;
			furnitureInfo.pos = DormCoordinate.Instance.GetPositionByType(tileType, furnitureTag.transform.position);
			furnitureInfo.rotation = DormCoordinate.Instance.GetRotationByType(tileType, furnitureTag.transform.localEulerAngles);
			furnitureInfo.state = furnitureTag.state;
			furnitureInfoS[index] = furnitureInfo;
			index++;
		}
		return index;
	}

	public static void SetIsCanEditTag(bool isCanEdit)
	{
		DormRoomManager.Instance.isCanEdit = isCanEdit;
	}

	public static void ChangeCameraMode(int status, bool isNeedInit = false)
	{
		DormCameraManager.Instance.ModifyCameraLookAtByStatus((DormCameraManager.CAMERA_LOOKAT_STATUS)status, isNeedInit);
	}

	public static void SetRoomThemeWall(string materialPath, string meshPath = "")
	{
		DormRoomManager.Instance.SetRoomThemeWall(materialPath, meshPath);
	}

	public static void SetRoomThemeFloor(string gameObjectPath, string extendPath)
	{
		DormRoomManager.Instance.SetRoomThemeFloor(gameObjectPath, extendPath);
	}

	public static void SetRoomThemeBG(string bgPath, string lightPath)
	{
		DormRoomManager.Instance.SetRoomThemeBG(bgPath, lightPath);
	}

	public static void InitJoystick(GameObject stickGo)
	{
		P08JoystickController component = stickGo.GetComponent<P08JoystickController>();
		if (component != null)
		{
			component.Init(Vector3.zero, 0f, DormStickController);
		}
	}

	internal static void SetJoystickControl(Transform roleTrs, Func<DormStickController, bool> OnStartMoving = null, Action<DormStickController> OnStopMoving = null)
	{
		DormStickController obj = DormStickController;
		obj.StartMoving = OnStartMoving;
		obj.StopMoving = OnStopMoving;
		obj.ResetIsMovingStarted();
		if ((bool)DormCameraManager.Instance)
		{
			DormCameraManager.Instance.SetControllRole(roleTrs);
		}
	}

	public static void ResetJoystick(bool triggerOnStop)
	{
		if (DormLuaBridge.dormStickController.IsValueCreated)
		{
			DormStickController dormStickController = DormStickController;
			dormStickController.ResetIsMovingStarted();
			if (triggerOnStop)
			{
				dormStickController.StopMoving?.Invoke(dormStickController);
			}
		}
	}

	public static Vector3? TryGetJoytickInput()
	{
		if (dormStickController.IsValueCreated)
		{
			return DormStickController.InputVec;
		}
		return null;
	}

	public static void SetUIFollow(RectTransform uiFollow, int entityID, string attachPoint)
	{
		DormEntity dormEntity = DormEntityManager.Instance.TryGet(entityID);
		UIFollow component = uiFollow.GetComponent<UIFollow>();
		if ((bool)component && dormEntity != null)
		{
			Transform origin = dormEntity.FindAttachPoint(attachPoint);
			component.origin = origin;
			component.enabled = true;
			component.UpdatePos();
		}
	}

	public static void DisableUIFollow(RectTransform uiFollow)
	{
		UIFollow component = uiFollow.GetComponent<UIFollow>();
		if ((bool)component)
		{
			component.enabled = false;
		}
	}

	public static void SetUIPosByWorldPos(RectTransform ui, Vector3 pos)
	{
		Vector2 screenPoint = RectTransformUtility.WorldToScreenPoint(Camera.main, pos);
		if (RectTransformUtility.ScreenPointToLocalPointInRectangle(ui.parent as RectTransform, screenPoint, Camera.main, out var localPoint))
		{
			ui.localPosition = localPoint;
		}
	}

	public static void GetCamFadeOtherCharaParam(out float start, out float end)
	{
		DormCameraManager instance = DormCameraManager.Instance;
		start = instance.roleFreeLookStartFade;
		end = instance.roleFreeLookEndFade;
	}

	public static void RecordInfoFromDormTag()
	{
		Dictionary<string, int> dictionary = new Dictionary<string, int>();
		foreach (DormTagBase item in DormTagBase.All)
		{
			string key = GetTypeFromNamespace(item.m_namespace);
			if (!dictionary.TryGetValue(key, out var value))
			{
				value = 1;
			}
			if (item.gameObject.activeInHierarchy)
			{
				item.Record(value);
			}
			dictionary[key] = value + 1;
		}
		static string GetTypeFromNamespace(string m_namespace)
		{
			int num = m_namespace.LastIndexOf('.');
			if (num == -1)
			{
				return m_namespace;
			}
			return m_namespace.Substring(num);
		}
	}

	public static bool ActAsClickToEntity(int entityID)
	{
		if (DormEntityManager.Instance.Get(entityID) is DormComplexEntity dormComplexEntity && DormEntityTrigger.PlayerGrabCmdTask.CurDragging == null)
		{
			DormEntityTrigger component = dormComplexEntity.model.GetComponent<DormEntityTrigger>();
			if ((bool)component)
			{
				return component.StartPlayerClickInteract();
			}
		}
		return false;
	}

	public static void PlayDormStory(string timelinePath, int[] actors)
	{
		DormStoryManager.instance.Play(timelinePath, actors);
	}

	public static void DisposeDormStory()
	{
		DormStoryManager.instance.Dispose();
	}

	internal static bool IsPathPointNearBy(Transform p0, Transform p1)
	{
		return Vector3.Distance(p0.position, p1.position) < 0.25f;
	}

	private static void WeldPathSeg(List<Vector3> path, DormPathTag pathTag, ref Transform last)
	{
		Transform transform = pathTag.points[0];
		List<Transform> points = pathTag.points;
		Transform transform2 = points[points.Count - 1];
		if (IsPathPointNearBy(last, transform))
		{
			path.AddRange(pathTag.Skip(1));
			last = transform2;
		}
		else if (IsPathPointNearBy(last, transform2))
		{
			path.AddRange(pathTag.ReversePath().Skip(1));
			last = transform;
		}
	}

	private static CinemachineSmoothPath.Waypoint CalcWayPoint(Transform path, Transform p, Vector3 tangent)
	{
		Vector3 position = path.InverseTransformPoint(p.position);
		tangent = path.InverseTransformDirection(tangent);
		Vector3 axis = Mathf.Sign(Vector3.Dot(tangent, p.forward)) * Vector3.forward;
		Vector3 vector = p.InverseTransformDirection(Vector3.up);
		vector.z = 0f;
		float roll = Vector3.SignedAngle(vector, Vector3.up, axis);
		return new CinemachineSmoothPath.Waypoint
		{
			position = position,
			roll = roll
		};
	}

	private static void InitSmoothPath(this CinemachineSmoothPath path, IEnumerable<Transform> wayPoint, bool isRing)
	{
		Transform[] array = wayPoint.ToArray();
		float num = 0.0625f;
		path.m_Waypoints = new CinemachineSmoothPath.Waypoint[array.Length];
		for (int i = 1; i < array.Length - 1; i++)
		{
			Transform transform = array[i - 1];
			Transform transform2 = array[i + 1];
			Transform p = array[i];
			Vector3 tangent = num * (transform2.position - transform.position);
			path.m_Waypoints[i] = CalcWayPoint(path.transform, p, tangent);
		}
		if (isRing)
		{
			Vector3 tangent2 = num * (array[1].position - array[array.Length - 1].position).normalized;
			Vector3 tangent3 = num * (array[0].position - array[array.Length - 2].position).normalized;
			path.m_Waypoints[0] = CalcWayPoint(path.transform, array[0], tangent2);
			CinemachineSmoothPath.Waypoint[] waypoints = path.m_Waypoints;
			waypoints[waypoints.Length - 1] = CalcWayPoint(path.transform, array[array.Length - 1], tangent3);
		}
		else
		{
			Vector3 tangent4 = num * (array[1].position - array[0].position).normalized;
			Vector3 tangent5 = num * (array[array.Length - 1].position - array[array.Length - 2].position).normalized;
			path.m_Waypoints[0] = CalcWayPoint(path.transform, array[0], tangent4);
			CinemachineSmoothPath.Waypoint[] waypoints2 = path.m_Waypoints;
			waypoints2[waypoints2.Length - 1] = CalcWayPoint(path.transform, array[array.Length - 1], tangent5);
		}
	}

	private static DormPathTag GetPathTag(GameObject obj, string pathTagNamespace = null)
	{
		return obj.GetComponents<DormPathTag>().First((DormPathTag tag) => pathTagNamespace == null || tag.m_namespace == pathTagNamespace);
	}

	public static CinemachinePathBase MergeConnectFurniturePath(int pathStartNode, int[] connectFurnitures, bool isRing, string pathTagNamespace, float wieldPointRange = 1f / 32f, int resolution = 4)
	{
		CinemachineSmoothPath cinemachineSmoothPath = U3DUtil.Get<CinemachineSmoothPath>(FurnitureManager.Instance.Get(pathStartNode).go);
		cinemachineSmoothPath.m_Resolution = resolution;
		cinemachineSmoothPath.m_Looped = isRing;
		DormPathTag pathTag = GetPathTag(FurnitureManager.Instance.Get(connectFurnitures[0]).go, pathTagNamespace);
		DormPathTag pathTag2 = GetPathTag(FurnitureManager.Instance.Get(connectFurnitures[1]).go, pathTagNamespace);
		IEnumerable<Transform> enumerable;
		if (!IsPathPointNearBy(pathTag.points[0], pathTag2.points[0]))
		{
			Transform p = pathTag.points[0];
			List<Transform> points = pathTag2.points;
			if (!IsPathPointNearBy(p, points[points.Count - 1]))
			{
				enumerable = pathTag.points;
				goto IL_00b1;
			}
		}
		enumerable = Enumerable.Reverse(pathTag.points);
		goto IL_00b1;
		IL_00b1:
		foreach (int item in connectFurnitures.Skip(1))
		{
			DormPathTag pathTag3 = GetPathTag(FurnitureManager.Instance.Get(item).go, pathTagNamespace);
			IEnumerable<Transform> enumerable2 = pathTag3.points;
			Transform transform = pathTag3.points[0];
			List<Transform> points2 = pathTag3.points;
			Transform transform2 = points2[points2.Count - 1];
			Transform transform3 = enumerable.Last();
			if (Vector3.Distance(transform3.position, transform2.position) < Vector3.Distance(transform3.position, transform.position))
			{
				enumerable2 = enumerable2.Reverse();
			}
			if (Vector3.Distance(enumerable.Last().position, enumerable2.First().position) <= wieldPointRange)
			{
				enumerable2 = enumerable2.Skip(1);
			}
			enumerable = enumerable.Concat(enumerable2);
		}
		if (isRing && Vector3.Distance(enumerable.Last().position, enumerable.First().position) <= wieldPointRange)
		{
			enumerable = enumerable.SkipLast(1);
		}
		cinemachineSmoothPath.InitSmoothPath(enumerable, isRing);
		cinemachineSmoothPath.InvalidateDistanceCache();
		return cinemachineSmoothPath;
	}

	public static IEnumerable<Transform> ShiftConnectPath(IEnumerable<Transform> path, int shift, bool ringShift = false)
	{
		IEnumerable<Transform> enumerable = path.Skip(shift);
		if (ringShift)
		{
			enumerable = enumerable.Concat(path.Take(shift));
		}
		return enumerable;
	}

	public static float FindClosestPointOnPath(Vector3 worldPos, CinemachinePathBase path)
	{
		return path.FromPathNativeUnits(path.FindClosestPoint(worldPos, 0, -1, 4), CinemachinePathBase.PositionUnits.Distance);
	}

	public static void SetupFurnitureTileEntity(int eid)
	{
		SetupCommonInteractProvider(DormEntityManager.Instance.TryGet(eid));
	}

	internal static void SetupCommonInteractProvider(DormEntity entity)
	{
		if (entity != null)
		{
			CommonEntityInteractProvider commonEntityInteractProvider = U3DUtil.Get<CommonEntityInteractProvider>(entity.model);
			commonEntityInteractProvider.entity = entity;
			CommonProvideInteractArea[] componentsInChildren = commonEntityInteractProvider.transform.GetComponentsInChildren<CommonProvideInteractArea>();
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				componentsInChildren[i].Provider = commonEntityInteractProvider;
			}
		}
	}

	[NoToLua]
	public static void Notify(string luaEvent)
	{
		LuaHelper.GetFunc("Dorm.InvokeEvent")?.Call(luaEvent);
	}

	public static void Notify<T1>(string luaEvent, T1 arg1)
	{
		LuaHelper.GetFunc("Dorm.InvokeEvent")?.Call(luaEvent, arg1);
	}

	public static void Notify<T1, T2>(string luaEvent, T1 arg1, T2 arg2)
	{
		LuaHelper.GetFunc("Dorm.InvokeEvent")?.Call(luaEvent, arg1, arg2);
	}

	public static void Notify<T1, T2, T3>(string luaEvent, T1 arg1, T2 arg2, T3 arg3)
	{
		LuaHelper.GetFunc("Dorm.InvokeEvent")?.Call(luaEvent, arg1, arg2, arg3);
	}

	public static bool CheckSuitEditModeAvailabel(int entityID)
	{
		return FurnitureManager.Instance.CheckCanEnterSuitEditMode(entityID);
	}

	public static void EnterSuitEditMode(int entityID, bool isSuitChangePosition)
	{
		FurnitureEntity furnitureEntity = FurnitureManager.Instance.Get(entityID);
		FurnitureEntity furnitureEntity2 = ((furnitureEntity.child.Count <= 0) ? furnitureEntity.parent : furnitureEntity);
		if (furnitureEntity2 == null)
		{
			return;
		}
		FurnitureManager.Instance.isSuitEidtMode = true;
		FurnitureManager.Instance.isSuitChangePosition = isSuitChangePosition;
		if (isSuitChangePosition)
		{
			FurnitureManager.Instance.suitFurTempPosDic = new Dictionary<int, FurniturePosData>();
			FurniturePosData value = default(FurniturePosData);
			foreach (FurnitureEntity item in furnitureEntity2.child)
			{
				value.editingFurnitureTileTypeTmp = item.TileType;
				value.editingFurnitureForwardTmp = item.trs.forward;
				value.editingFurniturePosTmp = item.trs.position;
				value.editingFurnitureRotationTmp = item.trs.localEulerAngles;
				value.suitEid = furnitureEntity2.entityId;
				FurnitureManager.Instance.suitFurTempPosDic[item.entityId] = value;
			}
		}
		if (furnitureEntity2.oriSuitID != 0)
		{
			FurnitureManager.Instance.isCustomEidtMode = false;
		}
		else
		{
			FurnitureManager.Instance.isCustomEidtMode = true;
		}
		FurnitureManager.Instance.ChangeFurnitureSuitState(furnitureEntity2, FurnitureEntity.FurnitureStatus.mEditing);
		furnitureEntity2.RefreshSuitIsCanPlace();
		if (FurnitureManager.Instance.isCustomEidtMode)
		{
			FurnitureManager.Instance.OpenFurnitureColliderUnlessSuit(flag: true);
		}
		LuaHelper.CallFunction("EnterSuitAllEditMode", furnitureEntity2.id, furnitureEntity2.entityId, furnitureEntity2.oriSuitID);
	}

	public static void ExitSuitEditMode(int suitID)
	{
		FurnitureEntity furnitureEntity = FurnitureManager.Instance.Get(suitID);
		furnitureEntity.AddOrRemoveFurTrsWithSuitPrefab(flag: false);
		FurnitureManager.SetFurnitureColliderAcceptUserInput(furnitureEntity, active: false);
		furnitureEntity.MainColliderTrs.gameObject.layer = DormConst.OBSTACLE_LAYER_ID;
		FurnitureManager.Instance.ClearEditingFurniture();
		DormRoomManager.Instance.EnableWarningMode(v: false);
		FurnitureManager.Instance.ClearEditSuitData();
	}

	public static int GenerateSuitPrefab(int id, bool isPartSuit, int tileType = -1)
	{
		FurnitureEntity furnitureEntity = FurnitureManager.Instance.GenerateSuitFurniture(id, new Vector2(0f, 0f), 0f, (TileType)tileType);
		if (isPartSuit)
		{
			furnitureEntity.oriSuitID = id;
		}
		return furnitureEntity.entityId;
	}

	public static void SetFurniturePosition(int entityID, int tileType, Vector2 pos, float rotation)
	{
		FurnitureEntity furnitureEntity = FurnitureManager.Instance.Get(entityID);
		if (furnitureEntity.child.Count > 0)
		{
			furnitureEntity.AddOrRemoveFurTrsWithSuitPrefab(flag: true);
		}
		TileType tileType2 = (furnitureEntity.TileType = (TileType)tileType);
		furnitureEntity.trs.parent = DormRoomManager.Instance.GetTrsByType(tileType2);
		Vector3 realPositionByType = DormCoordinate.Instance.GetRealPositionByType(tileType2, pos);
		Vector3 localEulerAngles = DormCoordinate.Instance.GetRealRotationByType(tileType2, rotation);
		furnitureEntity.trs.position = realPositionByType;
		furnitureEntity.trs.localEulerAngles = localEulerAngles;
		RoomWallTag roomWallTagByType = DormCoordinate.Instance.GetRoomWallTagByType(tileType2);
		if (roomWallTagByType != null)
		{
			furnitureEntity.trs.forward = roomWallTagByType.transform.forward;
		}
		if (furnitureEntity.child.Count > 0)
		{
			furnitureEntity.AddOrRemoveFurTrsWithSuitPrefab(flag: false);
		}
	}

	public static void FillFurnitureOccupy(int entityID, int tileType)
	{
		FurnitureManager.FillFurnitureOccupy(FurnitureManager.Instance.Get(entityID));
	}

	public static void SetSuitFurTrsFather(int suitID, bool flag = false)
	{
		FurnitureEntity furnitureEntity = FurnitureManager.Instance.Get(suitID);
		if (furnitureEntity.child.Count <= 0)
		{
			return;
		}
		foreach (FurnitureEntity item in furnitureEntity.child)
		{
			if (flag)
			{
				item.trs.parent = furnitureEntity.trs;
			}
			else
			{
				item.trs.parent = DormRoomManager.Instance.GetTrsByType(item.TileType);
			}
		}
	}

	public static void RefreshSuitLenAndWid(int suitID)
	{
		FurnitureEntity furnitureEntity = FurnitureManager.Instance.Get(suitID);
		if (furnitureEntity != null)
		{
			furnitureEntity.ReCalculateWideAndLen();
			bool num = Mathf.RoundToInt(Mathf.Abs(DormCoordinate.Instance.GetRotationByType(furnitureEntity.TileType, furnitureEntity.trs.localEulerAngles) / 90f) % 2f) == 1;
			int width = (int)((num ? furnitureEntity.suitWid : furnitureEntity.suitLen) / 0.25f);
			int height = (int)((num ? furnitureEntity.suitLen : furnitureEntity.suitWid) / 0.25f);
			furnitureEntity.trs.position = DormCoordinate.Instance.FindNearestPosition(furnitureEntity.TileType, furnitureEntity.trs.localPosition, isLimit: true, wallMountLayOnGround: true, width, height);
			furnitureEntity.RefreshSuitIsCanPlace();
		}
	}

	public static void DisassembleFurSuit(int suitID)
	{
		FurnitureEntity furnitureEntity = FurnitureManager.Instance.Get(suitID);
		FurnitureManager.Instance.ChangeFurnitureSuitState(furnitureEntity, FurnitureEntity.FurnitureStatus.mPlaced);
		furnitureEntity.DisassembleFurSuit();
	}

	public static void SetFurInSuitChild(int suitEid, int furEid)
	{
		FurnitureManager.Instance.SetFurInSuitChild(furEid, suitEid);
	}

	public static bool SaveSuitChange()
	{
		if (FurnitureManager.Instance.editSuit != null)
		{
			FurnitureEntity editSuit = FurnitureManager.Instance.editSuit;
			FurnitureManager.Instance.UpdateAllFurnitureInteractArea();
			if (editSuit.isCanPlace)
			{
				FurnitureManager.Instance.ChangeFurnitureSuitState(editSuit, FurnitureEntity.FurnitureStatus.mPlaced);
				if (editSuit.child.Count <= 1)
				{
					FurnitureManager.Instance.SetFurInSuitChild(editSuit.child[0].entityId, editSuit.entityId);
				}
				ExitSuitEditMode(editSuit.entityId);
				if (editSuit.child.Count <= 1)
				{
					RemoveFurniture(editSuit.entityId);
				}
				return true;
			}
		}
		return false;
	}

	public static FurnitureInfo[] GetCustomSuitFurInfo(int suitEid)
	{
		foreach (KeyValuePair<int, FurnitureEntity> mEntity in FurnitureManager.Instance.mEntityS)
		{
			if (mEntity.Value.entityId != suitEid)
			{
				continue;
			}
			FurnitureInfo[] array = new FurnitureInfo[mEntity.Value.child.Count];
			int num = 0;
			foreach (FurnitureEntity item in mEntity.Value.child)
			{
				FurnitureInfo furnitureInfo = new FurnitureInfo();
				FurnitureTag tag = item.tag;
				furnitureInfo.id = tag.id;
				TileType tileType = tag.FurnitureEntity.TileType;
				furnitureInfo.tileType = (ushort)tileType;
				furnitureInfo.pos = DormCoordinate.Instance.GetPositionByType(tileType, tag.transform.position);
				furnitureInfo.rotation = DormCoordinate.Instance.GetRotationByType(tileType, tag.transform.localEulerAngles);
				furnitureInfo.state = tag.state;
				array[num] = furnitureInfo;
				num++;
			}
			return array;
		}
		return new FurnitureInfo[0];
	}

	public static bool RotateSuitFurniture()
	{
		if (FurnitureManager.Instance.editSuit != null)
		{
			FurnitureEntity editSuit = FurnitureManager.Instance.editSuit;
			float rotationByType = DormCoordinate.Instance.GetRotationByType(editSuit.TileType, editSuit.trs.localEulerAngles);
			float num = (360f + rotationByType % 360f) % 360f;
			num = Mathf.Ceil((num + 10f) / 90f) * 90f;
			Vector3 localEulerAngles = DormCoordinate.Instance.GetRealRotationByType(editSuit.TileType, num);
			editSuit.trs.localEulerAngles = localEulerAngles;
			bool flag = Mathf.RoundToInt(Mathf.Abs(DormCoordinate.Instance.GetRotationByType(editSuit.TileType, editSuit.trs.localEulerAngles) / 90f) % 2f) == 1;
			int width = (int)((flag ? editSuit.suitWid : editSuit.suitLen) / 0.25f);
			int height = (int)((flag ? editSuit.suitLen : editSuit.suitWid) / 0.25f);
			editSuit.trs.position = DormCoordinate.Instance.FindNearestPosition(editSuit.TileType, editSuit.trs.localPosition, isLimit: true, wallMountLayOnGround: true, width, height, flag);
			editSuit.RefreshSuitIsCanPlace();
			return true;
		}
		return false;
	}

	public static bool RotateFurnitureSuit(int entityID, float suitRotation)
	{
		FurnitureEntity furnitureEntity = FurnitureManager.Instance.Get(entityID);
		if (furnitureEntity != null)
		{
			furnitureEntity.AddOrRemoveFurTrsWithSuitPrefab(flag: true);
			Vector3 localEulerAngles = DormCoordinate.Instance.GetRealRotationByType(furnitureEntity.TileType, suitRotation);
			furnitureEntity.trs.localEulerAngles = localEulerAngles;
			furnitureEntity.RefreshSuitFurnitureInteractPosVfx();
			furnitureEntity.AddOrRemoveFurTrsWithSuitPrefab(flag: false);
			return true;
		}
		return false;
	}

	public static void SetFurnitureSuitOccupy(int entityID, bool isOccupy)
	{
		FurnitureEntity furnitureEntity = FurnitureManager.Instance.Get(entityID);
		if (furnitureEntity == null || furnitureEntity.child.Count <= 0)
		{
			return;
		}
		foreach (FurnitureEntity item in furnitureEntity.child)
		{
			if (isOccupy)
			{
				FurnitureManager.FillFurnitureOccupy(item);
			}
			else
			{
				FurnitureManager.RemoveFurnitureOccupy(item);
			}
		}
	}

	public static void ChangeSuitColliderState(int suitID, bool flag)
	{
		FurnitureManager.OpenFurnitureColliderUnlessSuit(FurnitureManager.Instance.Get(suitID), flag);
	}

	public static void ChangeFurnitureSuitState(int furnitureEntityID, int state, bool controlOccupy = true)
	{
		FurnitureEntity goodsEntity = FurnitureManager.Instance.Get(furnitureEntityID);
		FurnitureManager.Instance.ChangeFurnitureSuitState(goodsEntity, (FurnitureEntity.FurnitureStatus)state, controlOccupy);
	}

	public static bool CheckFurnitureBelongSuit(int furnitureEntityID, out int suitEID)
	{
		FurnitureEntity furnitureEntity = FurnitureManager.Instance.Get(furnitureEntityID);
		if (furnitureEntity.parent == null)
		{
			suitEID = 0;
			return false;
		}
		suitEID = furnitureEntity.parent.entityId;
		return true;
	}

	public static bool CheckFurnitureBelongSuit(int furnitureEntityID)
	{
		int suitEID;
		return CheckFurnitureBelongSuit(furnitureEntityID, out suitEID);
	}

	public static bool CancelSuitChange(out int cancledEditing)
	{
		FurnitureEntity editSuit = FurnitureManager.Instance.editSuit;
		if (editSuit != null)
		{
			if (!FurnitureManager.Instance.isSuitChangePosition)
			{
				cancledEditing = editSuit.entityId;
				ExitSuitEditMode(editSuit.entityId);
				return true;
			}
			editSuit.suitChangeFlag = false;
			FurnitureEntity editingFurniture = FurnitureManager.Instance.editingFurniture;
			foreach (KeyValuePair<int, FurniturePosData> item in FurnitureManager.Instance.suitFurTempPosDic)
			{
				FurnitureEntity furnitureEntity = FurnitureManager.Instance.Get(item.Key);
				furnitureEntity.trs.parent = DormRoomManager.Instance.GetTrsByType(furnitureEntity.TileType);
				if (furnitureEntity.furnitureStatus == FurnitureEntity.FurnitureStatus.mPlaced)
				{
					FurnitureManager.RemoveFurnitureOccupy(furnitureEntity);
				}
				furnitureEntity.TileType = FurnitureManager.Instance.suitFurTempPosDic[furnitureEntity.entityId].editingFurnitureTileTypeTmp;
				furnitureEntity.trs.forward = FurnitureManager.Instance.suitFurTempPosDic[furnitureEntity.entityId].editingFurnitureForwardTmp;
				furnitureEntity.trs.position = FurnitureManager.Instance.suitFurTempPosDic[furnitureEntity.entityId].editingFurniturePosTmp;
				furnitureEntity.trs.localEulerAngles = FurnitureManager.Instance.suitFurTempPosDic[furnitureEntity.entityId].editingFurnitureRotationTmp;
				if (FurnitureManager.Instance.suitFurTempPosDic[furnitureEntity.entityId].suitEid == 0)
				{
					if (furnitureEntity.parent != null && furnitureEntity.parent.entityId == editSuit.entityId)
					{
						furnitureEntity.parent = null;
						editSuit.child.Remove(furnitureEntity);
					}
					FurnitureManager.Instance.ChangeFurnitureState(furnitureEntity, FurnitureEntity.FurnitureStatus.mPlaced);
				}
				else if (furnitureEntity.parent == null)
				{
					furnitureEntity.parent = editSuit;
					editSuit.child.Add(furnitureEntity);
				}
				if (furnitureEntity.entityId != editingFurniture.entityId)
				{
					FurnitureManager.FillFurnitureOccupy(furnitureEntity);
				}
			}
			if (editingFurniture != null)
			{
				editingFurniture.TileType = FurnitureManager.Instance.editingFurnitureTileTypeTmp;
				editingFurniture.trs.forward = FurnitureManager.Instance.editingFurnitureForwardTmp;
				editingFurniture.trs.position = FurnitureManager.Instance.editingFurniturePosTmp;
				editingFurniture.trs.localEulerAngles = FurnitureManager.Instance.editingFurnitureRotationTmp;
				FurnitureManager.FillFurnitureOccupy(editingFurniture);
				if (editSuit.child.Count <= 1)
				{
					FurnitureManager.Instance.SetFurInSuitChild(editSuit.child[0].entityId, editSuit.entityId);
				}
				FurnitureManager.Instance.ChangeFurnitureSuitState(editSuit, FurnitureEntity.FurnitureStatus.mPlaced, controlOccupy: false);
				ExitSuitEditMode(editSuit.entityId);
				if (editSuit.child.Count <= 1)
				{
					RemoveFurniture(editSuit.entityId);
				}
				else
				{
					editSuit.trs.localEulerAngles = FurnitureManager.Instance.editSuitRotateTemp;
				}
			}
		}
		cancledEditing = 0;
		return false;
	}

	public static int StorageSuitFurniture(int[] furEidList)
	{
		furEidList = new int[0];
		if (FurnitureManager.Instance.editSuit != null)
		{
			FurnitureEntity editSuit = FurnitureManager.Instance.editSuit;
			ExitSuitEditMode(editSuit.entityId);
			int[] array = new int[editSuit.child.Count];
			int num = 0;
			foreach (FurnitureEntity item in editSuit.child)
			{
				array[num] = item.entityId;
				num++;
			}
			furEidList = array;
			return editSuit.entityId;
		}
		return -1;
	}

	public static void ChangeAllFurColliderState(bool flag)
	{
		FurnitureManager.Instance.OpenFurnitureColliderUnlessSuit(flag);
	}

	public static void ClearAllSuitEntity()
	{
		List<int> list = new List<int>();
		foreach (KeyValuePair<int, FurnitureEntity> mEntity in FurnitureManager.Instance.mEntityS)
		{
			if (mEntity.Value.child.Count > 0)
			{
				list.Add(mEntity.Value.entityId);
			}
		}
		foreach (int item in list)
		{
			FurnitureManager.Instance.RemoveFurniture(item, isNeedRemoveOccupy: false);
		}
	}

	public static Vector2 GetFurnitureSuitPosAndRotate(int furnitureEntityID, out float suitRotation)
	{
		FurnitureEntity furnitureEntity = FurnitureManager.Instance.Get(furnitureEntityID);
		Vector2 positionByType = DormCoordinate.Instance.GetPositionByType(furnitureEntity.TileType, furnitureEntity.trs.position);
		suitRotation = DormCoordinate.Instance.GetRotationByType(furnitureEntity.TileType, furnitureEntity.trs.localEulerAngles);
		return positionByType;
	}

	public static FurnitureInfo[] GetSuitFurInfoList(int entityID, out bool changeFlag)
	{
		FurnitureEntity furnitureEntity = FurnitureManager.Instance.Get(entityID);
		changeFlag = false;
		if (furnitureEntity.child != null)
		{
			FurnitureInfo[] array = new FurnitureInfo[furnitureEntity.child.Count];
			int num = 0;
			{
				foreach (FurnitureEntity item in furnitureEntity.child)
				{
					FurnitureInfo furnitureInfo = new FurnitureInfo();
					FurnitureTag tag = item.tag;
					furnitureInfo.id = tag.id;
					TileType tileType = tag.FurnitureEntity.TileType;
					furnitureInfo.tileType = (ushort)tileType;
					furnitureInfo.pos = DormCoordinate.Instance.GetPositionByType(tileType, tag.transform.position);
					furnitureInfo.rotation = DormCoordinate.Instance.GetRotationByType(tileType, tag.transform.localEulerAngles);
					furnitureInfo.state = tag.state;
					array[num] = furnitureInfo;
					num++;
					if (item.isChangePosition)
					{
						changeFlag = true;
					}
				}
				return array;
			}
		}
		return new FurnitureInfo[0];
	}

	public static int[] GetSuitFurEidList(int suitEid)
	{
		FurnitureEntity furnitureEntity = FurnitureManager.Instance.Get(suitEid);
		int[] array = new int[furnitureEntity.child.Count];
		int num = 0;
		foreach (FurnitureEntity item in furnitureEntity.child)
		{
			array[num] = item.entityId;
			num++;
		}
		return array;
	}

	public static void ChangeEditSuit(int suitEid)
	{
		FurnitureEntity editSuit = FurnitureManager.Instance.Get(suitEid);
		FurnitureManager.Instance.editSuit = editSuit;
	}

	public static bool GetSuitOrFurnitureCanPlace(int eid)
	{
		return FurnitureManager.Instance.Get(eid).isCanPlace;
	}

	public static int[] GetCanRestoreFur(int furID, int num)
	{
		List<int> list = new List<int>();
		foreach (KeyValuePair<int, FurnitureEntity> mEntity in FurnitureManager.Instance.mEntityS)
		{
			if (mEntity.Value.parent == null && mEntity.Value.child.Count == 0 && mEntity.Value.id == furID && num > 0)
			{
				list.Add(mEntity.Value.entityId);
				num--;
			}
		}
		return list.ToArray();
	}

	public static void EnterCustomeEditMode(int furnitureEntityID, int suitID = 0)
	{
		FurnitureEntity furnitureEntity = FurnitureManager.Instance.Get(furnitureEntityID);
		int num;
		if (furnitureEntity.parent == null)
		{
			num = GenerateSuitPrefab(suitID, isPartSuit: false, (int)furnitureEntity.TileType);
			FurnitureManager.Instance.SetFurInSuitChild(furnitureEntityID, num);
		}
		else
		{
			num = furnitureEntity.parent.entityId;
		}
		EnterSuitEditMode(num, isSuitChangePosition: true);
	}

	public static void SavePhotoToWebServer(Sprite sprite, string path, string uidSign, Action<string> func)
	{
		string text = TextureToBase64(sprite.texture);
		string json = JsonUtility.ToJson(new ReportImageData
		{
			resource = "data:image/png;base64," + text,
			uidSign = uidSign,
			uploadResourceType = "image"
		});
		DormRoomManager.Instance.UploadImageToServer(json, path, func);
	}

	private static string TextureToBase64(Texture2D texture)
	{
		return Convert.ToBase64String(texture.EncodeToPNG());
	}
}
