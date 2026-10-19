using System;

namespace ACT.Config;

[Serializable]
public class SystemGuideData
{
	public readonly int id;

	public readonly int chapter;

	public readonly int type;

	public readonly int name;

	public readonly int[] displayPic = new int[0];

	public readonly int[] displayPic01 = new int[0];

	public readonly int description;

	public readonly int[] condition = new int[0];

	public readonly int Prefab;

	public SystemGuideData(int id, int chapter, int type, int name, int[] displayPic, int[] displayPic01, int description, int[] condition, int Prefab)
	{
		this.id = id;
		this.chapter = chapter;
		this.type = type;
		this.name = name;
		this.displayPic = displayPic;
		this.displayPic01 = displayPic01;
		this.description = description;
		this.condition = condition;
		this.Prefab = Prefab;
	}
}
