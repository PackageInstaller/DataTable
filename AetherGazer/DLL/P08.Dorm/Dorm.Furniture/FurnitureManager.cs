using System;
using System.Collections.Generic;
using System.Linq;
using Dorm.Character;
using UnityEngine;

namespace Dorm.Furniture;

public class FurnitureManager
{
	private static FurnitureManager sInstance;

	public Dictionary<int, FurnitureEntity> mEntityS;

	public FurnitureEntity editingFurniture;

	public TileType editingFurnitureTileTypeTmp;

	public Vector3 editingFurnitureForwardTmp;

	public Vector3 editingFurniturePosTmp;

	public Vector3 editingFurnitureRotationTmp;

	public bool isChangePosition;

	public static Action<FurnitureEntity> OnFillFurnitureOccupy;

	public static Action<FurnitureEntity> OnRemoveFurnitureOccupy;

	private static readonly int checkLayer = -5 & ~DormConst.GROUND_LAYER_MASK & ~DormConst.CHARA_LAYER_MASK;

	private const string INTERACT_POS_AVAILABLE_HIGHLIGHT_VFX_TYPE = "available_interact_pos";

	private const string INTERACT_POS_BLOCKED_HIGHLIGHT_VFX_TYPE = "blocked_interact_pos";

	public static bool showAllInteractAreaPosVfx;

	private static Dictionary<int, IEnumerable<InteractAction>> displayPosActions = new Dictionary<int, IEnumerable<InteractAction>>();

	private static List<Renderer> availableVfxs = new List<Renderer>();

	private static List<Renderer> blockedVfxs = new List<Renderer>();

	public Dictionary<int, FurniturePosData> suitFurTempPosDic;

	public bool isSuitEidtMode;

	public bool isCustomEidtMode;

	public bool isSuitChangePosition;

	public FurnitureEntity editSuit;

	public Vector3 editSuitRotateTemp;

	public Vector3 editSuitForwardTmp;

	public Vector3 editSuitPosTmp;

	public static FurnitureManager Instance
	{
		get
		{
			if (sInstance == null)
			{
				sInstance = new FurnitureManager();
			}
			return sInstance;
		}
	}

	public void Init()
	{
		mEntityS = new Dictionary<int, FurnitureEntity>();
	}

	public void AddFurnitureEntity(FurnitureEntity goodsEntity)
	{
		if (mEntityS == null)
		{
			mEntityS = new Dictionary<int, FurnitureEntity>();
		}
		mEntityS.Add(goodsEntity.entityId, goodsEntity);
	}

	public FurnitureEntity Get(int furnitureEntityID)
	{
		return mEntityS[furnitureEntityID];
	}

	public static FurnitureTag SetupFurnitureTag(FurnitureEntity goodsEntity)
	{
		FurnitureTag component = goodsEntity.go.GetComponent<FurnitureTag>();
		if (component != null)
		{
			component.FurnitureEntity = goodsEntity;
			goodsEntity.tag = component;
		}
		return component;
	}

	internal FurnitureEntity MakeFurniture(DormEntity entity)
	{
		FurnitureEntity furnitureEntity = new FurnitureEntity();
		int id = entity.id;
		furnitureEntity.entityId = id;
		furnitureEntity.go = entity.model;
		furnitureEntity.trs = entity.ModelTrs;
		furnitureEntity.interactAreas = furnitureEntity.go.GetComponentsInChildren<IProvideInteractArea>();
		BindFurnitureEventTrigger(furnitureEntity);
		AddFurnitureEntity(furnitureEntity);
		FurnitureTag interactProvider = SetupFurnitureTag(furnitureEntity);
		entity.interactProvider = interactProvider;
		return furnitureEntity;
	}

	public FurnitureEntity GenerateFurniture(string prefabPath, bool complex)
	{
		DormEntity dormEntity = DormEntityManager.Instance.SpawnEntityInternal(prefabPath, null, complex, pooled: false);
		dormEntity.needDestoryModelOnDispose = false;
		return MakeFurniture(dormEntity);
	}

	private void BindFurnitureEventTrigger(FurnitureEntity goodsEntity)
	{
		FurnitureTag component = goodsEntity.go.GetComponent<FurnitureTag>();
		if (component == null)
		{
			Debug.LogError(goodsEntity.id + "没有正确设置tag脚本");
		}
		Transform mainColliderTrs = component.MainColliderTrs;
		if (mainColliderTrs != null)
		{
			U3DUtil.Get<FurnitureEventTrigger>(mainColliderTrs.gameObject).goodsEntity = goodsEntity;
		}
	}

