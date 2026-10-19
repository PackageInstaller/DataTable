using System;

namespace ACT.Config;

[Serializable]
public class CharacterEquipProbation
{
	public readonly int id;

	public readonly int[] weaponId = new int[0];

	public readonly int[] weaponGem = new int[0];

	public readonly int[][] weaponAttribute = new int[0][];

	public CharacterEquipProbation(int id, int[] weaponId, int[] weaponGem, int[][] weaponAttribute)
	{
		this.id = id;
		this.weaponId = weaponId;
		this.weaponGem = weaponGem;
		this.weaponAttribute = weaponAttribute;
	}
}
