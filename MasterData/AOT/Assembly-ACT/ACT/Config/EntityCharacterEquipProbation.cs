using System;

namespace ACT.Config;

[Serializable]
public class EntityCharacterEquipProbation
{
	public readonly int id;

	public readonly int[] weaponId1 = new int[0];

	public readonly int[] weaponGem1 = new int[0];

	public readonly int[][] weaponAttribute1 = new int[0][];

	public readonly int[] weaponId2 = new int[0];

	public readonly int[] weaponGem2 = new int[0];

	public readonly int[][] weaponAttribute2 = new int[0][];

	public readonly int[] weaponId3 = new int[0];

	public readonly int[] weaponGem3 = new int[0];

	public readonly int[][] weaponAttribute3 = new int[0][];

	public readonly int[] weaponId4 = new int[0];

	public readonly int[] weaponGem4 = new int[0];

	public readonly int[][] weaponAttribute4 = new int[0][];

	public EntityCharacterEquipProbation(int id, int[] weaponId1, int[] weaponGem1, int[][] weaponAttribute1, int[] weaponId2, int[] weaponGem2, int[][] weaponAttribute2, int[] weaponId3, int[] weaponGem3, int[][] weaponAttribute3, int[] weaponId4, int[] weaponGem4, int[][] weaponAttribute4)
	{
		this.id = id;
		this.weaponId1 = weaponId1;
		this.weaponGem1 = weaponGem1;
		this.weaponAttribute1 = weaponAttribute1;
		this.weaponId2 = weaponId2;
		this.weaponGem2 = weaponGem2;
		this.weaponAttribute2 = weaponAttribute2;
		this.weaponId3 = weaponId3;
		this.weaponGem3 = weaponGem3;
		this.weaponAttribute3 = weaponAttribute3;
		this.weaponId4 = weaponId4;
		this.weaponGem4 = weaponGem4;
		this.weaponAttribute4 = weaponAttribute4;
	}
}
