using Bamboo.ECS;

namespace ACT.Battle;

public class BaseAddAbilityEvt : BaseEvt
{
	public string name;

	public Entity casterEntity;

	public Entity targetEntity;

	public override void Reset()
	{
		name = null;
		mainEntity = default;
		targetEntity = default;
		ability = null;
	}
}
