using System;

namespace ACT.Config;

[Serializable]
public class TipsDetailMessageData
{
	public readonly int id;

	public readonly int tipsTitle;

	public readonly int tipDescLocal;

	public readonly int groupId;

	public TipsDetailMessageData(int id, int tipsTitle, int tipDescLocal, int groupId)
	{
		this.id = id;
		this.tipsTitle = tipsTitle;
		this.tipDescLocal = tipDescLocal;
		this.groupId = groupId;
	}
}
