using System;

namespace ACT.Config;

[Serializable]
public class CookSkillPr
{
	public readonly int id;

	public readonly string name = "";

	public readonly int[] skillParmList = new int[0];

	public readonly int cookSkillId;

	public readonly int areaId;

	public readonly int dropType;

	public readonly int collectionType;

	public CookSkillPr(int id, string name, int[] skillParmList, int cookSkillId, int areaId, int dropType, int collectionType)
	{
		this.id = id;
		this.name = name;
		this.skillParmList = skillParmList;
		this.cookSkillId = cookSkillId;
		this.areaId = areaId;
		this.dropType = dropType;
		this.collectionType = collectionType;
	}
}
