#define LOG_ERROR
using AIScript.Monster.Template;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class Parallel_3 : AIScript.Monster.Template.Parallel
{
	protected FP hpPercentage_Stage = 0.7;

	protected bool isChangeSatge;

	private const HotfixEnum.questCompleteCondClient achievementType_1 = HotfixEnum.questCompleteCondClient.ShaSha_001;

	private static readonly int checkHitTag_1 = CommonHelper.StringToHash("ShaSha_Duyu");

	private const HotfixEnum.questCompleteCondClient achievementType_2 = HotfixEnum.questCompleteCondClient.ShaSha_002;

	private static readonly int checkBuffTag_2 = CommonHelper.StringToHash("SharkBuff");

	private const HotfixEnum.questCompleteCondClient achievementType_3 = HotfixEnum.questCompleteCondClient.ShaSha_003;

	private static readonly int checkBuffTag_3 = CommonHelper.StringToHash("SharkSlow");

	private static readonly FP checkBuffTime_3 = 10;

	private bool _achievementTypeFinish_1;

	private bool _canFinishAchievementType_1;

	private bool _achievementTypeFinish_2;

	private bool _achievementTypeFinish_3;

	private bool _haveBuff_3;

	private FP _haveBuffTime_3;

	public override void OnStart()
	{
		base.OnStart();
		isChangeSatge = false;
		InitAchievementData();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_HP_CHANGED", OnHpChange);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnToughnessStateChange);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_DIED", OnDied);
	}

	protected override void OnInitState()
	{
		base.OnInitState();
		EnterState(1);
	}

	private void OnHpChange(IEvent iEvt)
	{
		if (iEvt is AdventureActorHpChangedEvent adventureActorHpChangedEvent && (adventureActorHpChangedEvent.sender as AdventureActor).Id == _actor.Id && _actor.actorHealthInfo.hpPercentage <= hpPercentage_Stage && !isChangeSatge)
		{
			isChangeSatge = true;
			SwitchState(breakCurrentAction: false, breakForceControl: false, 1, 2);
		}
	}

	protected override void OnSwitchState()
	{
		base.OnSwitchState();
		if (MonsterInState(2))
		{
			_actor.logicVariable.ToggleLogicTag("5050100ShaShaChangeStage", value: true);
			AdventureMonsterSwitchCustomStateEvent adventureMonsterSwitchCustomStateEvent = AdventureMonsterSwitchCustomStateEvent.Generate();
			adventureMonsterSwitchCustomStateEvent.commonHandle = false;
			adventureMonsterSwitchCustomStateEvent.breakCurrentAction = false;
			adventureMonsterSwitchCustomStateEvent.customHandle = true;
			_actor.DispatchEvent(adventureMonsterSwitchCustomStateEvent);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_HP_CHANGED", OnHpChange);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnToughnessStateChange);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnDied);
	}

	private void InitAchievementData()
	{
		_achievementTypeFinish_1 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.ShaSha_001);
		_achievementTypeFinish_2 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.ShaSha_002);
		_achievementTypeFinish_3 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.ShaSha_003);
		_canFinishAchievementType_1 = true;
		_haveBuff_3 = false;
		_haveBuffTime_3 = 0;
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (adventureActorReceiveDamageEvent.from == _actor && adventureActorReceiveDamageEvent.to is PlayerAdventureActor && !_achievementTypeFinish_1 && _canFinishAchievementType_1)
		{
			_canFinishAchievementType_1 = !CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, checkHitTag_1);
		}
	}

	private void OnToughnessStateChange(IEvent evt)
	{
		MonsterToughnessStateChangeEvent monsterToughnessStateChangeEvent = evt as MonsterToughnessStateChangeEvent;
		if (monsterToughnessStateChangeEvent.actor == _actor && monsterToughnessStateChangeEvent.isToughnessBroken && !_achievementTypeFinish_2 && _actor.buffComponent.CheckBuffByBuffTag(checkBuffTag_2))
		{
			_achievementTypeFinish_2 = SetAchievementState(HotfixEnum.questCompleteCondClient.ShaSha_002);
		}
	}

	private void OnGetBuff(IEvent evt)
	{
		AdventureActorGetBuff adventureActorGetBuff = evt as AdventureActorGetBuff;
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		if (adventureActorGetBuff.sender is PlayerAdventureActor playerAdventureActor && playerAdventureActor == activedPlayerActor && adventureActorGetBuff.from == _actor && !_achievementTypeFinish_3 && adventureActorGetBuff.eventInfo.buffTags.Contains(checkBuffTag_3))
		{
			_haveBuff_3 = true;
		}
	}

	public void OnUpdate()
	{
		if (!_achievementTypeFinish_3 && _haveBuff_3)
		{
			_haveBuffTime_3 += _actor.LogicDeltaTime;
			if (_haveBuffTime_3 >= checkBuffTime_3)
			{
				_achievementTypeFinish_3 = SetAchievementState(HotfixEnum.questCompleteCondClient.ShaSha_003);
			}
		}
	}

	private void OnRemoveBuff(IEvent evt)
	{
		AdventureActorRemoveBuff adventureActorRemoveBuff = evt as AdventureActorRemoveBuff;
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		if (adventureActorRemoveBuff.sender is PlayerAdventureActor playerAdventureActor && playerAdventureActor == activedPlayerActor && !_achievementTypeFinish_3 && adventureActorRemoveBuff.eventInfo.buffTags.Contains(checkBuffTag_3))
		{
			_haveBuff_3 = false;
		}
	}

	private void OnDied(IEvent evt)
	{
		if (evt is AdventureActorDiedEvent adventureActorDiedEvent && adventureActorDiedEvent.actor == _actor && !_achievementTypeFinish_1 && _canFinishAchievementType_1)
		{
			SetAchievementState(HotfixEnum.questCompleteCondClient.ShaSha_001);
		}
	}

	private bool SetAchievementState(HotfixEnum.questCompleteCondClient achievementType)
	{
		if (ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, achievementType))
		{
			return true;
		}
		NovaLogger.Error("完成成就" + achievementType);
		ModuleController<AdventureModuleController>.Instance.SetAchievementFinish(achievementType);
		return ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, achievementType);
	}
}
