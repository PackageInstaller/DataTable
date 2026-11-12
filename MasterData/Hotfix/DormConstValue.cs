using System.Collections.Generic;
using UnityEngine;

public static class DormConstValue
{
	public static readonly Vector3 V3_ZERO_OFFSET = new Vector3(0.5f, 0.5f, 0.5f);

	public static readonly Vector3 V3_SCALE = new Vector3(1.1f, 1.1f, 1.1f);

	public static readonly bool NAME_BY_LWH = false;

	public static readonly bool CAN_ELEVATOR_SELECTED = true;

	public static readonly string INTER_POINT_IN_FBX_START = "inter_point_start_";

	public static readonly string INTER_POINT_IN_FBX_END = "inter_point_end_";

	public static readonly string INTER_POINT_NAME_START = "point_start_";

	public static readonly string INTER_POINT_NAME_END = "point_end_";

	public static readonly string FUR_ANIM_NAVI_CUT = "==navicut_root==/--ANIM_NAVI_CUT--";

	public static readonly string ROOM_CELL = "Assets/AssetBundles/DormFurniture/Common/t_cell_room.prefab";

	public static readonly bool FORCE_ALL_ROOM_CELL_INS = false;

	public static readonly bool FORCE_LEGAL = false;

	public static readonly bool FORCE_ALL_RED = true;

	public static readonly bool FORCE_SHOW_HEM = true;

	public static readonly bool FORCE_AFFECT_ALL = true;

	public static readonly bool CALC_ILLEGAL_FUR_FLOOR_CELL_USED = true;

	public static readonly bool ALLOW_ILLEGAL_WHEN_APPLY_PRESET = true;

	public static readonly List<List<HotfixEnum.DormFurType>> FUR_TYPE_CONFLICT = new List<List<HotfixEnum.DormFurType>>
	{
		new List<HotfixEnum.DormFurType>
		{
			HotfixEnum.DormFurType.OnFloor,
			HotfixEnum.DormFurType.OnWall,
			HotfixEnum.DormFurType.FloorCarpet,
			HotfixEnum.DormFurType.FloorPoster
		},
		new List<HotfixEnum.DormFurType>
		{
			HotfixEnum.DormFurType.Carpet,
			HotfixEnum.DormFurType.FloorCarpet
		},
		new List<HotfixEnum.DormFurType>
		{
			HotfixEnum.DormFurType.Poster,
			HotfixEnum.DormFurType.FloorPoster
		}
	};

	public static readonly int LAYER_FURNITURE = 10;

	public static readonly int LAYER_FLOOR_WALL = 12;

	public static readonly int LAYER_ROOM_BOUND = 14;

	public static readonly int LAYER_ACTOR = 8;
}
