using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using Nova.Hotfix;
using UnityEngine;

[DisallowMultipleComponent]
public class DormRoomObj : MonoBehaviour
{
	[ReadOnly]
	public int RoomId;

	public HotfixEnum.DormRoomType Type;

	public HotfixEnum.DormRoomSizeType Size;

	public int Length = 20;

	public int Width = 20;

	public int Height = 10;

	public Dictionary<int, int> dictApplyPresetResult = new Dictionary<int, int>();

	private int CurUsedCellNum;

	private int MaxUsedCellNum;

	private UnityEngine.Object TemplateCell;

	private DormRoomObjCell[,,] cells;

	private DormRoomObjCell[,,] cells_clone;

	private int nFloorId_clone;

	private int nWallId_clone;

	private List<DormRoomObjCell> listColoredCells = new List<DormRoomObjCell>();

	private List<DormRoomObjCell> listTempColoredCells = new List<DormRoomObjCell>();

	private List<DormFurObj> listFurObj = new List<DormFurObj>();

	private List<DormFurObj> listMarkForDelFurObj = new List<DormFurObj>();

	private Dictionary<HotfixEnum.DormFurFixedType, DormFurObj> dictFixedFurObj = new Dictionary<HotfixEnum.DormFurFixedType, DormFurObj>();

	private bool IS_EDIT;

	private readonly List<DormRoomObjCell> _emptyFloorCellsBuffer = new List<DormRoomObjCell>();

	private readonly HashSet<DormRoomObjCell> _reservedSpawnCells = new HashSet<DormRoomObjCell>();

	public const string ROOM_BOUND_NODE_NAME = "==room_bound==";

	private const float ROOM_BOUND_THICKNESS = 0.5f;

	private const float ROOM_BOUND_EXTRA_HEIGHT = 1f;

	private GameObject goRoomBound;

	public int CUR_NUM => CurUsedCellNum;

	public int MAX_NUM => MaxUsedCellNum;

	public IReadOnlyList<DormFurObj> ListFurObj => listFurObj;

	private void OnDestroy()
	{
		ClearRoom();
	}

