using System;

namespace ACT.Config;

[Serializable]
public class Challenge
{
	public readonly int id;

	public readonly string name = "";

	public readonly int nameLocal;

	public readonly string[] desc = new string[0];

	public readonly int[] descLocal = new int[0];

	public readonly int type;

	public readonly int[] score = new int[0];

	public readonly int[] param = new int[0];

	public readonly int[] subID = new int[0];

	public Challenge(int id, string name, int nameLocal, string[] desc, int[] descLocal, int type, int[] score, int[] param, int[] subID)
	{
		this.id = id;
		this.name = name;
		this.nameLocal = nameLocal;
		this.desc = desc;
		this.descLocal = descLocal;
		this.type = type;
		this.score = score;
		this.param = param;
		this.subID = subID;
	}
}
