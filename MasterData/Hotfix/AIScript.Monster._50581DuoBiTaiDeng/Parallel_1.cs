using AIScript.Monster.Template;
using TrueSync;

namespace AIScript.Monster._50581DuoBiTaiDeng;

public class Parallel_1 : Parallel
{
	private static readonly FP HpPercentStage2 = 0.5;

	private static readonly int Stage2SkillId = 5058104;

	private bool ChangeStage2;

	public override void OnStart()
	{
		base.OnStart();
	}

	protected override void OnInitState()
	{
		base.OnInitState();
		EnterState(1);
	}

	public override void OnDisable()
	{
		base.OnDisable();
	}

	private void OnHpChange(IEvent iEvt)
	{
		if (iEvt is AdventureActorHpChangedEvent adventureActorHpChangedEvent && (adventureActorHpChangedEvent.sender as AdventureActor).Id == _actor.Id && _actor.actorHealthInfo.hpPercentage <= HpPercentStage2 && !ChangeStage2)
		{
			ChangeStage2 = true;
			SwitchState(breakCurrentAction: false, breakForceControl: true, 1, 2);
		}
	}

	protected override void OnSwitchState()
	{
		base.OnSwitchState();
		if (ChangeStage2)
		{
			_actor.logicVariable.SetLogicTagValue("TaiDeng_ChangeState", 2);
			_actor.logicVariable.SetLogicTagValue("TaiDeng_Stage2SkillId", Stage2SkillId);
		}
		AdventureMonsterSwitchCustomStateEvent adventureMonsterSwitchCustomStateEvent = AdventureMonsterSwitchCustomStateEvent.Generate();
		adventureMonsterSwitchCustomStateEvent.sender = _actor;
		adventureMonsterSwitchCustomStateEvent.commonHandle = false;
		adventureMonsterSwitchCustomStateEvent.breakCurrentAction = false;
		adventureMonsterSwitchCustomStateEvent.customHandle = true;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterSwitchCustomStateEvent);
	}
}
