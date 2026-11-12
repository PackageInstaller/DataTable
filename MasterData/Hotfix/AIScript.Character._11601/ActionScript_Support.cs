using AIScript.Utils;

namespace AIScript.Character._11601;

public class ActionScript_Support : ActionScript
{
	public override void OnUpdate()
	{
		base.OnUpdate();
		_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
	}
}
