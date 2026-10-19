using System;

namespace ACT.Config;

[Serializable]
public class DoubleGem
{
	public readonly int id;

	public readonly long startTimeStamp;

	public readonly long endTimeStamp;

	public DoubleGem(int id, long startTimeStamp, long endTimeStamp)
	{
		this.id = id;
		this.startTimeStamp = startTimeStamp;
		this.endTimeStamp = endTimeStamp;
	}
}
