using System.Collections.Generic;
using System.Linq;
using Bamboo.Collections;

namespace ACT.UI;

public class DeviceCustomUISchemeId
{
	public const int Pc_KeyBoardMouse_Fixed_Device = 211;

	public const int Pad_KeyBoardMouse_Fixed_Device = 212;

	public const int Pc_Handle_Fixed_Device = 213;

	public const int Phone_Handle_Fixed_Device = 214;

	public const int Pad_Handle_Fixed_Device = 215;

	public const int Mobile_Fixed_Default = 111;

	public const int Mobile_Fixed_GamePadLike = 112;

	public const int Mobile_Fixed_Tradition = 113;

	public const int Mobile_Fixed_Act = 114;

	public const int Mobile_Custom_Preset_1 = 121;

	public const int Mobile_Custom_Preset_2 = 122;

	public const int Mobile_Custom_Preset_3 = 123;

	public const int Mobile_Custom_Preset_4 = 124;

	public const int Mobile_Custom_1 = 131;

	public const int Mobile_Custom_2 = 132;

	public const int Mobile_Custom_3 = 133;

	public const int Mobile_Custom_4 = 134;

	private static readonly List<int> _validMobileFixedId = new List<int> { 111, 112, 113, 114 };

	private static readonly List<int> _validMobileCustomPresetId = new List<int> { 121, 122, 123, 124 };

	private static readonly List<int> _validMobileCustomId = new List<int> { 131, 132, 133, 134 };

	public const int MobileFixedNum = 4;

	public const int MobileCustomPresetNum = 4;

	public const int MobileCustomNum = 4;

	public const int MobileCustomTotalNum = 8;

	public static int CustomIdComparer(int a, int b)
	{
		if (IsValidMobileCustomId(a) && IsValidMobileCustomPresetId(b))
		{
			return -1;
		}
		if (IsValidMobileCustomPresetId(a) && IsValidMobileCustomId(b))
		{
			return 1;
		}
		if (IsValidMobileCustomId(a) && IsValidMobileCustomId(b))
		{
			return a - b;
		}
		if (IsValidMobileCustomPresetId(a) && IsValidMobileCustomPresetId(b))
		{
			return a - b;
		}
		return 0;
	}

	public static int Fixed2DefaultCustomPreset(int fixedId)
	{
		return fixedId switch
		{
			111 => 121, 
			112 => 122, 
			113 => 123, 
			114 => 124, 
			_ => 0, 
		};
	}

	public static int Fixed2DefaultCustom(int fixedId)
	{
		return fixedId switch
		{
			111 => 131, 
			112 => 132, 
			113 => 133, 
			114 => 134, 
			_ => 0, 
		};
	}

	public static bool IsValidMobileId(int id)
	{
		if (!IsValidMobileFixedId(id) && !IsValidMobileCustomPresetId(id))
		{
			return IsValidMobileCustomId(id);
		}
		return true;
	}

	public static bool IsValidMobileFixedId(int id)
	{
		return _validMobileFixedId.Contains(id);
	}

	public static bool IsValidMobileCustomPresetId(int id)
	{
		return _validMobileCustomPresetId.Contains(id);
	}

	public static bool IsValidMobileCustomId(int id)
	{
		return _validMobileCustomId.Contains(id);
	}

	public static int GetDefaultMobileFixedId()
	{
		return 111;
	}

	public static int GetDefaultMobileCustomPresetId()
	{
		return 121;
	}

	public static int GetMobileFixedIdIndex(int id)
	{
		if (IsValidMobileFixedId(id))
		{
			return _validMobileFixedId.IndexOf(id);
		}
		return -1;
	}

	public static int GetMobileFixedIdByIndex(int index)
	{
		if (index < 0 || index >= _validMobileFixedId.Count)
		{
			return 0;
		}
		return _validMobileFixedId[index];
	}

	public static int GetMobileCustomPresetIdIndex(int id)
	{
		if (IsValidMobileCustomPresetId(id))
		{
			return _validMobileCustomPresetId.IndexOf(id);
		}
		return -1;
	}

	public static int GetMobileCustomPresetIdByIndex(int index)
	{
		if (index < 0 || index >= _validMobileCustomPresetId.Count)
		{
			return 0;
		}
		return _validMobileCustomPresetId[index];
	}

	public static int GetMobileCustomIdByIndex(int index)
	{
		if (index < 0 || index >= _validMobileCustomId.Count)
		{
			return 0;
		}
		return _validMobileCustomId[index];
	}

	public static void GetRedundantMobileCustomId(Dictionary<int, CustomUIScheme>.KeyCollection ids, ref BList<int> redundantId)
	{
		foreach (int id in ids)
		{
			if (!IsValidMobileCustomId(id))
			{
				redundantId.Add(id);
			}
		}
	}

	public static void GetMissingMobileCustomId(Dictionary<int, CustomUIScheme>.KeyCollection ids, ref BList<int> redundantId)
	{
		foreach (int item in _validMobileCustomId)
		{
			if (!ids.Contains(item))
			{
				redundantId.Add(item);
			}
		}
	}
}