	public void Init(DormRoomInfo roomInfo)
	{
		bool bIsDefault = true;
		ClearRoom();
		List<FurnitureInfo> listFurInfo = null;
		MaxUsedCellNum = Length * Width - 1;
		if (roomInfo != null)
		{
			RoomId = (int)roomInfo.DormRoomId;
			DormRoom dormRoom = Singleton<HotfixDataController>.Instance.GetDormRoom(RoomId);
			Type = (HotfixEnum.DormRoomType)dormRoom.RoomType;
			Size = (HotfixEnum.DormRoomSizeType)dormRoom.RoomSizeType;
			MaxUsedCellNum = dormRoom.FloorRatio;
			DormRoomSize dormRoomSize = Singleton<HotfixDataController>.Instance.GetDormRoomSize((int)Size);
			Length = dormRoomSize.L;
			Width = dormRoomSize.W;
			Height = dormRoomSize.H;
			if (roomInfo.FurnitureList != null && roomInfo.FurnitureList.Length != 0)
			{
				bIsDefault = false;
				listFurInfo = new List<FurnitureInfo>(roomInfo.FurnitureList);
			}
			else
			{
				listFurInfo = new List<FurnitureInfo>();
				foreach (KeyValuePair<int, DormRoomLayout> dormRoomLayoutDatum in Singleton<HotfixDataController>.Instance.DormRoomLayoutData)
				{
					DormRoomLayout value = dormRoomLayoutDatum.Value;
					if (value.RoomLayoutId == dormRoom.DefaultLayoutId)
					{
						DormFurniture dormFurniture = Singleton<HotfixDataController>.Instance.GetDormFurniture(value.FurnitureId);
						FurnitureInfo furnitureInfo = new FurnitureInfo();
						furnitureInfo.FurnitureId = (uint)value.FurnitureId;
						furnitureInfo.X = (furnitureInfo.Y = (furnitureInfo.Z = 0u));
						furnitureInfo.Rotation = (uint)value.Rot;
						switch ((HotfixEnum.DormFurType)dormFurniture.PutType)
						{
						case HotfixEnum.DormFurType.OnFloor:
						case HotfixEnum.DormFurType.Carpet:
						case HotfixEnum.DormFurType.FloorCarpet:
							furnitureInfo.X = (uint)value.Pos.get_Item(0);
							furnitureInfo.Z = (uint)value.Pos.get_Item(2);
							break;
						case HotfixEnum.DormFurType.FloorPoster:
							furnitureInfo.Z = (uint)value.Pos.get_Item(2);
							break;
						case HotfixEnum.DormFurType.OnWall:
						case HotfixEnum.DormFurType.Poster:
							furnitureInfo.Rotation %= 2u;
							furnitureInfo.X = ((furnitureInfo.Rotation % 2 == 0) ? ((uint)value.Pos.get_Item(0)) : 0u);
							furnitureInfo.Y = (uint)value.Pos.get_Item(1);
							furnitureInfo.Z = ((furnitureInfo.Rotation % 2 != 0) ? ((uint)value.Pos.get_Item(2)) : 0u);
							break;
						case HotfixEnum.DormFurType.Wall:
						case HotfixEnum.DormFurType.Floor:
							furnitureInfo.Rotation = 0u;
							break;
						}
						listFurInfo.Add(furnitureInfo);
					}
				}
			}
		}
		cells = new DormRoomObjCell[Length, Width, Height];
		if (TemplateCell == null)
		{
			TemplateCell = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, DormConstValue.ROOM_CELL, typeof(UnityEngine.Object));
		}
		for (int i = 0; i < Height; i++)
		{
			for (int j = 0; j < Width; j++)
			{
				for (int k = 0; k < Length; k++)
				{
					cells[k, j, i] = new DormRoomObjCell(k, j, i, transform, TemplateCell, Type);
				}
			}
		}
		AppendFurnitures(ref listFurInfo, bIsDefault, bApplyPreset: false);
		SetupRoomBoundCollider();
	}

	public void AppendFurnitures(ref List<FurnitureInfo> listFurInfo, bool bIsDefault, bool bApplyPreset)
	{
		if (listFurInfo == null)
		{
			return;
		}
		DormFurniture dormFurniture = null;
		int num = listFurInfo.Count - 1;
		List<int> list = new List<int>();
		for (int num2 = num; num2 >= 0; num2--)
		{
			dormFurniture = Singleton<HotfixDataController>.Instance.GetDormFurniture((int)listFurInfo.get_Item(num2).FurnitureId);
			if (dormFurniture == null || string.IsNullOrEmpty(dormFurniture.ModelPrefab) || !dormFurniture.CanIn.ToList().Contains((int)Type))
			{
				listFurInfo.RemoveAt(num2);
			}
			else if (dormFurniture.Fixed != 0)
			{
				if (list.Contains(dormFurniture.Fixed))
				{
					listFurInfo.RemoveAt(num2);
				}
				else
				{
					list.Add(dormFurniture.Fixed);
				}
			}
		}
		listFurInfo.Sort((FurnitureInfo a, FurnitureInfo b) =>
		{
			DormFurniture dormFurniture2 = Singleton<HotfixDataController>.Instance.GetDormFurniture((int)a.FurnitureId);
			DormFurniture dormFurniture3 = Singleton<HotfixDataController>.Instance.GetDormFurniture((int)b.FurnitureId);
			int num7 = dormFurniture3.Fixed.CompareTo(dormFurniture2.Fixed);
			return (num7 != 0) ? num7 : dormFurniture2.Id.CompareTo(dormFurniture3.Id);
		});
		dictApplyPresetResult.Clear();
		num = listFurInfo.Count;
		if (bApplyPreset)
		{
			for (int num3 = listMarkForDelFurObj.Count - 1; num3 >= 0; num3--)
			{
				DormFurObj dormFurObj = listMarkForDelFurObj.get_Item(num3);
				if (dormFurObj != null && dormFurObj.FixedType == HotfixEnum.DormFurFixedType.None && dormFurObj.gameObject.activeSelf)
				{
					dormFurObj.gameObject.SetActive(value: false);
					ResetCellColor(dormFurObj);
				}
			}
			for (int num4 = listFurObj.Count - 1; num4 >= 0; num4--)
			{
				DormFurObj dormFurObj = listFurObj.get_Item(num4);
				if (dormFurObj != null && dormFurObj.FixedType == HotfixEnum.DormFurFixedType.None)
				{
					ChangeCells(dormFurObj, bSet: false);
					RemoveFurObj(dormFurObj, bVisible: false);
					ResetCellColor(dormFurObj);
				}
			}
			for (int num5 = listMarkForDelFurObj.Count - 1; num5 >= 0; num5--)
			{
				DormFurObj dormFurObj = listMarkForDelFurObj.get_Item(num5);
				if (dormFurObj != null && dormFurObj.FixedType != HotfixEnum.DormFurFixedType.None && dormFurObj.gameObject.activeSelf && CheckCells(dormFurObj, dormFurObj.RoomPos, EColorType.OnlyRed))
				{
					dormFurObj.MarkLanded();
					ChangeCells(dormFurObj, bSet: true);
					AddFurObj(dormFurObj);
					ResetCellColor(dormFurObj);
				}
			}
		}
		for (int num6 = 0; num6 < num; num6++)
		{
			FurnitureInfo furnitureInfo = listFurInfo.get_Item(num6);
			DormFurObj dormFurObj2 = CreateDormFurObj(furnitureInfo);
			if (dormFurObj2 == null)
			{
				continue;
			}
			if (dormFurObj2.FixedType != HotfixEnum.DormFurFixedType.None)
			{
				DormFurObj dormFurObj3 = CheckFixedFurObj(dormFurObj2.FixedType);
				if (bApplyPreset)
				{
					if (ReplaceFixedFurObj(dormFurObj3, dormFurObj2) == 1)
					{
						MarkApplyPresetResult(dormFurObj3.FurId, 1);
						MarkApplyPresetResult(dormFurObj2.FurId, -1);
					}
					else
					{
						RemoveFurObj(dormFurObj2, bVisible: false);
					}
					continue;
				}
				if (dormFurObj3 != null)
				{
					RemoveFurObj(dormFurObj2, bVisible: false);
					continue;
				}
			}
			Vector3Int vector3Int = SnapToRoomCell(dormFurObj2, furnitureInfo.X, furnitureInfo.Y, furnitureInfo.Z);
			dormFurObj2.SetPos(vector3Int);
			if (bApplyPreset && DormConstValue.ALLOW_ILLEGAL_WHEN_APPLY_PRESET)
			{
				bool flag = CheckCells(dormFurObj2, vector3Int, EColorType.OnlyRed);
				dormFurObj2.MarkLanded();
				if (flag)
				{
					ChangeCells(dormFurObj2, bSet: true);
					AddFurObj(dormFurObj2);
				}
				else
				{
					RemoveFurObj(dormFurObj2, bVisible: true);
				}
				if (bApplyPreset)
				{
					MarkApplyPresetResult(dormFurObj2.FurId, -1);
				}
				continue;
			}
			bool flag2 = CheckCells(dormFurObj2, vector3Int, EColorType.None);
			bool flag3 = CheckFloorCapacity(dormFurObj2);
			if (flag2 & flag3)
			{
				dormFurObj2.MarkLanded();
				ChangeCells(dormFurObj2, bSet: true);
				AddFurObj(dormFurObj2);
				if (bApplyPreset)
				{
					MarkApplyPresetResult(dormFurObj2.FurId, -1);
				}
			}
			else
			{
				RemoveFurObj(dormFurObj2, bVisible: false);
			}
		}
		if (bApplyPreset && DormConstValue.ALLOW_ILLEGAL_WHEN_APPLY_PRESET)
		{
			CheckFloorCapacity(null);
		}
	}

	public Vector3Int SnapToRoomCell(DormFurObj objFur, bool bRotateCheck = false)
	{
		Vector3 zeroCellWorldPos = objFur.GetZeroCellWorldPos();
		return SnapToRoomCell(objFur, zeroCellWorldPos.x, zeroCellWorldPos.y, zeroCellWorldPos.z, bRotateCheck);
	}

	private Vector3Int SnapToRoomCell(DormFurObj objFur, float x, float y, float z, bool bRotateCheck = false)
	{
		Vector3Int zero = Vector3Int.zero;
		switch (objFur.Type)
		{
		case HotfixEnum.DormFurType.Wall:
		case HotfixEnum.DormFurType.Floor:
			return zero;
		case HotfixEnum.DormFurType.OnFloor:
		case HotfixEnum.DormFurType.Carpet:
		case HotfixEnum.DormFurType.FloorCarpet:
		case HotfixEnum.DormFurType.FloorPoster:
			y = 0f;
			break;
		case HotfixEnum.DormFurType.OnWall:
		case HotfixEnum.DormFurType.Poster:
			if ((int)objFur.Rotate % 2 == 0)
			{
				z = 0f;
			}
			else
			{
				x = 0f;
			}
			break;
		}
		int num = Length - objFur.LEN;
		num = ((num <= 0) ? 1 : num);
		int num2 = Width - objFur.WID;
		num2 = ((num2 <= 0) ? 1 : num2);
		int num3 = Height - objFur.HEI;
		num3 = ((num3 <= 0) ? 1 : num3);
		double num4;
		double num5;
		double num6;
		if (bRotateCheck)
		{
			bool flag = (int)objFur.Rotate % 2 == 0;
			num4 = (flag ? Math.Floor(x) : Math.Ceiling(x));
			num5 = (flag ? Math.Floor(y) : Math.Ceiling(y));
			num6 = (flag ? Math.Floor(z) : Math.Ceiling(z));
		}
		else
		{
			num4 = Math.Round(x, MidpointRounding.AwayFromZero);
			num5 = Math.Round(y, MidpointRounding.AwayFromZero);
			num6 = Math.Round(z, MidpointRounding.AwayFromZero);
		}
		zero.x = Math.Clamp((int)num4, 0, num);
		zero.y = Math.Clamp((int)num5, 0, num3);
		zero.z = Math.Clamp((int)num6, 0, num2);
		return zero;
	}

	public bool CheckCells(DormFurObj objDormFur, Vector3Int v3iSnapped, EColorType eColorType)
	{
		if (objDormFur == null)
		{
			return false;
		}
		ResetCellColor(objDormFur);
		int lEN = objDormFur.LEN;
		int wID = objDormFur.WID;
		int hEI = objDormFur.HEI;
		bool flag = true;
		listTempColoredCells.Clear();
		ERoomCellResult eRoomCellResult = ERoomCellResult.Legal;
		for (int i = 0; i < hEI; i++)
		{
			for (int j = 0; j < wID; j++)
			{
				for (int k = 0; k < lEN; k++)
				{
					int num = v3iSnapped.x + k;
					int num2 = v3iSnapped.z + j;
					int num3 = v3iSnapped.y + i;
					if (!IsInSizeRange(num, Length) || !IsInSizeRange(num2, Width) || !IsInSizeRange(num3, Height))
					{
						flag = false;
						continue;
					}
					DormRoomObjCell dormRoomObjCell = cells[num, num2, num3];
					if (dormRoomObjCell == null)
					{
						flag = false;
						continue;
					}
					eRoomCellResult = dormRoomObjCell.CheckSlot(objDormFur);
					flag = (eRoomCellResult == ERoomCellResult.Legal) & flag;
					if (eColorType != EColorType.None && (k == 0 || j == 0 || i == 0) && (eColorType == EColorType.Both || (eColorType == EColorType.OnlyRed && eRoomCellResult != ERoomCellResult.Legal)))
					{
						flag = dormRoomObjCell.SetColor(eRoomCellResult, objDormFur, k, j, i) & flag;
						if (!listTempColoredCells.Contains(dormRoomObjCell))
						{
							listTempColoredCells.Add(dormRoomObjCell);
						}
					}
				}
			}
		}
		objDormFur.IsLegal = flag;
		if (eColorType != EColorType.None)
		{
			if (DormConstValue.FORCE_ALL_RED && !flag)
			{
				foreach (DormRoomObjCell listTempColoredCell in listTempColoredCells)
				{
					listTempColoredCell.SetForceRed(objDormFur);
					if (DormConstValue.FORCE_AFFECT_ALL)
					{
						if (listTempColoredCell.obj_FloorWall != null)
						{
							AffectRed(objDormFur, listTempColoredCell.obj_FloorWall, bSet: true);
						}
						if (listTempColoredCell.obj_Carpet != null)
						{
							AffectRed(objDormFur, listTempColoredCell.obj_Carpet, bSet: true);
						}
						if (listTempColoredCell.obj_Poster_L != null)
						{
							AffectRed(objDormFur, listTempColoredCell.obj_Poster_L, bSet: true);
						}
						if (listTempColoredCell.obj_Poster_R != null)
						{
							AffectRed(objDormFur, listTempColoredCell.obj_Poster_R, bSet: true);
						}
					}
				}
			}
			foreach (DormRoomObjCell listTempColoredCell2 in listTempColoredCells)
			{
				if (!listColoredCells.Contains(listTempColoredCell2))
				{
					listColoredCells.Add(listTempColoredCell2);
				}
			}
			listTempColoredCells.Clear();
		}
		return flag;
	}

	private void AffectRed(DormFurObj illegal, DormFurObj legal, bool bSet)
	{
		if (!DormUtil.InConflictWith(illegal.Type, legal.Type))
		{
			return;
		}
		int lEN = legal.LEN;
		int wID = legal.WID;
		int hEI = legal.HEI;
		Vector3Int roomPos = legal.RoomPos;
		for (int i = 0; i < hEI; i++)
		{
			for (int j = 0; j < wID; j++)
			{
				for (int k = 0; k < lEN; k++)
				{
					int num = roomPos.x + k;
					int num2 = roomPos.z + j;
					int num3 = roomPos.y + i;
					if (!IsInSizeRange(num, Length) || !IsInSizeRange(num2, Width) || !IsInSizeRange(num3, Height))
					{
						continue;
					}
					DormRoomObjCell dormRoomObjCell = cells[num, num2, num3];
					if (dormRoomObjCell != null && (k == 0 || j == 0 || i == 0))
					{
						dormRoomObjCell.SetAffectRed(illegal, legal, k, j, i);
						if (!listColoredCells.Contains(dormRoomObjCell))
						{
							listColoredCells.Add(dormRoomObjCell);
						}
					}
				}
			}
		}
	}

	public void ResetCellColor(DormFurObj objDormFur)
	{
		if (listColoredCells == null || listColoredCells.Count <= 0)
		{
			return;
		}
		for (int num = listColoredCells.Count - 1; num >= 0; num--)
		{
			DormRoomObjCell dormRoomObjCell = listColoredCells.get_Item(num);
			if (dormRoomObjCell != null)
			{
				if (dormRoomObjCell.ResetColor(objDormFur))
				{
					listColoredCells.RemoveAt(num);
				}
			}
			else
			{
				listColoredCells.RemoveAt(num);
			}
		}
	}

	public void CheckIllegalFurObjs(DormFurObj objCurEdit)
	{
		for (int num = listMarkForDelFurObj.Count - 1; num >= 0; num--)
		{
			DormFurObj dormFurObj = listMarkForDelFurObj.get_Item(num);
			if (dormFurObj.gameObject.activeSelf && !(dormFurObj == objCurEdit) && CheckCells(dormFurObj, dormFurObj.RoomPos, EColorType.Both))
			{
				dormFurObj.MarkLanded();
				ResetCellColor(dormFurObj);
				ChangeCells(dormFurObj, bSet: true);
				AddFurObj(dormFurObj);
			}
		}
	}

	public bool CheckFloorCapacity(DormFurObj obj)
	{
		int num = (((bool)obj && obj.CalcFloorCapacity) ? (obj.LEN * obj.WID) : 0);
		for (int i = 0; i < Width; i++)
		{
			for (int j = 0; j < Length; j++)
			{
				DormRoomObjCell dormRoomObjCell = cells[j, i, 0];
				if (dormRoomObjCell != null)
				{
					DormFurObj obj_FloorWall = dormRoomObjCell.obj_FloorWall;
					if (obj_FloorWall != null && obj_FloorWall.CalcFloorCapacity && listFurObj.Contains(obj_FloorWall))
					{
						num++;
					}
				}
			}
		}
		if (DormConstValue.CALC_ILLEGAL_FUR_FLOOR_CELL_USED)
		{
			List<DormRoomObjCell> list = new List<DormRoomObjCell>();
			foreach (DormFurObj item in listMarkForDelFurObj)
			{
				if (!item.gameObject.activeSelf || !item.CalcFloorCapacity)
				{
					continue;
				}
				Vector3Int roomPos = item.RoomPos;
				int lEN = item.LEN;
				int wID = item.WID;
				for (int k = 0; k < lEN; k++)
				{
					for (int l = 0; l < wID; l++)
					{
						DormRoomObjCell dormRoomObjCell2 = cells[k + roomPos.x, l + roomPos.z, 0];
						if (dormRoomObjCell2 != null && dormRoomObjCell2.obj_FloorWall == null && !list.Contains(dormRoomObjCell2))
						{
							list.Add(dormRoomObjCell2);
						}
					}
				}
			}
			num += list.Count;
		}
		CurUsedCellNum = num;
		return CurUsedCellNum <= MaxUsedCellNum;
	}

	public void ChangeCells(DormFurObj objDormFur, bool bSet)
	{
		if (objDormFur == null)
		{
			return;
		}
		Vector3Int roomPos = objDormFur.RoomPos;
		int lEN = objDormFur.LEN;
		int wID = objDormFur.WID;
		int hEI = objDormFur.HEI;
		for (int i = 0; i < hEI; i++)
		{
			for (int j = 0; j < wID; j++)
			{
				for (int k = 0; k < lEN; k++)
				{
					int num = roomPos.x + k;
					int num2 = roomPos.z + j;
					int num3 = roomPos.y + i;
					if (IsInSizeRange(num, Length) && IsInSizeRange(num2, Width) && IsInSizeRange(num3, Height))
					{
						DormRoomObjCell dormRoomObjCell = cells[num, num2, num3];
						if (bSet)
						{
							dormRoomObjCell?.SetSlot(objDormFur);
						}
						else
						{
							dormRoomObjCell?.ClearSlot(objDormFur);
						}
					}
				}
			}
		}
	}

	private int ReplaceFixedFurObj(DormFurObj objOld, DormFurObj objNew)
	{
		if (objOld == null || objNew == null)
		{
			return -1;
		}
		if (objOld.Length != objNew.Length || objOld.Width != objNew.Width || objOld.Height != objNew.Height)
		{
			return 0;
		}
		objNew.Rotate = objOld.Rotate;
		objNew.Init(null, EFurCellVisible.None);
		objNew.SetPos(objOld.RoomPos);
		ChangeCells(objOld, bSet: false);
		RemoveFurObj(objOld, bVisible: false);
		ChangeCells(objNew, bSet: true);
		AddFurObj(objNew);
		return 1;
	}

	public ERoomSaveCheckResult CheckToSave(ref List<FurnitureInfo> list)
	{
		if (list == null)
		{
			list = new List<FurnitureInfo>();
		}
		list.Clear();
		if (!CheckFloorCapacity(null))
		{
			return ERoomSaveCheckResult.Err_FloorCapacity;
		}
		foreach (DormFurObj item in listMarkForDelFurObj)
		{
			if (item.gameObject.activeSelf)
			{
				return ERoomSaveCheckResult.Err_FurniturePos;
			}
		}
		foreach (DormFurObj item2 in listFurObj)
		{
			HotfixEnum.DormFurFixedType fixedType = item2.FixedType;
			if (fixedType != HotfixEnum.DormFurFixedType.None && dictFixedFurObj.ContainsKey(fixedType) && dictFixedFurObj.get_Item(fixedType) != item2)
			{
				list.Clear();
				return ERoomSaveCheckResult.Err_FixedFurniture;
			}
			FurnitureInfo furnitureInfo = new FurnitureInfo();
			furnitureInfo.FurnitureId = (uint)item2.FurId;
			furnitureInfo.X = (uint)item2.RoomPos.x;
			furnitureInfo.Y = (uint)item2.RoomPos.y;
			furnitureInfo.Z = (uint)item2.RoomPos.z;
			furnitureInfo.Rotation = (uint)item2.Rotate;
			list.Add(furnitureInfo);
		}
		return ERoomSaveCheckResult.Success;
	}

	private void MarkApplyPresetResult(int nFurId, int nDelta)
	{
		if (dictApplyPresetResult.ContainsKey(nFurId))
		{
			dictApplyPresetResult.get_Item(nFurId) += nDelta;
		}
		else
		{
			dictApplyPresetResult.Add(nFurId, nDelta);
		}
	}

	public void CloneCells()
	{
		cells_clone = null;
		cells_clone = new DormRoomObjCell[Length, Width, Height];
		for (int i = 0; i < Height; i++)
		{
			for (int j = 0; j < Width; j++)
			{
				for (int k = 0; k < Length; k++)
				{
					cells_clone[k, j, i] = new DormRoomObjCell(k, j, i, null, null, Type);
					DormRoomObjCell dormRoomObjCell = cells[k, j, i];
					cells_clone[k, j, i].CloneFur(dormRoomObjCell.obj_FloorWall, dormRoomObjCell.obj_Carpet, dormRoomObjCell.obj_Poster_L, dormRoomObjCell.obj_Poster_R);
				}
			}
		}
		nFloorId_clone = 0;
		nWallId_clone = 0;
		if (dictFixedFurObj.TryGetValue(HotfixEnum.DormFurFixedType.Floor, out var value) && value != null)
		{
			nFloorId_clone = value.FurId;
		}
		if (dictFixedFurObj.TryGetValue(HotfixEnum.DormFurFixedType.Wall, out var value2) && value2 != null)
		{
			nWallId_clone = value2.FurId;
		}
	}

	private void ClearCloneCells()
	{
		cells_clone = null;
		nFloorId_clone = 0;
		nWallId_clone = 0;
	}

	public bool CheckNeedSave()
	{
		if (cells_clone == null)
		{
			return true;
		}
		bool result = false;
		for (int i = 0; i < Height; i++)
		{
			for (int j = 0; j < Width; j++)
			{
				for (int k = 0; k < Length; k++)
				{
					DormRoomObjCell clone = cells_clone[k, j, i];
					if (!cells[k, j, i].IsSame(clone))
					{
						result = true;
						break;
					}
				}
			}
		}
		foreach (DormFurObj item in listFurObj)
		{
			if (item.FixedType == HotfixEnum.DormFurFixedType.Floor && item.FurId != nFloorId_clone)
			{
				result = true;
				break;
			}
			if (item.FixedType == HotfixEnum.DormFurFixedType.Wall && item.FurId != nWallId_clone)
			{
				result = true;
				break;
			}
		}
		return result;
	}

	public void HideFur(bool bIsFloorFurObj, bool bVisible, DormFurObj objCurFur)
	{
		foreach (DormFurObj item in listFurObj)
		{
			if (objCurFur == null || item != objCurFur)
			{
				item.TryHideFurObj(bIsFloorFurObj, bVisible);
			}
		}
		foreach (DormFurObj item2 in listMarkForDelFurObj)
		{
			if (item2.gameObject.activeSelf && (objCurFur == null || item2 != objCurFur))
			{
				item2.TryHideFurObj(bIsFloorFurObj, bVisible);
			}
		}
	}

	public List<RoomCellIntro> GetRoomCellIntro()
	{
		List<RoomCellIntro> list = new List<RoomCellIntro>();
		for (int i = 0; i < Width; i++)
		{
			for (int j = 0; j < Length; j++)
			{
				DormRoomObjCell dormRoomObjCell = cells[j, i, 0];
				if (dormRoomObjCell != null)
				{
					RoomCellIntro roomCellIntro = new RoomCellIntro();
					roomCellIntro.x = dormRoomObjCell.Node.transform.position.x;
					roomCellIntro.z = dormRoomObjCell.Node.transform.position.z;
					roomCellIntro.y = 0f;
					roomCellIntro.isEmpty = dormRoomObjCell.obj_FloorWall == null;
					list.Add(roomCellIntro);
				}
			}
		}
		return list;
	}

	public void ClearSpawnReservations()
	{
		_reservedSpawnCells.Clear();
	}

	public bool TryGetRandomEmptyFloorCellWorldPos(out Vector3 worldPos, bool reserve = false)
	{
		worldPos = default;
		if (cells == null)
		{
			return false;
		}
		_emptyFloorCellsBuffer.Clear();
		for (int i = 0; i < Width; i++)
		{
			for (int j = 0; j < Length; j++)
			{
				DormRoomObjCell dormRoomObjCell = cells[j, i, 0];
				if (dormRoomObjCell != null && !(null == dormRoomObjCell.Node) && !(dormRoomObjCell.obj_FloorWall != null) && !_reservedSpawnCells.Contains(dormRoomObjCell))
				{
					_emptyFloorCellsBuffer.Add(dormRoomObjCell);
				}
			}
		}
		if (_emptyFloorCellsBuffer.Count == 0)
		{
			return false;
		}
		DormRoomObjCell dormRoomObjCell2 = _emptyFloorCellsBuffer.get_Item(UnityEngine.Random.Range(0, _emptyFloorCellsBuffer.Count));
		worldPos = dormRoomObjCell2.Node.transform.position;
		if (reserve)
		{
			_reservedSpawnCells.Add(dormRoomObjCell2);
		}
		return true;
	}

	public bool CheckCellCanPutChar(int l, int w)
	{
		if (cells == null || l < 0 || w < 0 || l >= Length || w >= Width)
		{
			return false;
		}
		DormRoomObjCell dormRoomObjCell = cells[l, w, 0];
		if (dormRoomObjCell == null)
		{
			return false;
		}
		return dormRoomObjCell.obj_FloorWall == null;
	}

	public bool TryGetFloorCellIndexByWorldPos(Vector3 worldPos, out int l, out int w)
	{
		l = 0;
		w = 0;
		if (cells == null || Length <= 0 || Width <= 0)
		{
			return false;
		}
		Vector3 vector = transform.InverseTransformPoint(worldPos);
		l = Math.Clamp((int)Math.Round(vector.x, MidpointRounding.AwayFromZero), 0, Length - 1);
		w = Math.Clamp((int)Math.Round(vector.z, MidpointRounding.AwayFromZero), 0, Width - 1);
		return true;
	}

	public bool IsWorldPosInFloorRange(Vector3 worldPos)
	{
		if (cells == null || Length <= 0 || Width <= 0)
		{
			return false;
		}
		Vector3 vector = transform.InverseTransformPoint(worldPos);
		int num = (int)Math.Round(vector.x, MidpointRounding.AwayFromZero);
		int num2 = (int)Math.Round(vector.z, MidpointRounding.AwayFromZero);
		if (num >= 0 && num < Length && num2 >= 0)
		{
			return num2 < Width;
		}
		return false;
	}

	public bool TryGetFloorFurnitureByWorldPos(Vector3 worldPos, out DormFurObj furObj)
	{
		furObj = null;
		if (!TryGetFloorCellIndexByWorldPos(worldPos, out var l, out var w))
		{
			return false;
		}
		DormRoomObjCell dormRoomObjCell = cells[l, w, 0];
		if (dormRoomObjCell == null)
		{
			return false;
		}
		furObj = dormRoomObjCell.obj_FloorWall;
		return furObj != null;
	}

	public bool TryGetCellWorldPos(int l, int w, out Vector3 worldPos)
	{
		worldPos = default;
		if (cells == null || l < 0 || w < 0 || l >= Length || w >= Width)
		{
			return false;
		}
		DormRoomObjCell dormRoomObjCell = cells[l, w, 0];
		if (dormRoomObjCell == null || null == dormRoomObjCell.Node)
		{
			return false;
		}
		Vector3 position = dormRoomObjCell.Node.transform.position;
		worldPos = new Vector3(position.x, 0f, position.z);
		return true;
	}

	public void ClearRoom()
	{
		ClearRoomBoundCollider();
		ResetCellColor(null);
		ClearCloneCells();
		if (cells != null)
		{
			for (int i = 0; i < Height; i++)
			{
				for (int j = 0; j < Width; j++)
				{
					for (int k = 0; k < Length; k++)
					{
						cells[k, j, i]?.Clear();
					}
				}
			}
			cells = null;
		}
		ClearFurObjInList(ref listFurObj);
		ClearFurObjInList(ref listMarkForDelFurObj);
		if (dictFixedFurObj.Values.Count > 0)
		{
			List<DormFurObj> list = new List<DormFurObj>(dictFixedFurObj.Values);
			ClearFurObjInList(ref list);
			list = null;
		}
		dictFixedFurObj.Clear();
		CurUsedCellNum = 0;
		MaxUsedCellNum = 0;
	}

	private void ClearFurObjInList(ref List<DormFurObj> list)
	{
		if (list == null)
		{
			return;
		}
		for (int num = list.Count - 1; num >= 0; num--)
		{
			DormFurObj dormFurObj = list.get_Item(num);
			if (dictFixedFurObj.ContainsValue(dormFurObj))
			{
				dictFixedFurObj.Remove(dormFurObj.FixedType);
			}
			list.Remove(dormFurObj);
			dormFurObj.ClearFur(bForce: true);
			UnityEngine.Object.DestroyImmediate(dormFurObj.gameObject);
		}
		list.Clear();
	}

	private void DestroyIllegalFurObj()
	{
		for (int num = listMarkForDelFurObj.Count - 1; num >= 0; num--)
		{
			DormFurObj dormFurObj = listMarkForDelFurObj.get_Item(num);
			if (dormFurObj != null && !dormFurObj.gameObject.activeSelf)
			{
				listMarkForDelFurObj.Remove(dormFurObj);
				UnityEngine.Object.DestroyImmediate(dormFurObj.gameObject);
			}
		}
	}

	public DormFurObj CreateDormFurObj(uint Id, out int oldFixedId)
	{
		oldFixedId = 0;
		DormFurniture dormFurniture = Singleton<HotfixDataController>.Instance.GetDormFurniture((int)Id);
		if (dormFurniture == null || string.IsNullOrEmpty(dormFurniture.ModelPrefab) || !dormFurniture.CanIn.ToList().Contains((int)Type))
		{
			return null;
		}
		FurnitureInfo furnitureInfo = new FurnitureInfo();
		furnitureInfo.FurnitureId = Id;
		furnitureInfo.X = 0u;
		furnitureInfo.Y = 0u;
		furnitureInfo.Z = 0u;
		furnitureInfo.Rotation = 0u;
		DormFurObj dormFurObj = CreateDormFurObj(furnitureInfo);
		dormFurObj.SetNaviCurRoot(!IS_EDIT);
		if (dormFurObj.FixedType == HotfixEnum.DormFurFixedType.None)
		{
			Vector3Int vector3Int = FindAppropriateRoomPos(dormFurObj);
			if (vector3Int == Vector3Int.left && dormFurObj.IsOnWall)
			{
				dormFurObj.SetRotate(bClockwise: true);
				vector3Int = FindAppropriateRoomPos(dormFurObj);
			}
			if (vector3Int != Vector3Int.left)
			{
				dormFurObj.SetPos(vector3Int);
			}
			else
			{
				Vector3Int pos = Vector3Int.zero;
				switch (dormFurObj.Type)
				{
				case HotfixEnum.DormFurType.OnFloor:
				case HotfixEnum.DormFurType.Carpet:
				case HotfixEnum.DormFurType.FloorCarpet:
					pos = new Vector3Int(Length / 2 - dormFurniture.L / 2, 0, Width / 2 - dormFurniture.W / 2);
					break;
				case HotfixEnum.DormFurType.OnWall:
				case HotfixEnum.DormFurType.Poster:
					if (dormFurObj.IsOnWall)
					{
						dormFurObj.SetRotate(bClockwise: true);
					}
					pos = new Vector3Int(Length / 2 - dormFurniture.L / 2, Height / 2 - dormFurniture.H / 2, 0);
					break;
				case HotfixEnum.DormFurType.FloorPoster:
					pos = new Vector3Int(Length / 2 - dormFurniture.L / 2, 0, 0);
					break;
				}
				dormFurObj.SetPos(pos);
			}
		}
		else
		{
			DormFurObj dormFurObj2 = CheckFixedFurObj(dormFurObj.FixedType);
			switch (ReplaceFixedFurObj(dormFurObj2, dormFurObj))
			{
			case -1:
			case 0:
				RemoveFurObj(dormFurObj, bVisible: false);
				dormFurObj = null;
				break;
			case 1:
				oldFixedId = dormFurObj2.FurId;
				break;
			}
		}
		return dormFurObj;
	}

	public DormFurObj RevertToPreviousFurObj(int id, DormFurObj objCur)
	{
		DormFurniture dormFurniture = Singleton<HotfixDataController>.Instance.GetDormFurniture(id);
		string modelPrefab = dormFurniture.ModelPrefab;
		if (dormFurniture == null || string.IsNullOrEmpty(modelPrefab) || !dormFurniture.CanIn.ToList().Contains((int)Type))
		{
			return null;
		}
		string text = modelPrefab.Replace(".prefab", string.Empty);
		int num = text.LastIndexOf("/") + 1;
		text = text.Substring(num, text.Length - num);
		DormFurObj dormFurObj = TryGetFurObj(text);
		int num2 = ReplaceFixedFurObj(objCur, dormFurObj);
		if ((uint)(num2 - -1) <= 1u)
		{
			RemoveFurObj(dormFurObj, bVisible: false);
			dormFurObj = null;
		}
		return dormFurObj;
	}

	private DormFurObj CreateDormFurObj(FurnitureInfo info)
	{
		if (info == null)
		{
			return null;
		}
		DormFurniture dormFurniture = Singleton<HotfixDataController>.Instance.GetDormFurniture((int)info.FurnitureId);
		string modelPrefab = dormFurniture.ModelPrefab;
		if (dormFurniture == null || string.IsNullOrEmpty(modelPrefab) || !dormFurniture.CanIn.ToList().Contains((int)Type))
		{
			return null;
		}
		string text = modelPrefab.Replace(".prefab", string.Empty);
		int num = text.LastIndexOf("/") + 1;
		text = text.Substring(num, text.Length - num);
		DormFurObj dormFurObj = TryGetFurObj(text);
		if (dormFurObj == null)
		{
			GameObject obj = UnityEngine.Object.Instantiate(GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, "Assets/AssetBundles/" + modelPrefab, typeof(GameObject))) as GameObject;
			obj.name = text;
			obj.transform.parent = transform.parent;
			obj.transform.localRotation = Quaternion.identity;
			obj.transform.localScale = Vector3.one;
			dormFurObj = obj.GetComponent<DormFurObj>();
		}
		dormFurObj.Init(info, EFurCellVisible.None);
		return dormFurObj;
	}

	private DormFurObj CheckFixedFurObj(HotfixEnum.DormFurFixedType t)
	{
		DormFurObj dormFurObj = null;
		if (t != HotfixEnum.DormFurFixedType.None && dictFixedFurObj.ContainsKey(t))
		{
			dormFurObj = dictFixedFurObj.get_Item(t);
		}
		if (!(dormFurObj != null) || !listFurObj.Contains(dormFurObj))
		{
			return null;
		}
		return dormFurObj;
	}

	public void AddFurObj(DormFurObj obj)
	{
		if (!(obj == null))
		{
			if (listMarkForDelFurObj.Contains(obj))
			{
				listMarkForDelFurObj.Remove(obj);
			}
			if (!listFurObj.Contains(obj))
			{
				listFurObj.Add(obj);
			}
			if (obj.FixedType != HotfixEnum.DormFurFixedType.None)
			{
				dictFixedFurObj.set_Item(obj.FixedType, obj);
			}
		}
	}

	public void RemoveFurObj(DormFurObj obj, bool bVisible)
	{
		if (!(obj == null))
		{
			if (obj.gameObject.activeSelf != bVisible)
			{
				obj.gameObject.SetActive(bVisible);
			}
			if (listFurObj.Contains(obj))
			{
				listFurObj.Remove(obj);
			}
			if (!listMarkForDelFurObj.Contains(obj))
			{
				listMarkForDelFurObj.Add(obj);
			}
			if (obj.FixedType != HotfixEnum.DormFurFixedType.None && dictFixedFurObj.ContainsKey(obj.FixedType) && dictFixedFurObj.get_Item(obj.FixedType) == obj)
			{
				dictFixedFurObj.Remove(obj.FixedType);
			}
		}
	}

	public DormFurObj GetFurObjByEntityID(long entityID)
	{
		foreach (DormFurObj item in listFurObj)
		{
			if (item.id == entityID)
			{
				return item;
			}
		}
		return null;
	}

	private DormFurObj TryGetFurObj(string sPrefabName)
	{
		foreach (DormFurObj item in listMarkForDelFurObj)
		{
			if (!item.gameObject.activeSelf && item.gameObject.name == sPrefabName)
			{
				item.gameObject.SetActive(value: true);
				return item;
			}
		}
		return null;
	}

	private bool IsInSizeRange(int nValue, int nSize)
	{
		if (nValue >= 0 && nValue < nSize)
		{
			return true;
		}
		return false;
	}

	public void SwitchToEditMode(bool bIsEditMode)
	{
		if (IS_EDIT != bIsEditMode)
		{
			MarkEditMode(bIsEditMode, bDoCloneCell: false);
			if (IS_EDIT)
			{
				CloneCells();
				return;
			}
			ClearCloneCells();
			DestroyIllegalFurObj();
		}
	}

	public void MarkEditMode(bool b, bool bDoCloneCell)
	{
		IS_EDIT = b;
		dictFixedFurObj.get_Item(HotfixEnum.DormFurFixedType.Elevator)?.SetElevatorCollider(!IS_EDIT);
		if (bDoCloneCell)
		{
			CloneCells();
		}
		foreach (DormFurObj item in listFurObj)
		{
			item.SetNaviCurRoot(!b);
		}
		foreach (DormFurObj item2 in listMarkForDelFurObj)
		{
			item2.SetNaviCurRoot(!b);
		}
	}

	private Vector3Int FindAppropriateRoomPos(DormFurObj objFur)
	{
		//IL_0013: Field data (rva=0x608) could not be found in any section!
		//IL_0013: Field data (rva=0x608) could not be found in any section!
		Vector3Int left = Vector3Int.left;
		int[,] array = new int[4, 2];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._1C4202F7FAC1C4F9C28AB7AB3D4DD782ACE887EADD2F59D6E078132B273448D0));
		int[,] array2 = array;
		int num = (objFur.IsOnWall ? (((int)objFur.Rotate % 2 == 0) ? 1 : 2) : 0);
		int num2 = 0;
		int num3 = 0;
		int num4 = 0;
		int num5 = 0;
		int num6 = 0;
		int num7 = 0;
		int num8 = 0;
		int num9 = 1;
		switch (num)
		{
		case 0:
			num2 = (Length - objFur.LEN) / 2;
			num3 = Length;
			num4 = (Width - objFur.WID) / 2;
			num5 = Width;
			left = new Vector3Int(num2, 0, num4);
			break;
		case 1:
			num2 = (Length - objFur.LEN) / 2;
			num3 = Length;
			num4 = (Height - objFur.HEI) / 2;
			num5 = Height;
			left = new Vector3Int(num2, num4, 0);
			break;
		case 2:
			num2 = (Width - objFur.WID) / 2;
			num3 = Width;
			num4 = (Height - objFur.HEI) / 2;
			num5 = Height;
			left = new Vector3Int(0, num4, num2);
			break;
		default:
			return left;
		}
		num6 = ((num3 > num5) ? num3 : num5);
		num6 *= num6;
		if (CheckCells(objFur, left, EColorType.None))
		{
			return left;
		}
		num8++;
		while (num8 < num6)
		{
			for (int i = 0; i < 2; i++)
			{
				if (num8 >= num6)
				{
					break;
				}
				for (int j = 0; j < num9; j++)
				{
					if (num8 >= num6)
					{
						break;
					}
					num8++;
					num2 += array2[num7, 0];
					num4 += array2[num7, 1];
					if (num2 >= 0 && num2 < num3 && num4 >= 0 && num4 < num5)
					{
						switch (num)
						{
						case 0:
							left = new Vector3Int(num2, 0, num4);
							break;
						case 1:
							left = new Vector3Int(num2, num4, 0);
							break;
						case 2:
							left = new Vector3Int(0, num4, num2);
							break;
						default:
							return left;
						}
						if (CheckCells(objFur, left, EColorType.None))
						{
							return left;
						}
					}
				}
				num7 = (num7 + 1) % 4;
			}
			num9++;
		}
		return Vector3Int.left;
	}

	private void SetupRoomBoundCollider()
	{
		ClearRoomBoundCollider();
		goRoomBound = new GameObject("==room_bound==");
		goRoomBound.transform.SetParent(transform, worldPositionStays: false);
		goRoomBound.transform.SetLocalPositionAndRotation(Vector3.zero, Quaternion.identity);
		goRoomBound.layer = DormConstValue.LAYER_ROOM_BOUND;
		float num = 0.5f;
		float num2 = (float)Height + 1f;
		float y = -0.5f + num2 * 0.5f;
		float x = (float)(Length - 1) * 0.5f;
		float z = (float)(Width - 1) * 0.5f;
		AddRoomBoundBox(new Vector3(-0.5f - num * 0.5f, y, z), new Vector3(num, num2, (float)Width + 2f * num));
		AddRoomBoundBox(new Vector3((float)Length - 0.5f + num * 0.5f, y, z), new Vector3(num, num2, (float)Width + 2f * num));
		AddRoomBoundBox(new Vector3(x, y, -0.5f - num * 0.5f), new Vector3((float)Length + 2f * num, num2, num));
		AddRoomBoundBox(new Vector3(x, y, (float)Width - 0.5f + num * 0.5f), new Vector3((float)Length + 2f * num, num2, num));
	}

	private void AddRoomBoundBox(Vector3 localCenter, Vector3 size)
	{
		BoxCollider boxCollider = goRoomBound.AddComponent<BoxCollider>();
		boxCollider.center = localCenter;
		boxCollider.size = size;
	}

	private void ClearRoomBoundCollider()
	{
		if (goRoomBound != null)
		{
			UnityEngine.Object.Destroy(goRoomBound);
			goRoomBound = null;
		}
	}
}
