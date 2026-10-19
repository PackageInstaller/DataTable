using System;

namespace ACT.Config;

[Serializable]
public class Bag
{
	public readonly int id;

	public readonly int name;

	public readonly int[] showType = new int[0];

	public readonly int capacity;

	public readonly int Sequence;

	public readonly int hideOrNo;

	public Bag(int id, int name, int[] showType, int capacity, int Sequence, int hideOrNo)
	{
		this.id = id;
		this.name = name;
		this.showType = showType;
		this.capacity = capacity;
		this.Sequence = Sequence;
		this.hideOrNo = hideOrNo;
	}
}
