#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;

namespace Ase;

public static class UiConvert
{
	public static class Hero
	{
		public static Dictionary<HeroAttributeEnum, string> Attribute2Color = new Dictionary<HeroAttributeEnum, string>
		{
			[HeroAttributeEnum.Wind] = "#284f3e",
			[HeroAttributeEnum.Water] = "#335b99",
			[HeroAttributeEnum.Fire] = "#913627",
			[HeroAttributeEnum.Light] = "#9d6f2a",
			[HeroAttributeEnum.Dark] = "#694c9a",
			[HeroAttributeEnum.Ice] = "#598a9d",
			[HeroAttributeEnum.Thunder] = "#dce0f6"
		};

		public static Dictionary<HeroAttributeEnum, string> Attribute2Name = new Dictionary<HeroAttributeEnum, string>
		{
			[HeroAttributeEnum.Wind] = "风",
			[HeroAttributeEnum.Water] = "水",
			[HeroAttributeEnum.Fire] = "火",
			[HeroAttributeEnum.Light] = "光",
			[HeroAttributeEnum.Dark] = "暗",
			[HeroAttributeEnum.Ice] = "冰",
			[HeroAttributeEnum.Thunder] = "雷"
		};
	}

	public static class Equip
	{
		public static Dictionary<WeaponEnum, string> WeaponEnum2Name = new Dictionary<WeaponEnum, string>
		{
			[WeaponEnum.Sword] = "斩锋",
			[WeaponEnum.Gun] = "灵御",
			[WeaponEnum.Bow] = "翎射",
			[WeaponEnum.Gloves] = "强袭",
			[WeaponEnum.Hammer] = "破势",
			[WeaponEnum.Lance] = "锐贯"
		};

		public static Dictionary<ArmourEnum, string> ArmourEnum2Name = new Dictionary<ArmourEnum, string>
		{
			[ArmourEnum.Heart] = "心",
			[ArmourEnum.Box] = "匣",
			[ArmourEnum.Lamp] = "灯",
			[ArmourEnum.Key] = "钥",
			[ArmourEnum.Book] = "书",
			[ArmourEnum.Rock] = "石"
		};

		public static Dictionary<int, string> EquipRarity2Name = new Dictionary<int, string>
		{
			[1] = "绿色",
			[2] = "蓝色",
			[3] = "紫色",
			[4] = "金色"
		};
	}

	public static class NumConvert
	{
		public static string[] Small = new string[14]
		{
			"零", "一", "二", "三", "四", "五", "六", "七", "八", "九",
			"十", "十五", "二十", "二十五"
		};

		public static string[] Big = new string[14]
		{
			"零", "壹", "贰", "叁", "肆", "伍", "陆", "柒", "捌", "玖",
			"拾", "佰", "仟", "万"
		};
	}

	public static class TextConvert
	{
		public static bool DebugDataTable(object obj, string name, int id)
		{
			if (obj == null)
			{
				Log.Error($"表格{name}中的数据:{id}找不到");
				Toast.ShowError($"表格{name}中的数据:{id}找不到");
				return false;
			}
			return true;
		}
	}

	public static class BitwiseConvert
	{
		public static bool Bitwise(int num, int index)
		{
			return ((num >> index) & 1) > 0;
		}

		public static bool Bitwise(List<int> numList, int index)
		{
			int num = 0;
			if (numList == null || numList.Count == 0)
			{
				return false;
			}
			int num2 = 0;
			int num3 = index / 32;
			if (numList.Count >= num3 + 1)
			{
				num = numList[num3];
				num2 = index % 32;
				return ((num >> num2) & 1) > 0;
			}
			return false;
		}

		public static bool Bitwise(List<long> numList, int index)
		{
			long num = 0L;
			if (numList == null || numList.Count == 0)
			{
				return false;
			}
			int num2 = 0;
			int num3 = index / 63;
			if (numList.Count >= num3 + 1)
			{
				num = numList[num3];
				num2 = index % 63;
				return (num & (1L << num2)) > 0;
			}
			return false;
		}
	}
}
