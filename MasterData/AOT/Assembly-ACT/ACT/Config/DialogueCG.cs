using System;

namespace ACT.Config;

[Serializable]
public class DialogueCG
{
	public readonly int id;

	public readonly int type;

	public readonly int content1;

	public readonly int content2;

	public readonly int maleContent1;

	public readonly int maleContent2;

	public DialogueCG(int id, int type, int content1, int content2, int maleContent1, int maleContent2)
	{
		this.id = id;
		this.type = type;
		this.content1 = content1;
		this.content2 = content2;
		this.maleContent1 = maleContent1;
		this.maleContent2 = maleContent2;
	}
}
