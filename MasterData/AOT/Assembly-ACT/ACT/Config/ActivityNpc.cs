using System;

namespace ACT.Config;

[Serializable]
public class ActivityNpc
{
	public readonly int id;

	public readonly int activityId;

	public readonly string activityNpcState = "";

	public readonly int[] activityNpcString = new int[0];

	public readonly string activityNpcFace = "";

	public readonly int loopTime;

	public ActivityNpc(int id, int activityId, string activityNpcState, int[] activityNpcString, string activityNpcFace, int loopTime)
	{
		this.id = id;
		this.activityId = activityId;
		this.activityNpcState = activityNpcState;
		this.activityNpcString = activityNpcString;
		this.activityNpcFace = activityNpcFace;
		this.loopTime = loopTime;
	}
}
