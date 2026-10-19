using System;

namespace ACT.Config;

[Serializable]
public class TeamAtackRutorial
{
	public readonly int id;

	public readonly int missionText;

	public readonly int missionDesText;

	public readonly int targetText;

	public readonly string[] targetFrame = new string[0];

	public readonly int[] targetNums = new int[0];

	public readonly int targetMidText;

	public readonly int stayTime;

	public readonly int triggerTiming;

	public TeamAtackRutorial(int id, int missionText, int missionDesText, int targetText, string[] targetFrame, int[] targetNums, int targetMidText, int stayTime, int triggerTiming)
	{
		this.id = id;
		this.missionText = missionText;
		this.missionDesText = missionDesText;
		this.targetText = targetText;
		this.targetFrame = targetFrame;
		this.targetNums = targetNums;
		this.targetMidText = targetMidText;
		this.stayTime = stayTime;
		this.triggerTiming = triggerTiming;
	}
}
