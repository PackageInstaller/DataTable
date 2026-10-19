using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class EntityNeutralData
{
	public readonly int id;

	public readonly List<Properties> characterPorpertyBase;

	public readonly int element;

	public readonly int breakType;

	public readonly int[] strongWeaknessElement = new int[0];

	public readonly int[] weaknessElement = new int[0];

	public readonly int[] strongResistanceElement = new int[0];

	public readonly int[] resistanceElement = new int[0];

	public EntityNeutralData(int id, List<Properties> characterPorpertyBase, int element, int breakType, int[] strongWeaknessElement, int[] weaknessElement, int[] strongResistanceElement, int[] resistanceElement)
	{
		this.id = id;
		this.characterPorpertyBase = characterPorpertyBase;
		this.element = element;
		this.breakType = breakType;
		this.strongWeaknessElement = strongWeaknessElement;
		this.weaknessElement = weaknessElement;
		this.strongResistanceElement = strongResistanceElement;
		this.resistanceElement = resistanceElement;
	}
}
