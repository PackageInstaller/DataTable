using System;

namespace ACT.Config;

[Serializable]
public class SubmissionCondition
{
	public readonly int id;

	public readonly int[] monsters = new int[0];

	public readonly int name;

	public readonly int submitItem;

	public SubmissionCondition(int id, int[] monsters, int name, int submitItem)
	{
		this.id = id;
		this.monsters = monsters;
		this.name = name;
		this.submitItem = submitItem;
	}
}
