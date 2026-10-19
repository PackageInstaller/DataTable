using Bamboo.ECS;

namespace ACT.Battle;

public abstract class BaseEvt
{
	public Entity mainEntity;

	public Entity ownerEntity;

	public Ability ability;

	public BaseEvt()
	{
	}

	public void BaseReset()
	{
		ability = null;
		Reset();
	}

	public abstract void Reset();
}
