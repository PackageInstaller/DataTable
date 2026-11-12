#define LOG_DEBUG
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12001;

public class Action : ActorActionBase
{
	protected PlayerSkillCd _skillManage;

	protected override void OnActionDisable()
	{
		NovaLogger.Debug("_12001 Action OnDisable");
		_skillManage = null;
		base.OnActionDisable();
	}

	protected override void OnActionEnable()
	{
		NovaLogger.Debug("_12001 Action OnEnable");
		_player = _actor as PlayerAdventureActor;
		base.OnActionEnable();
		_skillManage = _actor.GetLogicComponent<PlayerSkillCd>();
		_actor.logicVariable.SetLogicTagValue("SkillNormalAttackStage_120", 1);
	}

	public override void OnStart()
	{
		NovaLogger.Debug("_12001 Action OnStart");
		base.OnStart();
	}

	protected override void OnButtonAPress()
	{
		ILRuntimeAPI.CreateSkill(_skillManage.GetCurrentBindSkillId(ActionKey.A), _actor, SkillPhaseFeatureFlag.Dodge, SkillLauncherType.Character, isInterruptAttack: false);
	}

	protected override void OnButtonBPress()
	{
		ILRuntimeAPI.CreateSkill(_skillManage.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
	}

	protected override void OnButtonDPress()
	{
		if (_actor.logicVariable != null && _skillManage != null)
		{
			ILRuntimeAPI.CreateSkill(_skillManage.GetCurrentBindSkillId(ActionKey.D), _actor, SkillPhaseFeatureFlag.Ultimate, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
		}
	}

	public override void OnStop()
	{
		NovaLogger.Debug("_12001 Action OnStop");
		base.OnStop();
	}

	public void OnUpdate()
	{
		if (_player.isAssist)
		{
			return;
		}
		_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: true);
		bool flag = _actor.actorSkillManage.HaveSkill(SkillPhaseFeatureFlag.Normal);
		bool isObstacleBetweenActorAndTargetAndPreventNormalAttack = IsObstacleBetweenActorAndTargetAndPreventNormalAttack;
		if (_actor.attackTarget != null && !Parallel.dodgeSkill && !_player.dodgeButtonHold)
		{
			FP fP = _actor.DistanceWithRadius(_actor.attackTarget);
			if (fP < CommonUtils.GetAimRange(_actor) && !isObstacleBetweenActorAndTargetAndPreventNormalAttack && !Parallel.ultraSkill)
			{
				if (_actor.aimMode != AdventureActor.AimMode.AimAtAttackTarget)
				{
					_actor.AimAtTarget(_actor.attackTarget);
				}
			}
			else if (_actor.aimMode == AdventureActor.AimMode.AimAtAttackTarget && !Parallel.mainSkill && !Parallel.ultraSkill && !flag)
			{
				_actor.CancelAiming();
			}
			if (fP <= CommonUtils.GetAttackRange(_actor))
			{
				ILRuntimeAPI.CreateSkill(_skillManage.GetCurrentBindSkillId(ActionKey.Normal), _actor, SkillPhaseFeatureFlag.Normal, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
			}
		}
		if (_actor.aimMode != AdventureActor.AimMode.Forward && !Parallel.ultraSkill)
		{
			if (_actor.attackTarget == null || _player.dodgeButtonHold)
			{
				_actor.CancelAiming();
			}
			else if (_actor.attackTarget != null && !flag && _actor.DistanceWithRadius(_actor.attackTarget) > CommonUtils.GetAimRange(_actor))
			{
				_actor.CancelAiming();
			}
		}
	}
}
