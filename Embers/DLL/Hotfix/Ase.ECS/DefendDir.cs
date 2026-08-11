using GameFramework;

namespace Ase.ECS;

public class DefendDir : IReference
{
	public bool isUsed;

	public float max;

	public float min;

	public void Clear()
	{
		isUsed = false;
		min = 0f;
		max = 0f;
	}
}
