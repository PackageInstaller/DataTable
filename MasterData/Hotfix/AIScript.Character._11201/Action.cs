#define LOG_DEBUG
using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Character._11201;

public class Action : ActorActionBase
{
	protected PlayerSkillCd _skillManage;

	protected override void OnActionDisable()
	{
		NovaLogger.Debug("_11201 Action OnDisable");
		_skillManage = null;
		int currentBindSkillId = _playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal);
		MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintEnd", currentBindSkillId);
	}

	protected override void OnActionEnable()
	{
		NovaLogger.Debug("_11201 Action OnEnable");
		_skillManage = _actor.GetLogicComponent<PlayerSkillCd>();
		_actor.logicVariable.SetLogicTagValue("skillStage", 0);
	}

	public override void OnStart()
	{
		NovaLogger.Debug("_11201 Action OnStart");
		base.OnStart();
	}

	protected override void OnButtonAPress()
	{
		if (_actor.logicVariable != null && _skillManage != null)
		{
			ILRuntimeAPI.CreateSkill(_skillManage.GetCurrentBindSkillId(ActionKey.A), _actor, SkillPhaseFeatureFlag.Dodge);
		}
	}

	protected override void OnButtonAClickOrCancel()
	{
	}

	protected override void OnButtonBPress()
	{
		if (_actor.logicVariable != null && _skillManage != null)
		{
			ILRuntimeAPI.CreateSkill(_skillManage.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.End);
		}
	}

	protected override void OnButtonBCancel()
	{
	}

	protected override void OnButtonDPress()
	{
		if (_actor.logicVariable != null && _skillManage != null)
		{
			ILRuntimeAPI.CreateSkill(_skillManage.GetCurrentBindSkillId(ActionKey.D), _actor, SkillPhaseFeatureFlag.Ultimate, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
			_actor.logicVariable.SetLogicTagValue("skillStage", 0);
		}
	}

	public override void OnStop()
	{
		NovaLogger.Debug("_11201 Action OnStop");
		base.OnStop();
	}

	public void OnUpdate()
	{
		if (!(_actor as PlayerAdventureActor).isAssist)
		{
			_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: true);
			if (_actor.attackTarget != null && !_player.dodgeButtonHold && _actor.DistanceWithRadius(_actor.attackTarget) <= CommonUtils.GetAttackRange(_actor))
			{
				ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal), _actor, SkillPhaseFeatureFlag.Normal, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
			}
		}
		_ = _actor.movementState;
		_ = 8;
	}
}
