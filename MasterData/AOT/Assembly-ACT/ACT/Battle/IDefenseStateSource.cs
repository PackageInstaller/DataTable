using Bamboo.ECS;

namespace ACT.Battle;

public interface IDefenseStateSource
{
	void Collect(Entity target, ref DefenseStateSnapshot snapshot);
}
