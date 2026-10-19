using Bamboo.ECS;

namespace ACT.Battle;

public abstract class RuntimeTrajectory
{
	public abstract void FixedUpdateBehave(Entity behave, float dt);

	public abstract void UpdateBehave(Entity behave, float dt);

	public abstract void SetLifeEnd(Entity behave);

	public abstract void HandleDie(Entity behave);

	public abstract void Reset();
}
