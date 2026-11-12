using System.Collections.Generic;
using UnityEngine;

public class DormRoomObjCell
{
	public int x;

	public int y;

	public int z;

	public DormFurObj obj_FloorWall;

	public DormFurObj obj_Carpet;

	public DormFurObj obj_Poster_L;

	public DormFurObj obj_Poster_R;

	public GameObject Node;

	private GameObject X_Z_G;

	private GameObject X_Z_R;

	private GameObject X_Y_G;

	private GameObject X_Y_R;

	private GameObject Z_Y_G;

	private GameObject Z_Y_R;

	private Dictionary<DormFurObj, List<ERoomCellColor>> dictCellColor;

	private int Cloned_FloorWall_id;

	private HotfixEnum.DormFurRotate Cloned_FloorWall_rotate;

	private int Cloned_Carpet_id;

	private HotfixEnum.DormFurRotate Cloned_Carpet_rotate;

	private int Cloned_PosterL_id;

	private HotfixEnum.DormFurRotate Cloned_PosterL_rotate;

	private int Cloned_PosterR_id;

	private HotfixEnum.DormFurRotate Cloned_PosterR_rotate;

	public DormRoomObjCell(int L, int W, int H, Transform root, Object tCell, HotfixEnum.DormRoomType eRoomType)
	{
		x = L;
		z = W;
		y = H;
		bool flag;
		if (root != null && tCell != null)
		{
			flag = eRoomType == HotfixEnum.DormRoomType.Indoor;
			bool num;
			if (!flag)
			{
				num = y == 0;
			}
			else
			{
				if (x == 0 || y == 0)
				{
					goto IL_006e;
				}
				num = z == 0;
			}
			if (num || DormConstValue.FORCE_ALL_ROOM_CELL_INS)
			{
				goto IL_006e;
			}
			goto IL_0080;
		}
		goto IL_0234;
		IL_006e:
		Node = Object.Instantiate(tCell) as GameObject;
		goto IL_0080;
		IL_0080:
		if (Node != null)
		{
			Node.name = $"{L}-{(DormConstValue.NAME_BY_LWH ? W : H)}-{(DormConstValue.NAME_BY_LWH ? H : W)}";
			Transform transform = Node.transform;
			transform.parent = root;
			transform.localPosition = new Vector3(x, y, z);
			transform.localRotation = Quaternion.identity;
			transform.localScale = Vector3.one;
			transform.Find("x_z")?.gameObject.SetActive(y == 0);
			transform.Find("x_y")?.gameObject.SetActive((z == 0) & flag);
			transform.Find("z_y")?.gameObject.SetActive((x == 0) & flag);
			X_Z_G = transform.Find("x_z/green")?.gameObject;
			X_Z_R = transform.Find("x_z/red")?.gameObject;
			X_Y_G = transform.Find("x_y/green")?.gameObject;
			X_Y_R = transform.Find("x_y/red")?.gameObject;
			Z_Y_G = transform.Find("z_y/green")?.gameObject;
			Z_Y_R = transform.Find("z_y/red")?.gameObject;
		}
		goto IL_0234;
		IL_0234:
		dictCellColor = new Dictionary<DormFurObj, List<ERoomCellColor>>();
		ResetColor(null);
	}

	public void Clear()
	{
		x = (y = (z = 0));
		obj_FloorWall = (obj_Carpet = (obj_Poster_L = (obj_Poster_R = null)));
		X_Z_G = (X_Z_R = (X_Y_G = (X_Y_R = (Z_Y_G = (Z_Y_R = null)))));
		if (Node != null)
		{
			Object.DestroyImmediate(Node);
		}
		Node = null;
		if (dictCellColor != null)
		{
			dictCellColor.Clear();
		}
		dictCellColor = null;
	}

