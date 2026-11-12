using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14101;

public class ActionScript_Dragon : ActionScript_Summoned
{
	private FP _useShootSkillInterval;

	private FP _useStrengthShootSkillCD;

	public override void OnEnable()
	{
		base.OnEnable();
		_summonedType = SummonedType.Dragon;
		_useShootSkillInterval = 0;
		_useStrengthShootSkillCD = 0;
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as PlayerAdventureActor;
		if (playerAdventureActor?.attackTarget != null)
		{
			_actor.monsterTarget = playerAdventureActor.attackTarget;
		}
		else if (!CommonUtils.CheckTargetIsValid(_actor.monsterTarget, 0L))
		{
			_actor.monsterTarget = null;
		}
		if (_useShootSkillInterval <= 0)
		{
			if (_actor.monsterTarget != null)
			{
				_useShootSkillInterval = Config_Support.useShootSkillInterval_Dragon;
				ILRuntimeAPI.CreateSkill(14132012, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false);
			}
		}
		else
		{
			_useShootSkillInterval -= _actor.LogicDeltaTime;
		}
		if (_useStrengthShootSkillCD > 0)
		{
			_useStrengthShootSkillCD -= _actor.LogicDeltaTime;
		}
	}

	protected override void OnMainPlayerActorCastSkill()
	{
		base.OnMainPlayerActorCastSkill();
		if (HavePersonalPerk(514126) && _useStrengthShootSkillCD <= 0 && ILRuntimeAPI.CreateSkill(14132013, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false))
		{
			_useStrengthShootSkillCD = Config_Support.useStrengthShootSkillCD_Dragon;
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_useShootSkillInterval = 0;
		_useStrengthShootSkillCD = 0;
	}
}
