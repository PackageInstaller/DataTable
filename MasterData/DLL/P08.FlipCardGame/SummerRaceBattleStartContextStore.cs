using System;
using UnityEngine;

public static class SummerRaceBattleStartContextStore
{
	private static SummerRaceBattleStartContext pendingContext;

	public static bool TryStoreFromJson(string json, out string error)
	{
		error = string.Empty;
		if (string.IsNullOrWhiteSpace(json))
		{
			error = "battle start payload is empty.";
			return false;
		}
		try
		{
			SummerRaceBattleStartContext summerRaceBattleStartContext = JsonUtility.FromJson<SummerRaceBattleStartContext>(json);
			if (summerRaceBattleStartContext == null)
			{
				error = "battle start payload parse returned null.";
				return false;
			}
			pendingContext = Clone(summerRaceBattleStartContext);
			return true;
		}
		catch (Exception ex)
		{
			error = ex.Message;
			return false;
		}
	}

	public static bool TryConsume(out SummerRaceBattleStartContext context)
	{
		if (pendingContext == null)
		{
			context = null;
			return false;
		}
		context = Clone(pendingContext);
		pendingContext = null;
		return true;
	}

	public static void Clear()
	{
		pendingContext = null;
	}

	private static SummerRaceBattleStartContext Clone(SummerRaceBattleStartContext context)
	{
		if (context == null)
		{
			return null;
		}
		SummerRaceBattleStartBuildContext summerRaceBattleStartBuildContext = context.build ?? new SummerRaceBattleStartBuildContext();
		return new SummerRaceBattleStartContext
		{
			mode = (context.mode ?? string.Empty),
			stageId = (context.stageId ?? string.Empty),
			source = (context.source ?? string.Empty),
			build = new SummerRaceBattleStartBuildContext
			{
				bodyKey = (summerRaceBattleStartBuildContext.bodyKey ?? string.Empty),
				weaponKeys = CloneArray(summerRaceBattleStartBuildContext.weaponKeys),
				equipKeys = CloneArray(summerRaceBattleStartBuildContext.equipKeys)
			}
		};
	}

	private static string[] CloneArray(string[] values)
	{
		if (values == null || values.Length == 0)
		{
			return Array.Empty<string>();
		}
		string[] array = new string[values.Length];
		for (int i = 0; i < values.Length; i++)
		{
			array[i] = values[i] ?? string.Empty;
		}
		return array;
	}
}
