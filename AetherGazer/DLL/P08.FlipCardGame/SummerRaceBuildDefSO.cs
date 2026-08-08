using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(menuName = "SummerRace/Config/BuildDef", fileName = "SummerRaceBuildDef")]
public class SummerRaceBuildDefSO : ScriptableObject
{
	public string buildName = "Default Build";

	public string note;

	public SummerRaceBodyDefSO body;

	public List<SummerRaceWeaponDefSO> weapons = new List<SummerRaceWeaponDefSO>();

	public List<SummerRaceEquipDefSO> equips = new List<SummerRaceEquipDefSO>();

	public int TotalCost => CalculateTotalCost();

	public int CostCap
	{
		get
		{
			if (!(body != null))
			{
				return 0;
			}
			return body.costCap;
		}
	}

	public string WeaponSlotsUsage
	{
		get
		{
			if (!(body == null))
			{
				return weapons.Count + " / " + body.weaponSlots;
			}
			return "0 / 0";
		}
	}

	public string EquipSlotsUsage
	{
		get
		{
			if (!(body == null))
			{
				return equips.Count + " / " + body.equipSlots;
			}
			return "0 / 0";
		}
	}

	public int CalculateTotalCost()
	{
		int num = 0;
		for (int i = 0; i < weapons.Count; i++)
		{
			if (weapons[i] != null)
			{
				num += Mathf.Max(0, weapons[i].cost);
			}
		}
		for (int j = 0; j < equips.Count; j++)
		{
			if (equips[j] != null)
			{
				num += Mathf.Max(0, equips[j].cost);
			}
		}
		return num;
	}

	public bool ValidateBuild(out string reason)
	{
		if (body == null)
		{
			reason = "Body is not set.";
			return false;
		}
		if (weapons.Count > body.weaponSlots)
		{
			reason = "Weapon slots exceeded: " + weapons.Count + " / " + body.weaponSlots;
			return false;
		}
		if (equips.Count > body.equipSlots)
		{
			reason = "Equip slots exceeded: " + equips.Count + " / " + body.equipSlots;
			return false;
		}
		int num = CalculateTotalCost();
		if (num > body.costCap)
		{
			reason = "Cost cap exceeded: " + num + " / " + body.costCap;
			return false;
		}
		reason = "Validation passed.";
		return true;
	}

	private void ValidateInInspector()
	{
		if (ValidateBuild(out var reason))
		{
			Debug.Log("[SummerRaceBuildDef] " + buildName + " validation passed.");
		}
		else
		{
			Debug.LogWarning("[SummerRaceBuildDef] " + buildName + " validation failed: " + reason);
		}
	}
}
