using System;

namespace ACT.Config;

[Serializable]
public class EntityData
{
	public readonly int id;

	public readonly int nameLocal;

	public readonly string name = "";

	public readonly int type;

	public readonly int descriptionLocal;

	public readonly int element;

	public readonly int MaxTenacity;

	public readonly int breakType;

	public readonly int[] strongWeaknessElement = new int[0];

	public readonly int[] weaknessElement = new int[0];

	public readonly int[] strongResistanceElement = new int[0];

	public readonly int[] resistanceElement = new int[0];

	public EntityData(int id, int nameLocal, string name, int type, int descriptionLocal, int element, int MaxTenacity, int breakType, int[] strongWeaknessElement, int[] weaknessElement, int[] strongResistanceElement, int[] resistanceElement)
	{
		this.id = id;
		this.nameLocal = nameLocal;
		this.name = name;
		this.type = type;
		this.descriptionLocal = descriptionLocal;
		this.element = element;
		this.MaxTenacity = MaxTenacity;
		this.breakType = breakType;
		this.strongWeaknessElement = strongWeaknessElement;
		this.weaknessElement = weaknessElement;
		this.strongResistanceElement = strongResistanceElement;
		this.resistanceElement = resistanceElement;
	}
}
