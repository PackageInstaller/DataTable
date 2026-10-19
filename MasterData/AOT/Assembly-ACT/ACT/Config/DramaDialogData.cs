using System;

namespace ACT.Config;

[Serializable]
public class DramaDialogData
{
	public readonly int id;

	public readonly int content;

	public readonly float lenghtCN;

	public readonly float lenghtJP;

	public readonly float lenghtUS;

	public readonly float endTime;

	public readonly int skipType;

	public readonly int skipTime;

	public DramaDialogData(int id, int content, float lenghtCN, float lenghtJP, float lenghtUS, float endTime, int skipType, int skipTime)
	{
		this.id = id;
		this.content = content;
		this.lenghtCN = lenghtCN;
		this.lenghtJP = lenghtJP;
		this.lenghtUS = lenghtUS;
		this.endTime = endTime;
		this.skipType = skipType;
		this.skipTime = skipTime;
	}
}
