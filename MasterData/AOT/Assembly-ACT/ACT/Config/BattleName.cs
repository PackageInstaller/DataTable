using System;

namespace ACT.Config;

[Serializable]
public class BattleName
{
	public readonly int id;

	public readonly string name = "";

	public readonly int[] collectionId = new int[0];

	public BattleName(int id, string name, int[] collectionId)
	{
		this.id = id;
		this.name = name;
		this.collectionId = collectionId;
	}
}