	public static void FillFurnitureOccupy(FurnitureEntity furniture)
	{
		OnFillFurnitureOccupy?.Invoke(furniture);
	}

	public static void RemoveFurnitureOccupy(FurnitureEntity furniture)
	{
		OnRemoveFurnitureOccupy?.Invoke(furniture);
	}

	public void RemoveFurniture(FurnitureEntity furnitureEntity, bool isNeedRemoveOccupy = true)
	{
		if (isNeedRemoveOccupy)
		{
			_ = furnitureEntity.trs.localEulerAngles;
			if (furnitureEntity.parent != null)
			{
				_ = furnitureEntity.parent.trs.localEulerAngles;
			}
			RemoveFurnitureOccupy(furnitureEntity);
		}
		DormEntityManager.Instance.RemoveEntity(furnitureEntity.entityId);
		mEntityS.Remove(furnitureEntity.entityId);
		UnityEngine.Object.DestroyImmediate(furnitureEntity.go);
	}

	public bool RemoveFurniture(int furnitrueEid, bool isNeedRemoveOccupy = true)
	{
		if (mEntityS.TryGetValue(furnitrueEid, out var value))
		{
			RemoveFurniture(value, isNeedRemoveOccupy);
			return true;
		}
		return false;
	}

	public void MuteOtherFurniture(int entityId)
	{
		foreach (KeyValuePair<int, FurnitureEntity> mEntity in mEntityS)
		{
			if (mEntity.Key != entityId)
			{
				OpenFurnitureColliderUnlessSuit(mEntity.Value, flag: false);
			}
		}
	}

	public void OpenFurnitureCollider()
	{
		foreach (KeyValuePair<int, FurnitureEntity> mEntity in mEntityS)
		{
			OpenFurnitureColliderUnlessSuit(mEntity.Value, flag: true);
		}
	}

	public void ClearEditingFurniture()
	{
		if (editingFurniture != null)
		{
			editingFurniture = null;
			editingFurnitureTileTypeTmp = TileType.NONE;
			editingFurnitureForwardTmp = Vector3.zero;
			editingFurniturePosTmp = Vector3.zero;
			editingFurnitureRotationTmp = Vector3.zero;
			isChangePosition = false;
			OpenFurnitureCollider();
		}
	}

	private static void UpdateInteractActive(FurnitureEntity entity)
	{
		if (!IsNotFurnitureSuitObj(entity))
		{
			return;
		}
		SetFurnitureColliderActive(entity, active: false);
		IProvideInteractArea[] interactAreas = entity.interactAreas;
		foreach (IProvideInteractArea provideInteractArea in interactAreas)
		{
			Behaviour behaviour = provideInteractArea as Behaviour;
			BoxCollider boxCollider = (provideInteractArea.Area ? provideInteractArea.Area : behaviour.GetComponent<BoxCollider>());
			if ((bool)boxCollider)
			{
				Vector3 center = boxCollider.transform.TransformPoint(boxCollider.center);
				behaviour.enabled = !Physics.CheckBox(center, 0.5f * boxCollider.size, boxCollider.transform.rotation, checkLayer, QueryTriggerInteraction.Ignore);
			}
			else
			{
				behaviour.enabled = false;
			}
		}
		SetFurnitureColliderActive(entity, active: true);
	}

	internal void UpdateAllFurnitureInteractArea()
	{
		foreach (FurnitureEntity value in mEntityS.Values)
		{
			UpdateInteractActive(value);
		}
	}

	internal static void SetFurnitureColliderAcceptUserInput(FurnitureEntity entity, bool active)
	{
		if (active)
		{
			entity.MainColliderTrs.gameObject.layer = LayerMask.NameToLayer("Default");
		}
		else
		{
			entity.MainColliderTrs.gameObject.layer = DormConst.OBSTACLE_LAYER_ID;
		}
	}

	internal static void SetFurnitureColliderActive(FurnitureEntity entity, bool active)
	{
		Collider[] components = entity.MainColliderTrs.GetComponents<Collider>();
		for (int i = 0; i < components.Length; i++)
		{
			components[i].enabled = active;
		}
	}

