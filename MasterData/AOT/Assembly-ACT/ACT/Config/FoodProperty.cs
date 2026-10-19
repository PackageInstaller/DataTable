using System;

namespace ACT.Config;

[Serializable]
public class FoodProperty
{
	public readonly int id;

	public readonly int propertyType;

	public readonly int subType;

	public readonly bool effectPercentage;

	public readonly int nameLocal;

	public readonly int desLocal;

	public FoodProperty(int id, int propertyType, int subType, bool effectPercentage, int nameLocal, int desLocal)
	{
		this.id = id;
		this.propertyType = propertyType;
		this.subType = subType;
		this.effectPercentage = effectPercentage;
		this.nameLocal = nameLocal;
		this.desLocal = desLocal;
	}
}
