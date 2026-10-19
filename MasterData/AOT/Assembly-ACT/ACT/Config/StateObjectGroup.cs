using System;

namespace ACT.Config;

[Serializable]
public class StateObjectGroup
{
	public readonly int id;

	public readonly int groupName;

	public readonly int ObjectDesc;

	public readonly int[] group = new int[0];

	public readonly int weight;

	public readonly int iconAddress;

	public readonly int imageAddress;

	public readonly int Sequence;

	public StateObjectGroup(int id, int groupName, int ObjectDesc, int[] group, int weight, int iconAddress, int imageAddress, int Sequence)
	{
		this.id = id;
		this.groupName = groupName;
		this.ObjectDesc = ObjectDesc;
		this.group = group;
		this.weight = weight;
		this.iconAddress = iconAddress;
		this.imageAddress = imageAddress;
		this.Sequence = Sequence;
	}
}
