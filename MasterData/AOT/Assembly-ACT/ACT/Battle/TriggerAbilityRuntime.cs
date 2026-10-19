using ACT.Battle.Configs;
using Bamboo.ECS;

namespace ACT.Battle;

public class TriggerAbilityRuntime
{
	public Entity caster;

	public Entity eb;

	public Ability ability;

	public ActionTriggerAbility action;

	public void Reset()
	{
		caster = default;
		eb = default;
		ability = null;
		action = null;
	}
}