	public ERoomCellResult CheckSlot(DormFurObj objFur)
	{
		ERoomCellResult result = ERoomCellResult.Legal;
		if (objFur == null)
		{
			return result;
		}
		_ = objFur.FurId;
		HotfixEnum.DormFurType type = objFur.Type;
		HotfixEnum.DormFurRotate rotate = objFur.Rotate;
		switch (type)
		{
		case HotfixEnum.DormFurType.OnFloor:
		case HotfixEnum.DormFurType.OnWall:
		case HotfixEnum.DormFurType.FloorCarpet:
		case HotfixEnum.DormFurType.FloorPoster:
			if (obj_FloorWall != null && objFur != obj_FloorWall)
			{
				switch (obj_FloorWall.Type)
				{
				case HotfixEnum.DormFurType.OnFloor:
				case HotfixEnum.DormFurType.FloorCarpet:
				case HotfixEnum.DormFurType.FloorPoster:
					result = ERoomCellResult.Illegal_Floor;
					break;
				case HotfixEnum.DormFurType.OnWall:
					result = (((int)obj_FloorWall.Rotate % 2 != 0) ? ERoomCellResult.Illegal_Wall_Right : ERoomCellResult.Illegal_Wall_Left);
					break;
				}
				break;
			}
			switch (type)
			{
			case HotfixEnum.DormFurType.FloorCarpet:
				if (obj_Carpet != null)
				{
					result = ERoomCellResult.Illegal_Floor;
				}
				break;
			case HotfixEnum.DormFurType.FloorPoster:
				if ((int)rotate % 2 == 0)
				{
					if (obj_Poster_L != null)
					{
						result = ERoomCellResult.Illegal_Wall_Left;
					}
				}
				else if (obj_Poster_R != null)
				{
					result = ERoomCellResult.Illegal_Wall_Right;
				}
				break;
			}
			break;
		case HotfixEnum.DormFurType.Carpet:
			if (obj_Carpet != null && objFur != obj_Carpet)
			{
				result = ERoomCellResult.Illegal_Floor;
			}
			else if (obj_FloorWall != null && obj_FloorWall.Type == HotfixEnum.DormFurType.FloorCarpet)
			{
				result = ERoomCellResult.Illegal_Floor;
			}
			break;
		case HotfixEnum.DormFurType.Poster:
			if ((int)rotate % 2 == 0)
			{
				if (obj_Poster_L != null && objFur != obj_Poster_L)
				{
					result = ERoomCellResult.Illegal_Wall_Left;
				}
			}
			else if (obj_Poster_R != null && objFur != obj_Poster_R)
			{
				result = ERoomCellResult.Illegal_Wall_Right;
			}
			else if (obj_FloorWall != null && obj_FloorWall.Type == HotfixEnum.DormFurType.FloorPoster)
			{
				result = ERoomCellResult.Illegal_Wall_Right;
			}
			break;
		}
		return result;
	}

	public void SetSlot(DormFurObj objFur)
	{
		HotfixEnum.DormFurType type = objFur.Type;
		HotfixEnum.DormFurRotate rotate = objFur.Rotate;
		switch (type)
		{
		case HotfixEnum.DormFurType.OnFloor:
		case HotfixEnum.DormFurType.OnWall:
		case HotfixEnum.DormFurType.FloorCarpet:
		case HotfixEnum.DormFurType.FloorPoster:
			obj_FloorWall = objFur;
			break;
		case HotfixEnum.DormFurType.Carpet:
			obj_Carpet = objFur;
			break;
		case HotfixEnum.DormFurType.Poster:
			if ((int)rotate % 2 == 0)
			{
				obj_Poster_L = objFur;
			}
			else
			{
				obj_Poster_R = objFur;
			}
			break;
		case HotfixEnum.DormFurType.Wall:
		case HotfixEnum.DormFurType.Floor:
			break;
		}
	}

	public void ClearSlot(DormFurObj objFur)
	{
		HotfixEnum.DormFurType type = objFur.Type;
		HotfixEnum.DormFurRotate rotate = objFur.Rotate;
		switch (type)
		{
		case HotfixEnum.DormFurType.OnFloor:
		case HotfixEnum.DormFurType.OnWall:
		case HotfixEnum.DormFurType.FloorCarpet:
		case HotfixEnum.DormFurType.FloorPoster:
			if (obj_FloorWall == objFur)
			{
				obj_FloorWall = null;
			}
			break;
		case HotfixEnum.DormFurType.Carpet:
			if (obj_Carpet == objFur)
			{
				obj_Carpet = null;
			}
			break;
		case HotfixEnum.DormFurType.Poster:
			if ((int)rotate % 2 == 0)
			{
				if (obj_Poster_L == objFur)
				{
					obj_Poster_L = null;
				}
			}
			else if (obj_Poster_R == objFur)
			{
				obj_Poster_R = null;
			}
			break;
		case HotfixEnum.DormFurType.Wall:
		case HotfixEnum.DormFurType.Floor:
			break;
		}
	}

