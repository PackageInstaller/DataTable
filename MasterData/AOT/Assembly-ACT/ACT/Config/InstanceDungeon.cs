using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class InstanceDungeon
{
	public readonly int id;

	public readonly int type;

	public readonly int name;

	public readonly int desc;

	public readonly int area;

	public readonly int senceid;

	public readonly List<ItemKv> reward;

	public readonly int recommendedLevel;

	public readonly int[] elementRestrictions = new int[0];

	public readonly int collection1Text;

	public readonly int collection2Text;

	public readonly int collection3Text;

	public readonly float[] location = new float[0];

	public readonly int[] boxType = new int[0];

	public readonly bool skipJumpTraverse;

	public readonly int[][] skillGroup = new int[0][];

	public InstanceDungeon(int id, int type, int name, int desc, int area, int senceid, List<ItemKv> reward, int recommendedLevel, int[] elementRestrictions, int collection1Text, int collection2Text, int collection3Text, float[] location, int[] boxType, bool skipJumpTraverse, int[][] skillGroup)
	{
		this.id = id;
		this.type = type;
		this.name = name;
		this.desc = desc;
		this.area = area;
		this.senceid = senceid;
		this.reward = reward;
		this.recommendedLevel = recommendedLevel;
		this.elementRestrictions = elementRestrictions;
		this.collection1Text = collection1Text;
		this.collection2Text = collection2Text;
		this.collection3Text = collection3Text;
		this.location = location;
		this.boxType = boxType;
		this.skipJumpTraverse = skipJumpTraverse;
		this.skillGroup = skillGroup;
	}
}
