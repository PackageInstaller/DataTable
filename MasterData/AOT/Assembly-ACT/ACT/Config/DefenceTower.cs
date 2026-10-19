using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class DefenceTower
{
	public readonly int id;

	public readonly int defenceTowerType;

	public readonly int worldlevel;

	public readonly List<Properties> Porperty;

	public readonly int damageCalcType;

	public readonly int element;

	public readonly int breakType;

	public readonly int[] strongWeaknessElement = new int[0];

	public readonly int[] weaknessElement = new int[0];

	public readonly int[] strongResistanceElement = new int[0];

	public readonly int[] resistanceElement = new int[0];

	public DefenceTower(int id, int defenceTowerType, int worldlevel, List<Properties> Porperty, int damageCalcType, int element, int breakType, int[] strongWeaknessElement, int[] weaknessElement, int[] strongResistanceElement, int[] resistanceElement)
	{
		this.id = id;
		this.defenceTowerType = defenceTowerType;
		this.worldlevel = worldlevel;
		this.Porperty = Porperty;
		this.damageCalcType = damageCalcType;
		this.element = element;
		this.breakType = breakType;
		this.strongWeaknessElement = strongWeaknessElement;
		this.weaknessElement = weaknessElement;
		this.strongResistanceElement = strongResistanceElement;
		this.resistanceElement = resistanceElement;
	}
}
