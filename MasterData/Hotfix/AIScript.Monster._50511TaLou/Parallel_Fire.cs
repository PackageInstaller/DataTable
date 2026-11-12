using AIScript.Monster.Template;
using TrueSync;

namespace AIScript.Monster._50511TaLou;

public class Parallel_Fire : Parallel
{
	private static readonly FP HpPercentStage2 = 0.7;

	private static readonly FP HpPercentStage3 = 0.3;

	private static readonly int Stage3SkillId = 5051115;

	private bool ChangeStage2;

	private bool ChangeStage3;

	private const HotfixEnum.questCompleteCondClient achievementType_1 = HotfixEnum.questCompleteCondClient.HuoTaLou_001;

	private const HotfixEnum.questCompleteCondClient achievementType_2 = HotfixEnum.questCompleteCondClient.HuoTaLou_002;

	private const string logicTag_Hit_2 = "Achievement";

	private const string logicTag_HitPosition_2 = "HitPosition";

	private bool _achievementTypeFinish_1;

	private bool _canFinishAchievementType_1;

	private bool _achievementTypeFinish_2;

	public override void OnStart()
	{
		base.OnStart();
		InitAchievementData();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_HP_CHANGED", OnHpChange);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("TRIGGER_PERFECTDODGE", OnTriggerPerfect);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_DIED", OnDied);
	}

	protected override void OnInitState()
	{
		base.OnInitState();
		EnterState(1);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_HP_CHANGED", OnHpChange);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRIGGER_PERFECTDODGE", OnTriggerPerfect);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnDied);
	}

	private void OnHpChange(IEvent iEvt)
	{
		if (iEvt is AdventureActorHpChangedEvent adventureActorHpChangedEvent && (adventureActorHpChangedEvent.sender as AdventureActor).Id == _actor.Id)
		{
			if (_actor.actorHealthInfo.hpPercentage <= HpPercentStage2 && !ChangeStage2)
			{
				ChangeStage2 = true;
				SwitchState(breakCurrentAction: false, breakForceControl: false, 1, 2);
			}
			else if (_actor.actorHealthInfo.hpPercentage <= HpPercentStage3 && !ChangeStage3)
			{
				ChangeStage3 = true;
				SwitchState(breakCurrentAction: false, breakForceControl: false, 2, 3);
			}
		}
	}

	protected override void OnSwitchState()
	{
		base.OnSwitchState();
		if (ChangeStage2 && !ChangeStage3)
		{
			_actor.logicVariable.SetLogicTagValue("FireTaLou_ChangeState", 2);
		}
		else if (ChangeStage2 && ChangeStage3)
		{
			_actor.logicVariable.SetLogicTagValue("FireTaLou_ChangeState", 3);
			_actor.logicVariable.SetLogicTagValue("FireTaLou_Stage3SkillId", Stage3SkillId);
		}
		AdventureMonsterSwitchCustomStateEvent adventureMonsterSwitchCustomStateEvent = AdventureMonsterSwitchCustomStateEvent.Generate();
		adventureMonsterSwitchCustomStateEvent.sender = _actor;
		adventureMonsterSwitchCustomStateEvent.commonHandle = false;
		adventureMonsterSwitchCustomStateEvent.breakCurrentAction = false;
		adventureMonsterSwitchCustomStateEvent.customHandle = true;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterSwitchCustomStateEvent);
	}

	private void InitAchievementData()
	{
		_achievementTypeFinish_1 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.HuoTaLou_001);
		_achievementTypeFinish_2 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.HuoTaLou_002);
		_canFinishAchievementType_1 = true;
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (adventureActorReceiveDamageEvent.from is MonsterAdventureActor && adventureActorReceiveDamageEvent.to is PlayerAdventureActor && !_achievementTypeFinish_1 && _canFinishAchievementType_1)
		{
			_canFinishAchievementType_1 = adventureActorReceiveDamageEvent.damageToShieldAndHp <= 0;
		}
	}

	private void OnTriggerPerfect(IEvent evt)
	{
		AdventurePerfectDodgeTrigger adventurePerfectDodgeTrigger = evt as AdventurePerfectDodgeTrigger;
		if (!_achievementTypeFinish_2 && _actor.logicVariable.GetLogicTagToggle("Achievement"))
		{
			TSVector2 logicTagTSVector2Value = _actor.logicVariable.GetLogicTagTSVector2Value("HitPosition");
			AdventureActor actor = adventurePerfectDodgeTrigger.actor;
			if (TSVector2.Distance(actor.tsTransform.Position, logicTagTSVector2Value) <= _actor.logicVariable.GetLogicTagValue("HitRadiusForAchievement") + actor.dtCollider.Radius)
			{
				_achievementTypeFinish_2 = SetAchievementState(HotfixEnum.questCompleteCondClient.HuoTaLou_002);
			}
		}
	}

	private void OnDied(IEvent evt)
	{
		if (evt is AdventureActorDiedEvent adventureActorDiedEvent && adventureActorDiedEvent.actor == _actor && !_achievementTypeFinish_1 && _canFinishAchievementType_1)
		{
			SetAchievementState(HotfixEnum.questCompleteCondClient.HuoTaLou_001);
		}
	}

	private bool SetAchievementState(HotfixEnum.questCompleteCondClient achievementType)
	{
		if (ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, achievementType))
		{
			return true;
		}
		ModuleController<AdventureModuleController>.Instance.SetAchievementFinish(achievementType);
		return ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, achievementType);
	}
}
