using System;

namespace ACT.Config;

[Serializable]
public class Precondition
{
	public readonly int id;

	public readonly string intro = "";

	public readonly int desId;

	public readonly int desMissionId;

	public Precondition(int id, string intro, int desId, int desMissionId)
	{
		this.id = id;
		this.intro = intro;
		this.desId = desId;
		this.desMissionId = desMissionId;
	}
}
