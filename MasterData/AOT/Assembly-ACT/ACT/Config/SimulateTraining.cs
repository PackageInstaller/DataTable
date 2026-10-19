using System;

namespace ACT.Config;

[Serializable]
public class SimulateTraining
{
	public readonly int id;

	public readonly int contentLv1name;

	public readonly int preconditionID;

	public readonly int sort;

	public SimulateTraining(int id, int contentLv1name, int preconditionID, int sort)
	{
		this.id = id;
		this.contentLv1name = contentLv1name;
		this.preconditionID = preconditionID;
		this.sort = sort;
	}
}