	public bool IsSame(DormRoomObjCell clone)
	{
		if (x != clone.x || y != clone.y || z != clone.z)
		{
			return false;
		}
		if (!IsSameFur(obj_FloorWall, clone.Cloned_FloorWall_id, clone.Cloned_FloorWall_rotate))
		{
			return false;
		}
		if (!IsSameFur(obj_Carpet, clone.Cloned_Carpet_id, clone.Cloned_Carpet_rotate))
		{
			return false;
		}
		if (!IsSameFur(obj_Poster_L, clone.Cloned_PosterL_id, clone.Cloned_PosterL_rotate))
		{
			return false;
		}
		if (!IsSameFur(obj_Poster_R, clone.Cloned_PosterR_id, clone.Cloned_PosterR_rotate))
		{
			return false;
		}
		return true;
	}

	public void CloneFur(DormFurObj objFloorWall, DormFurObj objCarpet, DormFurObj objPosterL, DormFurObj objPosterR)
	{
		Cloned_FloorWall_id = ((objFloorWall != null) ? objFloorWall.FurId : 0);
		Cloned_FloorWall_rotate = ((objFloorWall != null) ? objFloorWall.Rotate : HotfixEnum.DormFurRotate.None);
		Cloned_Carpet_id = ((objCarpet != null) ? objCarpet.FurId : 0);
		Cloned_Carpet_rotate = ((objCarpet != null) ? objCarpet.Rotate : HotfixEnum.DormFurRotate.None);
		Cloned_PosterL_id = ((objPosterL != null) ? objPosterL.FurId : 0);
		Cloned_PosterL_rotate = ((objPosterL != null) ? objPosterL.Rotate : HotfixEnum.DormFurRotate.None);
		Cloned_PosterR_id = ((objPosterR != null) ? objPosterR.FurId : 0);
		Cloned_PosterR_rotate = ((objPosterR != null) ? objPosterR.Rotate : HotfixEnum.DormFurRotate.None);
	}

	private bool IsSameFur(DormFurObj objA, int id, HotfixEnum.DormFurRotate r)
	{
		int num = ((objA != null) ? objA.FurId : 0);
		HotfixEnum.DormFurRotate dormFurRotate = ((objA != null) ? objA.Rotate : HotfixEnum.DormFurRotate.None);
		if (num == id)
		{
			return dormFurRotate == r;
		}
		return false;
	}

	private void DoSetColor(ERoomCellColor eFloor, ERoomCellColor eWall_L, ERoomCellColor eWall_R)
	{
		X_Z_G?.SetActive(eFloor == ERoomCellColor.Floor_Green);
		X_Z_R?.SetActive(eFloor == ERoomCellColor.Floor_Red);
		X_Y_G?.SetActive(eWall_L == ERoomCellColor.Wall_L_Green);
		X_Y_R?.SetActive(eWall_L == ERoomCellColor.Wall_L_Red);
		Z_Y_G?.SetActive(eWall_R == ERoomCellColor.Wall_R_Green);
		Z_Y_R?.SetActive(eWall_R == ERoomCellColor.Wall_R_Red);
	}