	public void ChangeFurnitureState(FurnitureEntity goodsEntity, FurnitureEntity.FurnitureStatus furnitureStatus, bool ignoreRefreshCanPlace = false)
	{
		DormEntityManager.SetHighlighted(goodsEntity.entityId, furnitureStatus == FurnitureEntity.FurnitureStatus.mEditing);
		if (goodsEntity.furnitureStatus == furnitureStatus)
		{
			return;
		}
		goodsEntity.furnitureStatus = furnitureStatus;
		Transform mainColliderTrs = goodsEntity.MainColliderTrs;
		switch (furnitureStatus)
		{
		case FurnitureEntity.FurnitureStatus.mPlaced:
			ChangeFurnitureRenderType(goodsEntity, FurnitureRenderType.mHide);
			mainColliderTrs.localPosition = DormConst.POS_PLACED[(int)goodsEntity.TileType];
			RemoveAllInteractPosVfx(goodsEntity);
			break;
		case FurnitureEntity.FurnitureStatus.mEditing:
			mainColliderTrs.localPosition = DormConst.POS_EDIT[(int)goodsEntity.TileType];
			if (!isSuitEidtMode)
			{
				editingFurniture = goodsEntity;
				MuteOtherFurniture(goodsEntity.entityId);
			}
			AddVfxForEachInteractPos(goodsEntity);
			if (!ignoreRefreshCanPlace)
			{
				RefreshIsCanPlace(goodsEntity);
			}
			RefreshFurnitureInteractPosVfx(goodsEntity);
			break;
		case FurnitureEntity.FurnitureStatus.mHanging:
			break;
		}
	}

	private static Transform GetActionPosAttachTo(InteractAction action, DormEntity entity)
	{
		if (!action.interactPos)
		{
			return entity.FindAttachPoint("gua_fx_interaction");
		}
		return action.interactPos;
	}

	private static void AddVfxForEachInteractPos(DormEntity entity, IEnumerable<InteractAction> actions)
	{
		if (actions == null || !actions.Any())
		{
			return;
		}
		displayPosActions[entity.id] = actions;
		HashSet<Transform> hashSet = new HashSet<Transform>();
		foreach (InteractAction action in actions)
		{
			Transform actionPosAttachTo = GetActionPosAttachTo(action, entity);
			if (!hashSet.Contains(actionPosAttachTo))
			{
				hashSet.Add(actionPosAttachTo);
				EntityVfxController value = entity.VfxController.Value;
				string efxPath = (action.interactPos ? "Dorm/Effect/houzhai/fx_pos_interact_available" : "Dorm/Effect/houzhai/fx_furniture_interact_available");
				string efxPath2 = (action.interactPos ? "Dorm/Effect/houzhai/fx_pos_interact_blocked" : "Dorm/Effect/houzhai/fx_furniture_interact_blocked");
				value.PlayEffect("available_interact_pos", efxPath, actionPosAttachTo, -1f, EEffectQuality.Low);
				value.PlayEffect("blocked_interact_pos", efxPath2, actionPosAttachTo, -1f, EEffectQuality.Low);
			}
		}
	}

	private static void AddVfxForEachInteractPos(FurnitureEntity goodsEntity)
	{
		IEnumerable<InteractAction> enumerable = goodsEntity.tag.Actions ?? Enumerable.Empty<InteractAction>();
		if (showAllInteractAreaPosVfx && goodsEntity.interactAreas != null)
		{
			enumerable = enumerable.Union(goodsEntity.interactAreas.SelectMany((IProvideInteractArea area) => area.Actions));
		}
		AddVfxForEachInteractPos(goodsEntity.entity, enumerable);
	}

	private static void RemoveAllInteractPosVfx(FurnitureEntity goodsEntity)
	{
		EntityVfxController value = goodsEntity.entity.VfxController.Value;
		value.ClearAllVisualEfx("available_interact_pos");
		value.ClearAllVisualEfx("blocked_interact_pos");
		displayPosActions[goodsEntity.entityId] = null;
		availableVfxs.Clear();
		blockedVfxs.Clear();
	}

