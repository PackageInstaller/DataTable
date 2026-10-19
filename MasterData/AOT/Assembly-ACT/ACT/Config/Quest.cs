using System;

namespace ACT.Config;

[Serializable]
public class Quest
{
	public readonly int id;

	public readonly int missionid;

	public readonly int refresh;

	public readonly int time;

	public readonly int exp;

	public readonly int priority;

	public readonly int jump;

	public Quest(int id, int missionid, int refresh, int time, int exp, int priority, int jump)
	{
		this.id = id;
		this.missionid = missionid;
		this.refresh = refresh;
		this.time = time;
		this.exp = exp;
		this.priority = priority;
		this.jump = jump;
	}
}
