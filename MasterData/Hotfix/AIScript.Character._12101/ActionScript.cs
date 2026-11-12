using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Character._12101;

public class ActionScript : ActorActionBase
{
	protected override void OnActionEnable()
	{
		base.OnActionEnable();
	}

	public virtual void OnUpdate()
	{
		if (!_player.isAssist)
		{
			_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: true);
			if (_actor.attackTarget != null && _actor.DistanceWithRadius(_actor.attackTarget) <= CommonUtils.GetAttackRange(_actor))
			{
				ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal), _actor, SkillPhaseFeatureFlag.Normal);
			}
		}
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
	}
}