	public bool SetColor(ERoomCellResult eResult, DormFurObj objFur, int l, int w, int h)
	{
		if (Node == null || Node.transform.childCount <= 0 || objFur == null)
		{
			return true;
		}
		bool result = true;
		if (dictCellColor.Keys.Count > 0)
		{
			foreach (DormFurObj key in dictCellColor.Keys)
			{
				if (DormUtil.InConflictWith(objFur.Type, key.Type))
				{
					result = false;
					break;
				}
			}
		}
		HotfixEnum.DormFurType type = objFur.Type;
		HotfixEnum.DormFurRotate rotate = objFur.Rotate;
		ERoomCellColor eRoomCellColor = ERoomCellColor.None;
		ERoomCellColor eRoomCellColor2 = ERoomCellColor.None;
		ERoomCellColor eRoomCellColor3 = ERoomCellColor.None;
		switch (eResult)
		{
		case ERoomCellResult.Legal:
			switch (type)
			{
			case HotfixEnum.DormFurType.OnFloor:
			case HotfixEnum.DormFurType.Carpet:
			case HotfixEnum.DormFurType.FloorCarpet:
			case HotfixEnum.DormFurType.FloorPoster:
				if (h == 0)
				{
					eRoomCellColor = ERoomCellColor.Floor_Green;
				}
				break;
			case HotfixEnum.DormFurType.OnWall:
			case HotfixEnum.DormFurType.Poster:
				if ((int)rotate % 2 == 0)
				{
					if (w == 0)
					{
						eRoomCellColor2 = ERoomCellColor.Wall_L_Green;
					}
				}
				else if (l == 0)
				{
					eRoomCellColor3 = ERoomCellColor.Wall_R_Green;
				}
				break;
			}
			break;
		case ERoomCellResult.Illegal_Floor:
			switch (type)
			{
			case HotfixEnum.DormFurType.OnFloor:
			case HotfixEnum.DormFurType.Carpet:
			case HotfixEnum.DormFurType.FloorCarpet:
			case HotfixEnum.DormFurType.FloorPoster:
				if (h == 0)
				{
					eRoomCellColor = ERoomCellColor.Floor_Red;
				}
				break;
			case HotfixEnum.DormFurType.OnWall:
				if (h == 0)
				{
					eRoomCellColor = ERoomCellColor.Floor_Red;
				}
				if ((int)rotate % 2 == 0)
				{
					if (w == 0)
					{
						eRoomCellColor2 = ERoomCellColor.Wall_L_Green;
					}
				}
				else if (l == 0)
				{
					eRoomCellColor3 = ERoomCellColor.Wall_R_Green;
				}
				break;
			}
			break;
		case ERoomCellResult.Illegal_Wall_Left:
			switch (type)
			{
			case HotfixEnum.DormFurType.OnFloor:
			case HotfixEnum.DormFurType.FloorCarpet:
			case HotfixEnum.DormFurType.FloorPoster:
				if (h == 0)
				{
					eRoomCellColor = ERoomCellColor.Floor_Green;
				}
				if (w == 0)
				{
					eRoomCellColor2 = ERoomCellColor.Wall_L_Red;
				}
				break;
			case HotfixEnum.DormFurType.OnWall:
				if ((int)rotate % 2 == 0)
				{
					if (w == 0)
					{
						eRoomCellColor2 = ERoomCellColor.Wall_L_Red;
					}
					break;
				}
				if (l == 0)
				{
					eRoomCellColor3 = ERoomCellColor.Wall_R_Green;
				}
				if (w == 0)
				{
					eRoomCellColor2 = ERoomCellColor.Wall_L_Red;
				}
				break;
			case HotfixEnum.DormFurType.Poster:
				if (w == 0 && rotate == HotfixEnum.DormFurRotate.None)
				{
					eRoomCellColor2 = ERoomCellColor.Wall_L_Red;
				}
				break;
			}
			break;
		case ERoomCellResult.Illegal_Wall_Right:
			switch (type)
			{
			case HotfixEnum.DormFurType.OnFloor:
			case HotfixEnum.DormFurType.FloorCarpet:
			case HotfixEnum.DormFurType.FloorPoster:
				if (h == 0)
				{
					eRoomCellColor = ERoomCellColor.Floor_Green;
				}
				if (l == 0)
				{
					eRoomCellColor3 = ERoomCellColor.Wall_R_Red;
				}
				break;
			case HotfixEnum.DormFurType.OnWall:
				if ((int)rotate % 2 == 0)
				{
					if (w == 0)
					{
						eRoomCellColor2 = ERoomCellColor.Wall_L_Green;
					}
					if (l == 0)
					{
						eRoomCellColor3 = ERoomCellColor.Wall_R_Red;
					}
				}
				else if (l == 0)
				{
					eRoomCellColor3 = ERoomCellColor.Wall_R_Red;
				}
				break;
			case HotfixEnum.DormFurType.Poster:
				if (l == 0 && rotate == HotfixEnum.DormFurRotate.Quarter)
				{
					eRoomCellColor3 = ERoomCellColor.Wall_R_Red;
				}
				break;
			}
			break;
		}
		if (dictCellColor.ContainsKey(objFur))
		{
			List<ERoomCellColor> list = dictCellColor.get_Item(objFur);
			if (list == null)
			{
				list = new List<ERoomCellColor>();
			}
			list.Clear();
			list.Add(eRoomCellColor);
			list.Add(eRoomCellColor2);
			list.Add(eRoomCellColor3);
			dictCellColor.set_Item(objFur, list);
		}
		else
		{
			List<ERoomCellColor> value = new List<ERoomCellColor> { eRoomCellColor, eRoomCellColor2, eRoomCellColor3 };
			dictCellColor.Add(objFur, value);
		}
		if (DormConstValue.FORCE_SHOW_HEM)
		{
			switch (objFur.Type)
			{
			case HotfixEnum.DormFurType.OnFloor:
			case HotfixEnum.DormFurType.FloorCarpet:
			case HotfixEnum.DormFurType.FloorPoster:
				if (z == 0 && eRoomCellColor2 == ERoomCellColor.None)
				{
					eRoomCellColor2 = ((eResult == ERoomCellResult.Legal) ? ERoomCellColor.Wall_L_Green : ERoomCellColor.Wall_L_Red);
				}
				if (x == 0 && eRoomCellColor3 == ERoomCellColor.None)
				{
					eRoomCellColor3 = ((eResult == ERoomCellResult.Legal) ? ERoomCellColor.Wall_R_Green : ERoomCellColor.Wall_R_Red);
				}
				break;
			case HotfixEnum.DormFurType.OnWall:
				if (y == 0 && eRoomCellColor == ERoomCellColor.None)
				{
					eRoomCellColor = ((eResult != ERoomCellResult.Legal) ? ERoomCellColor.Floor_Red : ERoomCellColor.Floor_Green);
				}
				if (z == 0 && eRoomCellColor2 == ERoomCellColor.None)
				{
					eRoomCellColor2 = ((eResult == ERoomCellResult.Legal) ? ERoomCellColor.Wall_L_Green : ERoomCellColor.Wall_L_Red);
				}
				if (x == 0 && eRoomCellColor3 == ERoomCellColor.None)
				{
					eRoomCellColor3 = ((eResult == ERoomCellResult.Legal) ? ERoomCellColor.Wall_R_Green : ERoomCellColor.Wall_R_Red);
				}
				break;
			}
		}
		DoSetColor(eRoomCellColor, eRoomCellColor2, eRoomCellColor3);
		return result;
	}

