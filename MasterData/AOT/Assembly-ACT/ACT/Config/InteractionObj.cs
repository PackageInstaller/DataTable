using System;

namespace ACT.Config;

[Serializable]
public class InteractionObj
{
	public readonly int wid;

	public readonly int uid;

	public readonly int state;

	public InteractionObj(int wid, int uid, int state)
	{
		this.wid = wid;
		this.uid = uid;
		this.state = state;
	}
}
