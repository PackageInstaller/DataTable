using System;

[Serializable]
public sealed class SummerRaceActivityRuntimeCatalog
{
	public string ActivityId = "tank";

	public SummerRaceActivityStageContract[] Stages = Array.Empty<SummerRaceActivityStageContract>();

	public SummerRaceActivityEnemyContract[] Enemies = Array.Empty<SummerRaceActivityEnemyContract>();

	public SummerRaceActivityBodyContract[] Bodies = Array.Empty<SummerRaceActivityBodyContract>();

	public SummerRaceActivityWeaponContract[] Weapons = Array.Empty<SummerRaceActivityWeaponContract>();

	public SummerRaceActivityEquipContract[] Equips = Array.Empty<SummerRaceActivityEquipContract>();

	public SummerRaceActivityChallengePoolContract[] ChallengePools = Array.Empty<SummerRaceActivityChallengePoolContract>();

	public bool TryGetStage(string stageId, out SummerRaceActivityStageContract stage)
	{
		return TryGetById(Stages, stageId, out stage);
	}

	public bool TryGetEnemy(string enemyId, out SummerRaceActivityEnemyContract enemy)
	{
		return TryGetById(Enemies, enemyId, out enemy);
	}

	public bool TryGetChallengePool(string poolId, out SummerRaceActivityChallengePoolContract pool)
	{
		return TryGetById(ChallengePools, poolId, out pool);
	}

	public bool TryGetBody(SummerRaceBodyType bodyType, out SummerRaceActivityBodyContract body)
	{
		SummerRaceActivityBodyContract[] array = Bodies ?? Array.Empty<SummerRaceActivityBodyContract>();
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i] != null && array[i].BodyType == bodyType)
			{
				body = array[i];
				return true;
			}
		}
		body = null;
		return false;
	}

	public bool TryGetWeapon(WeaponKind weaponKind, out SummerRaceActivityWeaponContract weapon)
	{
		SummerRaceActivityWeaponContract[] array = Weapons ?? Array.Empty<SummerRaceActivityWeaponContract>();
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i] != null && array[i].WeaponKind == weaponKind)
			{
				weapon = array[i];
				return true;
			}
		}
		weapon = null;
		return false;
	}

	public bool TryGetEquip(EquipKind equipKind, out SummerRaceActivityEquipContract equip)
	{
		SummerRaceActivityEquipContract[] array = Equips ?? Array.Empty<SummerRaceActivityEquipContract>();
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i] != null && array[i].EquipKind == equipKind)
			{
				equip = array[i];
				return true;
			}
		}
		equip = null;
		return false;
	}

	private static bool TryGetById<T>(T[] list, string id, out T value) where T : SummerRaceActivityIdentifiedContract
	{
		T[] array = list ?? Array.Empty<T>();
		for (int i = 0; i < array.Length; i++)
		{
			if (array[i] != null && string.Equals(array[i].Id, id, StringComparison.Ordinal))
			{
				value = array[i];
				return true;
			}
		}
		value = null;
		return false;
	}
}
