using System;

namespace ACT.Config;

[Serializable]
public class EnemyRespawnRule
{
	public readonly int id;

	public readonly bool respawn;

	public readonly int countdonw;

	public readonly bool animation;

	public readonly int[] period = new int[0];

	public EnemyRespawnRule(int id, bool respawn, int countdonw, bool animation, int[] period)
	{
		this.id = id;
		this.respawn = respawn;
		this.countdonw = countdonw;
		this.animation = animation;
		this.period = period;
	}
}