	internal static void RefreshFurnitureInteractPosVfx(FurnitureEntity goodsEntity)
	{
		displayPosActions.TryGetValue(goodsEntity.entityId, out var value);
		if (value == null || !value.Any())
		{
			return;
		}
		EntityVfxController value2 = goodsEntity.entity.VfxController.Value;
		Dictionary<Transform, bool> dictionary = new Dictionary<Transform, bool>();
		foreach (InteractAction item in value)
		{
			Transform actionPosAttachTo = GetActionPosAttachTo(item, goodsEntity.entity);
			dictionary.TryGetValue(actionPosAttachTo, out var value3);
			if (!value3)
			{
				dictionary[actionPosAttachTo] = goodsEntity.ActionPosIsNotBlocked(item.interactPos, item.exitPos);
			}
		}
		foreach (EffectController item2 in value2.GetVisualEfx("available_interact_pos"))
		{
			Transform vfxLinkedTrs = value2.GetVfxLinkedTrs(item2);
			dictionary.TryGetValue(vfxLinkedTrs, out var value4);
			item2.GetComponentsInChildren(includeInactive: true, availableVfxs);
			foreach (Renderer availableVfx in availableVfxs)
			{
				availableVfx.enabled = value4;
			}
		}
		foreach (EffectController item3 in value2.GetVisualEfx("blocked_interact_pos"))
		{
			Transform vfxLinkedTrs2 = value2.GetVfxLinkedTrs(item3);
			dictionary.TryGetValue(vfxLinkedTrs2, out var value5);
			item3.GetComponentsInChildren(includeInactive: true, blockedVfxs);
			foreach (Renderer blockedVfx in blockedVfxs)
			{
				blockedVfx.enabled = !value5;
			}
		}
	}

	public bool RefreshIsCanPlace(FurnitureEntity goodsEntity)
	{
		bool flag = IsFurnitureCanPlace(goodsEntity);
		RefreshIsCanPlace(goodsEntity, flag);
		DormRoomManager.Instance.EnableWarningMode(!flag);
		return flag;
	}

	public bool RefreshIsCanPlace(FurnitureEntity goodsEntity, bool isCanPlace)
	{
		if (isCanPlace)
		{
			ChangeFurnitureRenderType(goodsEntity, FurnitureRenderType.mEnabled);
		}
		else
		{
			ChangeFurnitureRenderType(goodsEntity, FurnitureRenderType.mDisabled);
		}
		goodsEntity.isCanPlace = isCanPlace;
		return isCanPlace;
	}

	public bool IsFurnitureCanPlace(FurnitureEntity goodsEntity)
	{
		Vector3 localEulerAngles = goodsEntity.trs.localEulerAngles;
		if (goodsEntity.parent != null && isSuitEidtMode && goodsEntity.trs.parent == goodsEntity.parent.trs)
		{
			localEulerAngles += goodsEntity.parent.trs.localEulerAngles;
		}
		float rotationByType = DormCoordinate.Instance.GetRotationByType(goodsEntity.TileType, localEulerAngles);
		return DormCoordinate.Instance.GetIsAvailable(goodsEntity.TileType, goodsEntity.trs.position, goodsEntity.width, goodsEntity.height, rotationByType, goodsEntity.depth);
	}

	public void ChangeFurnitureRenderType(FurnitureEntity goodsEntity, FurnitureRenderType renderType)
	{
		goodsEntity.renderType = renderType;
		goodsEntity.tag.OnSetFootprintState(renderType);
	}

	public void ClearAllEntityS()
	{
		foreach (FurnitureEntity value in mEntityS.Values)
		{
			RemoveFurniture(value, isNeedRemoveOccupy: false);
		}
		mEntityS.Clear();
	}

	public void ShutDown()
	{
		mEntityS.Clear();
		ClearEditingFurniture();
		OnFillFurnitureOccupy = (OnRemoveFurnitureOccupy = null);
	}

	public void DestorySuitEntity(int suitEid)
	{
	}

	public void ChangeFurnitureSuitState(FurnitureEntity goodsEntity, FurnitureEntity.FurnitureStatus furnitureStatus, bool controlOccupy = true)
	{
		if (goodsEntity.furnitureStatus == furnitureStatus)
		{
			return;
		}
		goodsEntity.furnitureStatus = furnitureStatus;
		GameObject gameObject = goodsEntity.MainColliderTrs.gameObject;
		switch (furnitureStatus)
		{
		case FurnitureEntity.FurnitureStatus.mPlaced:
			if (goodsEntity.child.Count > 0)
			{
				foreach (FurnitureEntity item in goodsEntity.child)
				{
					if (controlOccupy)
					{
						FillFurnitureOccupy(item);
					}
					ChangeFurnitureState(item, FurnitureEntity.FurnitureStatus.mPlaced);
				}
			}
			goodsEntity.go.GetComponent<BoxCollider>().enabled = false;
			break;
		case FurnitureEntity.FurnitureStatus.mEditing:
			MuteOtherFurniture(goodsEntity.entityId);
			if (goodsEntity.child.Count > 0)
			{
				foreach (FurnitureEntity item2 in goodsEntity.child)
				{
					if (controlOccupy)
					{
						RemoveFurnitureOccupy(item2);
					}
					ChangeFurnitureState(item2, FurnitureEntity.FurnitureStatus.mEditing);
				}
			}
			goodsEntity.ReCalculateWideAndLen();
			editSuit = goodsEntity;
			editSuitRotateTemp = goodsEntity.trs.localEulerAngles;
			goodsEntity.go.GetComponent<BoxCollider>().enabled = true;
			gameObject.layer = LayerMask.NameToLayer("Default");
			break;
		case FurnitureEntity.FurnitureStatus.mHanging:
			break;
		}
	}

