using AIScript.Utils;

namespace AIScript.Character._13001;

public class ActionScript_Support : ActionScript
{
	public override void OnStart()
	{
		base.OnStart();
		_actor.SetBlockPriorityToStatic();
	}

	public override void OnUpdate()
	{
		_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
	}

	public override void OnStop()
	{
		base.OnStop();
		_actor.attackTarget = null;
		_actor.ResetBlockPriority();
	}
}
