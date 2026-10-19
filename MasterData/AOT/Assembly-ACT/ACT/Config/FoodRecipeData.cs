using System;

namespace ACT.Config;

[Serializable]
public class FoodRecipeData
{
	public readonly int id;

	public readonly int baseMaterial;

	public readonly int accessoryMaterialOne;

	public readonly int accessoryMaterialTwo;

	public readonly int nameLocas;

	public readonly int desLocal;

	public FoodRecipeData(int id, int baseMaterial, int accessoryMaterialOne, int accessoryMaterialTwo, int nameLocas, int desLocal)
	{
		this.id = id;
		this.baseMaterial = baseMaterial;
		this.accessoryMaterialOne = accessoryMaterialOne;
		this.accessoryMaterialTwo = accessoryMaterialTwo;
		this.nameLocas = nameLocas;
		this.desLocal = desLocal;
	}
}
