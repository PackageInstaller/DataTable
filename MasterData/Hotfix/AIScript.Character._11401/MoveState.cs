using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._11401;

public class MoveState : IState
{
	public override void Update()
	{
		base.Update();
		LogicEntity assistantAttackTarget = CommonUtils.GetAssistantAttackTarget(_actor);
		if (assistantAttackTarget != null)
		{
			FP fP = _actor.DistanceWithRadius(assistantAttackTarget);
			if (_actor.actorSearchTargetInfo.visionAttackRange > fP)
			{
				Exit();
			}
			else
			{
				_actor.MoveTo(assistantAttackTarget.tsTransform.Position, 0.1f);
			}
		}
		else
		{
			Exit();
		}
	}

	public override void Exit()
	{
		base.Exit();
		_actor.StandBy();
	}
}
