using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class ItemChipSuitData
{
	public readonly int id;

	public readonly int suitType;

	public readonly int nameLocal;

	public readonly int suitIconAddress;

	public readonly int codeNameLocal;

	public readonly float[] suitColor = new float[0];

	public readonly int descLocal;

	public readonly int[] chipSuitEntity = new int[0];

	public readonly int suitSixSkill;

	public readonly string[] suitSixSkillName = new string[0];

	public readonly int suitTwelveSkill;

	public readonly string[] suitTwelveSkillName = new string[0];

	public readonly int twoPropertyLocal;

	public readonly List<Properties> propertySuit2;

	public readonly int fourSkillLocal;

	public readonly int passiveAbilitySuit4;

	public readonly int passiveAbilitySuit2;

	public readonly List<Properties> propertySuit4;

	public ItemChipSuitData(int id, int suitType, int nameLocal, int suitIconAddress, int codeNameLocal, float[] suitColor, int descLocal, int[] chipSuitEntity, int suitSixSkill, string[] suitSixSkillName, int suitTwelveSkill, string[] suitTwelveSkillName, int twoPropertyLocal, List<Properties> propertySuit2, int fourSkillLocal, int passiveAbilitySuit4, int passiveAbilitySuit2, List<Properties> propertySuit4)
	{
		this.id = id;
		this.suitType = suitType;
		this.nameLocal = nameLocal;
		this.suitIconAddress = suitIconAddress;
		this.codeNameLocal = codeNameLocal;
		this.suitColor = suitColor;
		this.descLocal = descLocal;
		this.chipSuitEntity = chipSuitEntity;
		this.suitSixSkill = suitSixSkill;
		this.suitSixSkillName = suitSixSkillName;
		this.suitTwelveSkill = suitTwelveSkill;
		this.suitTwelveSkillName = suitTwelveSkillName;
		this.twoPropertyLocal = twoPropertyLocal;
		this.propertySuit2 = propertySuit2;
		this.fourSkillLocal = fourSkillLocal;
		this.passiveAbilitySuit4 = passiveAbilitySuit4;
		this.passiveAbilitySuit2 = passiveAbilitySuit2;
		this.propertySuit4 = propertySuit4;
	}
}
