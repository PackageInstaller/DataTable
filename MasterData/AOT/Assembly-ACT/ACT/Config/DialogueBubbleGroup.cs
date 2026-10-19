using System;

namespace ACT.Config;

[Serializable]
public class DialogueBubbleGroup
{
	public readonly int id;

	public readonly int[] bubbleID = new int[0];

	public readonly int bubbleClass;

	public readonly bool bubbleLoop;

	public readonly int bubbleLoopGap;

	public DialogueBubbleGroup(int id, int[] bubbleID, int bubbleClass, bool bubbleLoop, int bubbleLoopGap)
	{
		this.id = id;
		this.bubbleID = bubbleID;
		this.bubbleClass = bubbleClass;
		this.bubbleLoop = bubbleLoop;
		this.bubbleLoopGap = bubbleLoopGap;
	}
}
