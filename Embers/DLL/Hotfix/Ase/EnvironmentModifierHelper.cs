#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;

namespace Ase;

public static class EnvironmentModifierHelper
{
	public const int InvalidEffectId = 0;

	public static DREnvironmentModifier GetConfig(int environId)
	{
		if (environId == 0)
		{
			return null;
		}
		DREnvironmentModifier dataRow = GameEntry.DataTable.GetDataRow<DREnvironmentModifier>(environId);
		if (dataRow == null)
		{
			Log.Error($"EnvironmentModifier config not found. EnvironId={environId}");
		}
		return dataRow;
	}

	public static bool TryGetConfig(int environId, out DREnvironmentModifier config)
	{
		config = GetConfig(environId);
		return config != null;
	}

	public static int GetBuffId(int environId)
	{
		return GetConfig(environId)?.BuffId ?? 0;
	}

	public static int GetParadoxId(int environId)
	{
		return GetConfig(environId)?.ParadoxId ?? 0;
	}

	public static bool IsTarget(int environId, EnvironmentModifierTargetType targetType)
	{
		DREnvironmentModifier config = GetConfig(environId);
		if (config != null)
		{
			return config.TargetType == (int)targetType;
		}
		return false;
	}

	public static EnvironmentModifierDisplayInfo GetDisplayInfo(int environId)
	{
		DREnvironmentModifier config = GetConfig(environId);
		if (config == null)
		{
			return default(EnvironmentModifierDisplayInfo);
		}
		EnvironmentModifierType environmentType = GetEnvironmentType(config);
		EnvironmentModifierTargetType targetType = (EnvironmentModifierTargetType)config.TargetType;
		if (config.BuffId != 0)
		{
			DRBuff dataRow = GameEntry.DataTable.GetDataRow<DRBuff>(config.BuffId);
			if (dataRow == null)
			{
				Log.Error($"Buff config not found. EnvironId={environId}, BuffId={config.BuffId}");
				return new EnvironmentModifierDisplayInfo(environId, config.BuffId, environmentType, targetType, string.Empty, string.Empty, string.Empty);
			}
			return new EnvironmentModifierDisplayInfo(environId, config.BuffId, environmentType, targetType, dataRow.Name, dataRow.Desc, dataRow.BuffIcon);
		}
		return new EnvironmentModifierDisplayInfo(environId, config.ParadoxId, environmentType, targetType, config.ParadoxName, config.Desc, string.Empty);
	}

	public static EnvironmentModifierType GetEnvironmentType(DREnvironmentModifier config)
	{
		if (config == null)
		{
			return EnvironmentModifierType.Buff;
		}
		if (config.BuffId != 0)
		{
			return EnvironmentModifierType.Buff;
		}
		if (config.ParadoxId != 0)
		{
			return EnvironmentModifierType.Paradox;
		}
		return (EnvironmentModifierType)config.EnvironmentType;
	}
}