	public void SetForceRed(DormFurObj objFur)
	{
		if (Node == null || Node.transform.childCount <= 0 || objFur == null || !dictCellColor.ContainsKey(objFur))
		{
			return;
		}
		List<ERoomCellColor> list = dictCellColor.get_Item(objFur);
		if (list == null)
		{
			return;
		}
		ERoomCellColor eRoomCellColor = list.get_Item(0);
		ERoomCellColor eRoomCellColor2 = list.get_Item(1);
		ERoomCellColor eRoomCellColor3 = list.get_Item(2);
		if (eRoomCellColor == ERoomCellColor.Floor_Green)
		{
			eRoomCellColor = ERoomCellColor.Floor_Red;
		}
		if (eRoomCellColor2 == ERoomCellColor.Wall_L_Green)
		{
			eRoomCellColor2 = ERoomCellColor.Wall_L_Red;
		}
		if (eRoomCellColor3 == ERoomCellColor.Wall_R_Green)
		{
			eRoomCellColor3 = ERoomCellColor.Wall_R_Red;
		}
		if (DormConstValue.FORCE_SHOW_HEM)
		{
			switch (objFur.Type)
			{
			case HotfixEnum.DormFurType.OnFloor:
			case HotfixEnum.DormFurType.FloorCarpet:
			case HotfixEnum.DormFurType.FloorPoster:
				if (z == 0)
				{
					eRoomCellColor2 = ERoomCellColor.Wall_L_Red;
				}
				if (x == 0)
				{
					eRoomCellColor3 = ERoomCellColor.Wall_R_Red;
				}
				break;
			case HotfixEnum.DormFurType.OnWall:
				if (y == 0)
				{
					eRoomCellColor = ERoomCellColor.Floor_Red;
				}
				if (z == 0)
				{
					eRoomCellColor2 = ERoomCellColor.Wall_L_Red;
				}
				if (x == 0)
				{
					eRoomCellColor3 = ERoomCellColor.Wall_R_Red;
				}
				break;
			}
		}
		DoSetColor(eRoomCellColor, eRoomCellColor2, eRoomCellColor3);
	}

