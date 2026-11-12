using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14101;

public class ActionScript_Tiger : ActionScript_Summoned
{
	private FP _useTailFlickSkillCD;

	public override void OnEnable()
	{
		base.OnEnable();
		_summonedType = SummonedType.Tiger;
		_useTailFlickSkillCD = 0;
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
		if (_actor.monsterTarget != null)
		{
			if (_actor.DistanceWithRadius(_actor.monsterTarget) > Config_Support.minDistance_DashSkill_Tiger)
			{
				ILRuntimeAPI.CreateSkill(14132022, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false);
			}
			else
			{
				ILRuntimeAPI.CreateSkill(14132023, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false);
			}
		}
		if (_useTailFlickSkillCD > 0)
		{
			_useTailFlickSkillCD -= _actor.LogicDeltaTime;
		}
	}

	protected override void OnMainPlayerActorCastSkill()
	{
		base.OnMainPlayerActorCastSkill();
		if (HavePersonalPerk(514126) && _useTailFlickSkillCD <= 0 && ILRuntimeAPI.CreateSkill(14132024, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false))
		{
			_useTailFlickSkillCD = Config_Support.useTailFlickSkillCD_Tiger;
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_useTailFlickSkillCD = 0;
	}
}
