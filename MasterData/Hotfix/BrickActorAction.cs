using System.Collections.Generic;
using AIScript;
using AdventureBehaviour;
using TrueSync;

public class BrickActorAction : ActorActionBase
{
	protected FP recoveryEnerey = 5;

	protected BrickActor actor => _actor as BrickActor;

	protected override void OnActionEnable()
	{
		List<BrickSkillInfo> list = new List<BrickSkillInfo>();
		BrickSkillInfo item = new BrickSkillInfo(actor.mainSkillId, actor.maxEnergy, actor.skillCD);
		list.Add(item);
		actor.skillMgr?.RegisterAllSkill(list);
		actor.skillMgr?.SetRecoveryEnerey(recoveryEnerey);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
	}

	protected override void OnActionDisable()
	{
		actor.skillMgr?.UnRegisterAllSkill();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		base.OnActionDisable();
	}

	public override void OnStart()
	{
		base.OnStart();
	}

	public override void OnStop()
	{
		base.OnStop();
	}

	protected override void OnButtonAPress()
	{
		if (!Singleton<BrickBreakerManager>.Instance.IsLaunched)
		{
			Singleton<BrickBreakerManager>.Instance.BallLaunchState(launch: true);
		}
	}

	protected override void OnButtonAClickOrCancel()
	{
	}

	protected override void OnButtonBPress()
	{
	}

	protected override void OnButtonBCancel()
	{
	}

	protected virtual bool SkillCheck()
	{
		return true;
	}

	protected override void OnButtonDPress()
	{
		int mainSkillId = (_actor as BrickActor).mainSkillId;
		if (actor.skillMgr.CanExcute(mainSkillId) && SkillCheck())
		{
			ILRuntimeAPI.CreateSkill(mainSkillId, _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.DynamicActor, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, null, (FP cd) =>
			{
			});
		}
	}

	private void OnCastSkill(IEvent evt)
	{
		if (evt is AdventureActorCastSkillEvent adventureActorCastSkillEvent && _actor != null && adventureActorCastSkillEvent.sender as AdventureActor == _actor)
		{
			int mainSkillId = (_actor as BrickActor).mainSkillId;
			actor.skillMgr.ResetEnergy(mainSkillId);
			ActorCastSkill();
		}
	}

	protected virtual void ActorCastSkill()
	{
	}
}