	public void SetAffectRed(DormFurObj illegal, DormFurObj objFur, int l, int w, int h)
	{
		if (Node == null || Node.transform.childCount <= 0 || illegal == null || objFur == null)
		{
			return;
		}
		ERoomCellResult eRoomCellResult = ERoomCellResult.Illegal_Floor;
		if (objFur.IsOnWall)
		{
			eRoomCellResult = (((int)objFur.Rotate % 2 != 0) ? ERoomCellResult.Illegal_Wall_Right : ERoomCellResult.Illegal_Wall_Left);
		}
		HotfixEnum.DormFurType type = objFur.Type;
		HotfixEnum.DormFurRotate rotate = objFur.Rotate;
		ERoomCellColor eRoomCellColor = ERoomCellColor.None;
		ERoomCellColor eRoomCellColor2 = ERoomCellColor.None;
		ERoomCellColor eRoomCellColor3 = ERoomCellColor.None;
		switch (eRoomCellResult)
		{
		case ERoomCellResult.Legal:
			switch (type)
			{
			case HotfixEnum.DormFurType.OnFloor:
			case HotfixEnum.DormFurType.Carpet:
			case HotfixEnum.DormFurType.FloorCarpet:
			case HotfixEnum.DormFurType.FloorPoster:
				if (h == 0)
				{
					eRoomCellColor = ERoomCellColor.Floor_Green;
				}
				break;
			case HotfixEnum.DormFurType.OnWall:
			case HotfixEnum.DormFurType.Poster:
				if ((int)rotate % 2 == 0)
				{
					if (w == 0)
					{
						eRoomCellColor2 = ERoomCellColor.Wall_L_Green;
					}
				}
				else if (l == 0)
				{
					eRoomCellColor3 = ERoomCellColor.Wall_R_Green;
				}
				break;
			}
			break;
		case ERoomCellResult.Illegal_Floor:
			switch (type)
			{
			case HotfixEnum.DormFurType.OnFloor:
			case HotfixEnum.DormFurType.Carpet:
			case HotfixEnum.DormFurType.FloorCarpet:
			case HotfixEnum.DormFurType.FloorPoster:
				if (h == 0)
				{
					eRoomCellColor = ERoomCellColor.Floor_Red;
				}
				break;
			case HotfixEnum.DormFurType.OnWall:
				if (h == 0)
				{
					eRoomCellColor = ERoomCellColor.Floor_Red;
				}
				if ((int)rotate % 2 == 0)
				{
					if (w == 0)
					{
						eRoomCellColor2 = ERoomCellColor.Wall_L_Green;
					}
				}
				else if (l == 0)
				{
					eRoomCellColor3 = ERoomCellColor.Wall_R_Green;
				}
				break;
			}
			break;
		case ERoomCellResult.Illegal_Wall_Left:
			switch (type)
			{
			case HotfixEnum.DormFurType.OnFloor:
			case HotfixEnum.DormFurType.FloorCarpet:
			case HotfixEnum.DormFurType.FloorPoster:
				if (h == 0)
				{
					eRoomCellColor = ERoomCellColor.Floor_Green;
				}
				if (w == 0)
				{
					eRoomCellColor2 = ERoomCellColor.Wall_L_Red;
				}
				break;
			case HotfixEnum.DormFurType.OnWall:
				if ((int)rotate % 2 == 0)
				{
					if (w == 0)
					{
						eRoomCellColor2 = ERoomCellColor.Wall_L_Red;
					}
					break;
				}
				if (l == 0)
				{
					eRoomCellColor3 = ERoomCellColor.Wall_R_Green;
				}
				if (w == 0)
				{
					eRoomCellColor2 = ERoomCellColor.Wall_L_Red;
				}
				break;
			case HotfixEnum.DormFurType.Poster:
				if (w == 0 && rotate == HotfixEnum.DormFurRotate.None)
				{
					eRoomCellColor2 = ERoomCellColor.Wall_L_Red;
				}
				break;
			}
			break;
		case ERoomCellResult.Illegal_Wall_Right:
			switch (type)
			{
			case HotfixEnum.DormFurType.OnFloor:
			case HotfixEnum.DormFurType.FloorCarpet:
			case HotfixEnum.DormFurType.FloorPoster:
				if (h == 0)
				{
					eRoomCellColor = ERoomCellColor.Floor_Green;
				}
				if (l == 0)
				{
					eRoomCellColor3 = ERoomCellColor.Wall_R_Red;
				}
				break;
			case HotfixEnum.DormFurType.OnWall:
				if ((int)rotate % 2 == 0)
				{
					if (w == 0)
					{
						eRoomCellColor2 = ERoomCellColor.Wall_L_Green;
					}
					if (l == 0)
					{
						eRoomCellColor3 = ERoomCellColor.Wall_R_Red;
					}
				}
				else if (l == 0)
				{
					eRoomCellColor3 = ERoomCellColor.Wall_R_Red;
				}
				break;
			case HotfixEnum.DormFurType.Poster:
				if (l == 0 && rotate == HotfixEnum.DormFurRotate.Quarter)
				{
					eRoomCellColor3 = ERoomCellColor.Wall_R_Red;
				}
				break;
			}
			break;
		}
		if (DormConstValue.FORCE_SHOW_HEM)
		{
			switch (objFur.Type)
			{
			case HotfixEnum.DormFurType.OnFloor:
			case HotfixEnum.DormFurType.FloorCarpet:
			case HotfixEnum.DormFurType.FloorPoster:
				if (z == 0)
				{
					eRoomCellColor2 = ERoomCellColor.Wall_L_Red;
				}
				if (x == 0)
				{
					eRoomCellColor3 = ERoomCellColor.Wall_R_Red;
				}
				break;
			case HotfixEnum.DormFurType.OnWall:
				if (y == 0)
				{
					eRoomCellColor = ERoomCellColor.Floor_Red;
				}
				if (z == 0)
				{
					eRoomCellColor2 = ERoomCellColor.Wall_L_Red;
				}
				if (x == 0)
				{
					eRoomCellColor3 = ERoomCellColor.Wall_R_Red;
				}
				break;
			}
		}
		if (!dictCellColor.ContainsKey(illegal))
		{
			List<ERoomCellColor> value = new List<ERoomCellColor> { eRoomCellColor, eRoomCellColor2, eRoomCellColor3 };
			dictCellColor.Add(illegal, value);
		}
		DoSetColor(eRoomCellColor, eRoomCellColor2, eRoomCellColor3);
	}

	public bool ResetColor(DormFurObj objFur)
	{
		if (Node == null || Node.transform.childCount <= 0)
		{
			return true;
		}
		if (objFur == null)
		{
			X_Z_G?.SetActive(value: false);
			X_Z_R?.SetActive(value: false);
			X_Y_G?.SetActive(value: false);
			X_Y_R?.SetActive(value: false);
			Z_Y_G?.SetActive(value: false);
			Z_Y_R?.SetActive(value: false);
			dictCellColor.Clear();
		}
		else
		{
			if (dictCellColor.ContainsKey(objFur))
			{
				dictCellColor.Remove(objFur);
			}
			if (dictCellColor.Keys.Count <= 0)
			{
				X_Z_G?.SetActive(value: false);
				X_Z_R?.SetActive(value: false);
				X_Y_G?.SetActive(value: false);
				X_Y_R?.SetActive(value: false);
				Z_Y_G?.SetActive(value: false);
				Z_Y_R?.SetActive(value: false);
			}
		}
		return dictCellColor.Keys.Count <= 0;
	}
}
