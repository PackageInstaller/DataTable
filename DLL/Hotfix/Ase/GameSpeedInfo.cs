using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class GameSpeedInfo
{
	public int Priority;

	public float GameSpeed;

	public float TimeCount;

	public int InfoIndex;

	public bool IsEffectWeakness;

	public List<int> IgnoreEntitys;

	public BaseEntity Entity;
}
