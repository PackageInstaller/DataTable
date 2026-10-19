using System;

namespace ACT.MultiPlayer;

public struct MPChip : IEquatable<MPChip>
{
	public int id;

	public int uid;

	public int[] pId;

	public float[] pValue;

	public MPChip(int Id, int Uid, int[] pIds, float[] pValues)
	{
		this = default;
		id = Id;
		uid = Uid;
		for (int i = 0; i < 5; i++)
		{
			pId[i] = pIds[i];
			pValue[i] = pValues[i];
		}
	}

	public bool Equals(MPChip other)
	{
		for (int i = 0; i < 5; i++)
		{
			if (pId[i] != other.pId[i] || pValue[i] != other.pValue[i])
			{
				return false;
			}
		}
		if (id == other.id)
		{
			return uid == other.uid;
		}
		return false;
	}
}
