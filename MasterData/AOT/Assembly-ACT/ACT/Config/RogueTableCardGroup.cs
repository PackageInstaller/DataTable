using System;

namespace ACT.Config;

[Serializable]
public class RogueTableCardGroup
{
	public readonly int id;

	public readonly int groupType;

	public readonly int[] groupCard = new int[0];

	public RogueTableCardGroup(int id, int groupType, int[] groupCard)
	{
		this.id = id;
		this.groupType = groupType;
		this.groupCard = groupCard;
	}
}
