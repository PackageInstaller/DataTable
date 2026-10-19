using System.Collections.Generic;
using System.Runtime.InteropServices;

[StructLayout(LayoutKind.Sequential, Size = 1)]
public struct InteractStateId
{
	public const int HIDE = -1;

	public const int SHOW = 0;

	public const int Transfer_Active = -2;

	public const int Transfer_Inactive = 0;

	public const int TemporaryPortal_Active = 0;

	public const int TemporaryPortal_Inactive = 1;

	public const int OneWayDoor_Active = 0;

	public const int OneWayDoor_Inactive = -99;

	public const int BlockInteract_Active = 0;

	public const int BlockInteract_Inactive = 1;

	public const int Lighthouse_Active = -2;

	public const int Lighthouse_Inactive = 0;

	public const int HiddenRoom_Lock = -1;

	public const int HiddenRoom_Inactive = 0;

	public const int HiddenRoom_Active = 1;

	public const int Raid_Active = 1;

	public const int Raid_Inactive = 0;

	public const int Temple_Active = 1;

	public const int Temple_Inactive = 0;

	public const int NPC_Active = -2;

	public const int NPC_Inactive = -1;

	public const int SwitchMotionPath_Active = 0;

	public const int SwitchMotionPath_Inactive = -1;

	public const int BossRoomEnterRecord_Active = -2;

	public const int BossRoomEnterRecord_Inactive = 0;

	public const int MonsterPoint_Show = 0;

	public const int MonsterPoint_GetReward = 1;

	public const int MonsterPoint_Disable = -2;

	public const int CollectionPoint_Show = 0;

	public const int CollectionPoint_GetReward = 1;

	public const int CollectionPoint_Disable = -2;

	public static Dictionary<int, (int activeStateId, int inActiveStateId)> iconTypeStateId = new Dictionary<int, (int, int)>
	{
		{
			1001,
			(-2, 0)
		},
		{
			1002,
			(-2, 0)
		},
		{
			1003,
			(-2, -1)
		},
		{
			1016,
			(0, -1)
		},
		{
			1015,
			(1, 0)
		},
		{
			1017,
			(1, 0)
		},
		{
			1020,
			(0, 1)
		},
		{
			1021,
			(0, 1)
		},
		{
			1022,
			(0, -99)
		},
		{
			10201,
			(0, -99)
		}
	};

	public static bool IconActive(int iconType, int stateId)
	{
		if (iconTypeStateId.TryGetValue(iconType, out (int, int) value))
		{
			return stateId == value.Item1;
		}
		return false;
	}
}
