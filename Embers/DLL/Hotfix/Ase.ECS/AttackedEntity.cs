using GameFramework;

namespace Ase.ECS;

public class AttackedEntity : IReference
{
	public int targetId;

	public int attackTime;

	public void Clear()
	{
		targetId = 0;
		attackTime = 0;
	}
}
