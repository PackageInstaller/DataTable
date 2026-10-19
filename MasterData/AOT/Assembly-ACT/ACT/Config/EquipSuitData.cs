using System;

namespace ACT.Config;

[Serializable]
public class EquipSuitData
{
	public readonly int id;

	public readonly int suitName;

	public readonly int suitArea;

	public readonly int suitSeq;

	public readonly int[] equipList = new int[0];

	public readonly int sort;

	public EquipSuitData(int id, int suitName, int suitArea, int suitSeq, int[] equipList, int sort)
	{
		this.id = id;
		this.suitName = suitName;
		this.suitArea = suitArea;
		this.suitSeq = suitSeq;
		this.equipList = equipList;
		this.sort = sort;
	}
}
