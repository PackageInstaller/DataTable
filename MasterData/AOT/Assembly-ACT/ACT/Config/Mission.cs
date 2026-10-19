using System;

namespace ACT.Config;

[Serializable]
public class Mission
{
	public readonly int id;

	public readonly int preconditionId;

	public readonly int type;

	public readonly int number;

	public readonly int[] cParam = new int[0];

	public readonly int[] param = new int[0];

	public readonly int missionId;

	public readonly int missionDescription;

	public Mission(int id, int preconditionId, int type, int number, int[] cParam, int[] param, int missionId, int missionDescription)
	{
		this.id = id;
		this.preconditionId = preconditionId;
		this.type = type;
		this.number = number;
		this.cParam = cParam;
		this.param = param;
		this.missionId = missionId;
		this.missionDescription = missionDescription;
	}
}
