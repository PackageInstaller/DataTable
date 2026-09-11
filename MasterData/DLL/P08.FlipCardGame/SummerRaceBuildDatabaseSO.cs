using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(menuName = "SummerRace/Config/BuildDatabase", fileName = "SummerRaceBuildDatabase")]
public class SummerRaceBuildDatabaseSO : ScriptableObject
{
	public List<SummerRaceBodyDefSO> bodyDefs = new List<SummerRaceBodyDefSO>();

	public List<SummerRaceWeaponDefSO> weaponDefs = new List<SummerRaceWeaponDefSO>();

	public List<SummerRaceEquipDefSO> equipDefs = new List<SummerRaceEquipDefSO>();

	public List<SummerRaceBuildDefSO> buildDefs = new List<SummerRaceBuildDefSO>();

	public void RemoveNullEntries()
	{
		bodyDefs.RemoveAll((SummerRaceBodyDefSO x) => x == null);
		weaponDefs.RemoveAll((SummerRaceWeaponDefSO x) => x == null);
		equipDefs.RemoveAll((SummerRaceEquipDefSO x) => x == null);
		buildDefs.RemoveAll((SummerRaceBuildDefSO x) => x == null);
	}
}
