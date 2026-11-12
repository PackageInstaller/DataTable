using AIScript.Utils;

namespace AIScript.Character._14301;

public class ActionScript_Support : ActionScript
{
	protected override void OnActionEnable()
	{
		base.OnActionEnable();
	}

	protected override void OnCastSkill()
	{
		_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
		base.OnCastSkill();
	}

	protected override void OnCastUltimate()
	{
		_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
		base.OnCastUltimate();
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
	}
}
