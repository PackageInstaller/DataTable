using System.Collections.Generic;
using UnityEngine;

public static class DormUtil
{
	public static bool TryGetFurObjByCollider(Collider col, out DormFurObj obj)
	{
		obj = col.gameObject.GetComponentInParent<DormFurObj>();
		return obj != null;
	}

	public static bool TrySetFurObjAnimNaviCut(DormFurObj obj, bool bEnable)
	{
		if (obj == null)
		{
			return false;
		}
		return obj.EnableAnimNaviCut(bEnable);
	}

	public static bool InConflictWith(HotfixEnum.DormFurType e1, HotfixEnum.DormFurType e2)
	{
		foreach (List<HotfixEnum.DormFurType> item in DormConstValue.FUR_TYPE_CONFLICT)
		{
			if (item.Contains(e1) && item.Contains(e2))
			{
				return true;
			}
		}
		return false;
	}

	public static List<Vector3> GetAroundCells(DormFurObj objFur, DormRoomObj objRoom)
	{
		List<Vector3> list = new List<Vector3>();
		if (objFur == null || objRoom == null || !objFur.CalcFloorCapacity)
		{
			return list;
		}
		int num = objFur.RoomPos.x - 1;
		int num2 = objFur.RoomPos.z - 1;
		int num3 = objFur.LEN + 2;
		int num4 = objFur.WID + 2;
		for (int i = 0; i < num4; i++)
		{
			for (int j = 0; j < num3; j++)
			{
				if (j == 0 || j == num3 - 1 || i == 0 || i == num4 - 1)
				{
					int l = j + num;
					int w = i + num2;
					if (objRoom.CheckCellCanPutChar(l, w) && objRoom.TryGetCellWorldPos(l, w, out var worldPos))
					{
						list.Add(worldPos);
					}
				}
			}
		}
		return list;
	}
}
