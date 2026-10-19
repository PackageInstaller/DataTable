using System;

namespace ACT.Config;

[Serializable]
public class NodeMessage
{
	public readonly int id;

	public readonly int nodeNameId;

	public readonly int extraTextId;

	public readonly int secondEnergyText;

	public readonly string[] secondEnergyFrame = new string[0];

	public readonly int triggerTiming;

	public readonly int delayTime;

	public NodeMessage(int id, int nodeNameId, int extraTextId, int secondEnergyText, string[] secondEnergyFrame, int triggerTiming, int delayTime)
	{
		this.id = id;
		this.nodeNameId = nodeNameId;
		this.extraTextId = extraTextId;
		this.secondEnergyText = secondEnergyText;
		this.secondEnergyFrame = secondEnergyFrame;
		this.triggerTiming = triggerTiming;
		this.delayTime = delayTime;
	}
}
