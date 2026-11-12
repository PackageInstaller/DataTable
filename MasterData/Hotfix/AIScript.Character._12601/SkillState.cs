using AdventureBehaviour;

namespace AIScript.Character._12601;

public class SkillState : IState
{
	public ActionKey actionKey;

	public SkillPhaseFeatureFlag skillPhaseFeatureFlag;

	public bool CanCast;

	public int specialSkill;

	public bool isInterruptAttack;

	public bool isRushJoinDodge;

	public override void Enter()
	{
		base.Enter();
		SkillCountdownTiming skillCountdownTiming = SkillCountdownTiming.Start;
		int currentBindSkillId;
		if (specialSkill != 0)
		{
			currentBindSkillId = specialSkill;
		}
		else
		{
			currentBindSkillId = _skillManage.GetCurrentBindSkillId(actionKey);
			if (actionKey == ActionKey.B)
			{
				skillCountdownTiming = SkillCountdownTiming.End;
			}
			if (actionKey == ActionKey.D)
			{
				isInUltimate = true;
			}
		}
		if (currentBindSkillId == 12631001 && _actor.attackFSM.isPlayingCombo)
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.eventName = "126_B1_HatReturn";
			_actor.DispatchEvent(adventureActorCustomEvent);
			AdventureActorCustomEvent adventureActorCustomEvent2 = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent2.eventName = "Stop_B_S2";
			_actor.DispatchEvent(adventureActorCustomEvent2);
			return;
		}
		int skillId = currentBindSkillId;
		AdventureActor actor = _actor;
		SkillPhaseFeatureFlag skillCastBehaviourType = skillPhaseFeatureFlag;
		SkillCountdownTiming countdownTiming = skillCountdownTiming;
		CanCast = ILRuntimeAPI.CreateSkill(skillId, actor, skillCastBehaviourType, SkillLauncherType.Character, isInterruptAttack, isBreakable: false, countdownTiming, (bool success) =>
		{
			Exit();
			isInUltimate = false;
		}, null, ingoreCDAndEnergy: false, isRushJoinDodge);
	}

	public override void Update()
	{
		base.Update();
		if (GetAttackTarget() != null && _actor.attackComboPhase == Combo.Phase.Recovery && _actor.CheckBreakAttack(SkillPhaseFeatureFlag.Normal))
		{
			_actor.InterruptAttack(force: true);
		}
	}
}
