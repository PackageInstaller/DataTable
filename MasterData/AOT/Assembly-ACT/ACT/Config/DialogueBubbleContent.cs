using System;

namespace ACT.Config;

[Serializable]
public class DialogueBubbleContent
{
	public readonly int id;

	public readonly int npcID;

	public readonly int BubbleText;

	public readonly int BubbleShowTime;

	public readonly int BubbleGapTime;

	public DialogueBubbleContent(int id, int npcID, int BubbleText, int BubbleShowTime, int BubbleGapTime)
	{
		this.id = id;
		this.npcID = npcID;
		this.BubbleText = BubbleText;
		this.BubbleShowTime = BubbleShowTime;
		this.BubbleGapTime = BubbleGapTime;
	}
}
