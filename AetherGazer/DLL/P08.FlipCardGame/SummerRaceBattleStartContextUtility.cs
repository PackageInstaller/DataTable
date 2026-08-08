using System;
using System.Collections.Generic;

public static class SummerRaceBattleStartContextUtility
{
	public static bool TryParseFightMode(string value, out SummerRaceFightManager.FightMode mode)
	{
		switch ((value ?? string.Empty).Trim().ToLowerInvariant())
		{
		case "1":
		case "championship":
		case "normal":
			mode = SummerRaceFightManager.FightMode.Championship;
			return true;
		case "2":
		case "survival_practice":
			mode = SummerRaceFightManager.FightMode.SurvivalPractice;
			return true;
		case "3":
		case "one_vs_two_practice":
		case "1v2":
			mode = SummerRaceFightManager.FightMode.OneVsTwoPractice;
			return true;
		case "4":
		case "challenge":
			mode = SummerRaceFightManager.FightMode.Challenge;
			return true;
		default:
			mode = SummerRaceFightManager.FightMode.Championship;
			return false;
		}
	}

	public static bool TryParseBodyType(string value, out SummerRaceBodyType bodyType)
	{
		return Enum.TryParse<SummerRaceBodyType>((value ?? string.Empty).Trim(), ignoreCase: true, out bodyType);
	}

	public static WeaponKind[] ParseWeaponKinds(string[] values)
	{
		return ParseEnumArray<WeaponKind>(values);
	}

	public static EquipKind[] ParseEquipKinds(string[] values)
	{
		return ParseEnumArray<EquipKind>(values);
	}

	private static TEnum[] ParseEnumArray<TEnum>(string[] values) where TEnum : struct
	{
		if (values == null || values.Length == 0)
		{
			return Array.Empty<TEnum>();
		}
		List<TEnum> list = new List<TEnum>(values.Length);
		foreach (string text in values)
		{
			if (!string.IsNullOrWhiteSpace(text) && Enum.TryParse<TEnum>(text.Trim(), ignoreCase: true, out var result))
			{
				list.Add(result);
			}
		}
		if (list.Count <= 0)
		{
			return Array.Empty<TEnum>();
		}
		return list.ToArray();
	}
}
