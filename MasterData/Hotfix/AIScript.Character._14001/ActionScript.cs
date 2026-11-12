using TrueSync;

namespace AIScript.Character._14001;

public class ActionScript : ActorActionBase
{
	private FP _holdTime_NormalAttackStage;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
	}

	public virtual void OnUpdate()
	{
		if (_actor.actorSkillManage.HaveSkill(SkillPhaseFeatureFlag.Normal))
		{
			_holdTime_NormalAttackStage = 0;
			return;
		}
		if (_holdTime_NormalAttackStage < Config.holdTime_NormalAttackStage)
		{
			_holdTime_NormalAttackStage += _actor.LogicDeltaTime;
			return;
		}
		_actor.logicVariable.SetLogicTagValue("NormalAttackStage", 0);
		_holdTime_NormalAttackStage = 0;
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
	}
}