	public FurnitureEntity GenerateSuitFurniture(int id, Vector2 pos, float rotation, TileType tileType = TileType.NONE)
	{
		GameObject suitObject = DormRoomManager.Instance.SuitObject;
		if (suitObject != null)
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(suitObject);
			gameObject.layer = DormConst.GROUND_LAYER_ID;
			gameObject.SetActive(value: true);
			DormEntityManager.Instance.MakeModelEntity(gameObject.transform, out var entity);
			entity.needDestoryModelOnDispose = true;
			FurnitureEntity furnitureEntity = MakeFurniture(entity);
			furnitureEntity.tag.id = id;
			furnitureEntity.trs.parent = DormRoomManager.Instance.GetTrsByType(tileType);
			furnitureEntity.TileType = tileType;
			furnitureEntity.trs.position = DormCoordinate.Instance.GetRealPositionByType(tileType, pos);
			furnitureEntity.trs.localEulerAngles = DormCoordinate.Instance.GetRealRotationByType(tileType, rotation);
			RoomWallTag roomWallTagByType = DormCoordinate.Instance.GetRoomWallTagByType(tileType);
			if (roomWallTagByType != null)
			{
				furnitureEntity.trs.forward = roomWallTagByType.transform.forward;
			}
			return furnitureEntity;
		}
		Debug.LogError("GenerateSuitFurniture But suitGo is NULL!");
		return null;
	}

	public bool SetFurInSuitChild(int furEid, int suitEid, bool setTrsParent = false)
	{
		FurnitureEntity furnitureEntity = Instance.Get(furEid);
		FurnitureEntity furnitureEntity2 = Instance.Get(suitEid);
		if (furnitureEntity.parent == null)
		{
			furnitureEntity.parent = furnitureEntity2;
			furnitureEntity2.child.Add(furnitureEntity);
			if (isCustomEidtMode)
			{
				RemoveFurnitureOccupy(furnitureEntity);
				if (setTrsParent)
				{
					furnitureEntity.trs.parent = furnitureEntity2.trs;
				}
				Instance.ChangeFurnitureState(furnitureEntity, FurnitureEntity.FurnitureStatus.mEditing);
			}
			return true;
		}
		if (furnitureEntity.parent.entityId == suitEid)
		{
			furnitureEntity.parent = null;
			furnitureEntity.trs.parent = DormRoomManager.Instance.GetTrsByType(furnitureEntity.TileType);
			furnitureEntity2.child.Remove(furnitureEntity);
			if (isCustomEidtMode)
			{
				FillFurnitureOccupy(furnitureEntity);
				Instance.ChangeFurnitureState(furnitureEntity, FurnitureEntity.FurnitureStatus.mPlaced);
			}
			return false;
		}
		return false;
	}

	internal static bool IsNotFurnitureSuitObj(FurnitureEntity furnitureEntity)
	{
		return furnitureEntity.child.Count == 0;
	}

	public static void OpenFurnitureColliderUnlessSuit(FurnitureEntity item, bool flag)
	{
		if (IsNotFurnitureSuitObj(item))
		{
			SetFurnitureColliderAcceptUserInput(item, flag);
		}
	}

	public void OpenFurnitureColliderUnlessSuit(bool flag)
	{
		foreach (KeyValuePair<int, FurnitureEntity> mEntity in mEntityS)
		{
			OpenFurnitureColliderUnlessSuit(mEntity.Value, flag);
		}
	}

	public void ClearEditSuitData()
	{
		editSuit = null;
		suitFurTempPosDic = null;
		editSuitRotateTemp = Vector3.zero;
		isChangePosition = false;
		isSuitEidtMode = false;
		isCustomEidtMode = false;
	}

	public bool CheckCanEnterSuitEditMode(int furnitureEntityID)
	{
		FurnitureEntity furnitureEntity = Get(furnitureEntityID);
		RefreshIsCanPlace(furnitureEntity);
		if (furnitureEntity.isCanPlace)
		{
			return true;
		}
		return false;
	}
}
