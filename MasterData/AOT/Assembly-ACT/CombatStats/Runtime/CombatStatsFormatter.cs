using UnityEngine;

namespace CombatStats.Runtime;

public static class CombatStatsFormatter
{
	public static string FormatDamage(long damage)
	{
		if (damage >= 1000000)
		{
			return ((float)damage / 1000000f).ToString("0.##") + "M";
		}
		if (damage >= 1000)
		{
			return ((float)damage / 1000f).ToString("0.##") + "K";
		}
		return damage.ToString();
	}

	public static string FormatDps(float dps)
	{
		return dps.ToString("0.#");
	}

	public static string FormatDuration(float duration)
	{
		if (duration >= 60f)
		{
			int num = Mathf.FloorToInt(duration / 60f);
			float num2 = duration % 60f;
			return $"{num}:{num2:00.0}";
		}
		return duration.ToString("0.0") + "s";
	}
}
