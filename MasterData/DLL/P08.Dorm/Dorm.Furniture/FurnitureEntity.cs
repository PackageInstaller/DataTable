using System;
using System.Collections.Generic;
using Dorm.Character;
using UnityEngine;

namespace Dorm.Furniture;

public class FurnitureEntity
{
	public enum FurnitureStatus
	{
		mHanging,
		mPlaced,
		mEditing
	}

	public int entityId;

	public GameObject go;

	public Transform trs;

	public FurnitureEntity parent;

	public List<FurnitureEntity> child = new List<FurnitureEntity>();

	public FurnitureStatus furnitureStatus;

	public FurnitureRenderType renderType;

	public bool isCanPlace;

	public bool isChangePosition;

	internal IProvideInteractArea[] interactAreas;

	internal FurnitureTag tag;

	public float suitLen;

	public float suitWid;

	public bool suitChangeFlag;

	public int oriSuitID;

	public bool isDrag;

	internal DormEntity entity => DormEntityManager.Instance?.TryGet(entityId);

	public int id => tag.id;

	public int width => tag.Size.x;

	public int depth => tag.Size.z;

	public int height => tag.Size.y;

	public TileType TileType
	{
		get
		{
			return tag.tileType;
		}
		set
		{
			tag.tileType = value;
			tag.OnSetTileType(value);
		}
	}

	public bool forceLayOnGround => tag.forceLayOnGrount;

	public bool WallMountLayOnGround
	{
		get
		{
			if (DormLuaBridge.IsWallTileType(TileType))
			{
				return forceLayOnGround;
			}
			return false;
		}
	}

	public Transform MainColliderTrs => tag.colliderTrs;

	public bool CheckIsHide()
	{
		TileType curFurnitureTileType = DormLuaBridge.GetCurFurnitureTileType(entityId);
		if ((bool)DormRoomManager.Instance)
		{
			SceneDitherControl sceneDitherByType = DormRoomManager.Instance.GetSceneDitherByType(curFurnitureTileType);
			if ((bool)sceneDitherByType)
			{
				return (double)sceneDitherByType.DitherAlpha < 0.98;
			}
		}
		return false;
	}

	public bool ActionPosIsNotBlocked(Transform interactPos, Transform exitPos, float radius = 0.25f, float height = 1f)
	{
		return IInteractProvider.ActionPosIsNotBlocked(MainColliderTrs, interactPos, exitPos, radius, height);
	}

	internal FurnitureConnectInterace ConnectReady(FurnitureEntity entity2, out FurnitureConnectInterace otherConnectedInterface)
	{
		FurnitureConnectInterace[] componentsInChildren = tag.transform.GetComponentsInChildren<FurnitureConnectInterace>();
		FurnitureConnectInterace[] componentsInChildren2 = entity2.tag.transform.GetComponentsInChildren<FurnitureConnectInterace>();
		otherConnectedInterface = null;
		FurnitureConnectInterace[] array = componentsInChildren;
		foreach (FurnitureConnectInterace furnitureConnectInterace in array)
		{
			FurnitureConnectInterace[] array2 = componentsInChildren2;
			foreach (FurnitureConnectInterace furnitureConnectInterace2 in array2)
			{
				if (furnitureConnectInterace.ConnectReady(furnitureConnectInterace2))
				{
					otherConnectedInterface = furnitureConnectInterace2;
					return furnitureConnectInterace;
				}
			}
		}
		return null;
	}

	public void RefreshSuitIsCanPlace()
	{
		bool canPlace = true;
		if (child.Count > 0)
		{
			foreach (FurnitureEntity item in child)
			{
				if (!FurnitureManager.Instance.IsFurnitureCanPlace(item))
				{
					canPlace = false;
				}
			}
		}
		RefreshSuitIsCanPlace(canPlace);
	}

	public void RefreshSuitIsCanPlace(bool canPlace)
	{
		if (child.Count > 0)
		{
			foreach (FurnitureEntity item in child)
			{
				FurnitureManager.Instance.RefreshIsCanPlace(item, canPlace);
			}
		}
		FurnitureManager.Instance.RefreshIsCanPlace(this, canPlace);
		DormRoomManager.Instance.EnableWarningMode(!canPlace);
		RefreshSuitFurnitureInteractPosVfx();
	}

	public void RefreshSuitFurnitureInteractPosVfx()
	{
		if (child.Count <= 0)
		{
			return;
		}
		MainColliderTrs.gameObject.SetActive(value: false);
		foreach (FurnitureEntity item in child)
		{
			FurnitureManager.RefreshFurnitureInteractPosVfx(item);
		}
		MainColliderTrs.gameObject.SetActive(value: true);
	}

	public void DisassembleFurSuit()
	{
		if (child.Count <= 0)
		{
			return;
		}
		foreach (FurnitureEntity item in child)
		{
			item.parent = null;
			item.trs.parent = DormRoomManager.Instance.GetTrsByType(TileType);
		}
	}

	public void ReCalculateWideAndLen()
	{
		if (child == null)
		{
			return;
		}
		float num = 1000f;
		float num2 = -1000f;
		float num3 = 1000f;
		float num4 = -1000f;
		foreach (FurnitureEntity item in child)
		{
			item.trs.parent = trs;
			bool num5 = Mathf.RoundToInt(Mathf.Abs(DormCoordinate.Instance.GetRotationByType(item.TileType, item.trs.localEulerAngles + trs.localEulerAngles)) / 90f) % 2 == 1;
			float num6 = (float)(num5 ? item.height : item.width) * 0.25f / 2f;
			float num7 = (float)(num5 ? item.width : item.height) * 0.25f / 2f;
			num = Math.Min(num, item.trs.position.x - num6);
			num2 = Math.Max(num2, item.trs.position.x + num6);
			num3 = Math.Min(num3, item.trs.position.z - num7);
			num4 = Math.Max(num4, item.trs.position.z + num7);
		}
		bool flag = Mathf.RoundToInt(Mathf.Abs(DormCoordinate.Instance.GetRotationByType(TileType, trs.localEulerAngles)) / 90f) % 2 == 1;
		suitLen = (flag ? (num4 - num3) : (num2 - num));
		suitWid = (flag ? (num2 - num) : (num4 - num3));
		int num8 = (int)Math.Round(suitLen * 100f / 25f);
		int num9 = (int)Math.Round(suitWid * 100f / 25f);
		suitLen = (float)num8 * 0.25f;
		suitWid = (float)num9 * 0.25f;
		trs.GetComponent<BoxCollider>().size = new Vector3(suitLen, 0.05f, suitWid);
		foreach (FurnitureEntity item2 in child)
		{
			item2.trs.parent = DormRoomManager.Instance.GetTrsByType(item2.TileType);
		}
		trs.position = DormCoordinate.Instance.GetRealPositionByType(TileType, new Vector2((num2 + num) / 2f, (num4 + num3) / 2f));
		foreach (FurnitureEntity item3 in child)
		{
			item3.trs.parent = trs;
		}
	}

	public void AddOrRemoveFurTrsWithSuitPrefab(bool flag)
	{
		if (flag)
		{
			foreach (FurnitureEntity item in child)
			{
				item.trs.parent = trs;
			}
			return;
		}
		foreach (FurnitureEntity item2 in child)
		{
			item2.trs.parent = DormRoomManager.Instance.GetTrsByType(item2.TileType);
		}
	}
}
