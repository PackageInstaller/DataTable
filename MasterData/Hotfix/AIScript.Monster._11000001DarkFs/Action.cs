using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._11000001DarkFs;

public class Action : AIBase
{
	private const int skillA_chongCi = 11031001;

	private const int skillA_henSao = 11031002;

	private const int skillB_chongCi = 11032001;

	private readonly FP attackCd = 1.5;

	private const int perk_28 = 511028;

	private const int parameterId_28 = 11052801;

	private const int buff_28 = 11052811;

	private const int perk_30 = 511030;

	private readonly int fsBAttackTag = CommonHelper.StringToHash("110SupportFenShenAtk");

	private const int buff_30 = 11030011;

	private readonly Dictionary<long, FP> _perkTriggerTimeDic = new Dictionary<long, FP>(20);

	private PlayerAdventureActor summoner;

	private FP curerentCd;

	private FP skillValue;

	private bool iAsset;

	public void OnEnable()
	{
		skillValue = 0;
		summoner = (_actor as MonsterAdventureActor).monsterSummonInfo.SummonActor as PlayerAdventureActor;
		_actor.tsTransform.Forward = summoner.tsTransform.Forward;
		iAsset = summoner.isAssist;
		_actor.logicVariable.ToggleLogicTag("iAsset", iAsset);
		curerentCd = attackCd;
		if (CanTriggerPerk(511028, 0, out var _))
		{
			curerentCd = curerentCd * (100 - CommonUtils.GetScriptValue(_actor, 11052801)) / 100;
			_actor.buffComponent.AddBuff(11052811, _actor);
		}
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_NORMAL_EVENT", OnSkill);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_NORMAL_EVENT", OnSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		_perkTriggerTimeDic.Clear();
	}

	public void OnStart()
	{
		_actor.EnableCloseBlock();
		_actor.EnableMovementAgent();
		_actor.movAgent.canBlock = false;
		CommonUtils_MonsterAPI.SetUnparalleledEnable(_actor);
		_actor.EnableSearchedImmunity();
		if (skillValue > 0)
		{
			_actor.logicVariable.SetLogicTagValue("110_skill", 0);
			return;
		}
		skillValue = _actor.logicVariable.GetLogicTagValue("110_skill");
		if (skillValue <= 0)
		{
			skillValue = summoner.logicVariable.GetLogicTagValue("110_skill");
		}
		if (skillValue > 0)
		{
			_actor.logicVariable.SetLogicTagValue("110_skill", 0);
			if (skillValue == 1)
			{
				skillChongCi();
			}
			else if (skillValue == 2)
			{
				_actor.logicVariable.ToggleLogicTag("hs", value: true);
				skillHenSao();
			}
			else if (skillValue == 3)
			{
				_actor.logicVariable.ToggleLogicTag("hs", value: false);
				skillHenSao();
			}
		}
	}

	protected void OnSkill(IEvent evt)
	{
		AdventurActorNormalEvent adventurActorNormalEvent = evt as AdventurActorNormalEvent;
		if (adventurActorNormalEvent.sender is PlayerAdventureActor playerAdventureActor && playerAdventureActor.Id == summoner.Id && adventurActorNormalEvent.enventTag.Equals("fsSkill"))
		{
			skillValue = adventurActorNormalEvent.stateID;
			if (adventurActorNormalEvent.stateID == 1)
			{
				skillChongCi();
			}
			else if (adventurActorNormalEvent.stateID == 2)
			{
				_actor.logicVariable.ToggleLogicTag("hs", value: true);
				skillHenSao();
			}
			else if (adventurActorNormalEvent.stateID == 3)
			{
				_actor.logicVariable.ToggleLogicTag("hs", value: false);
				skillHenSao();
			}
		}
	}

	private void OnBattleReady(IEvent evt)
	{
		if (_actor != null)
		{
			_actor.DestroySelf();
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (!(summoner != null) || iAsset)
		{
			LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
			if (activedPlayerActor != null && _actor != null && activedPlayerActor.Id == adventureActorReceiveDamageEvent.from.Id && adventureActorReceiveDamageEvent.hitDamageTag != null && CheckPerkCd(511028L, curerentCd))
			{
				skillChongCi();
			}
			if (GetPerk(511030) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, fsBAttackTag))
			{
				_actor.buffComponent.AddBuff(11030011, _actor);
			}
		}
	}

	private void skillChongCi()
	{
		ILRuntimeAPI.CreateSkill(summoner.isAssist ? 11032001 : 11031001, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false);
	}

	private void skillHenSao()
	{
		ILRuntimeAPI.CreateSkill(11031002, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false);
	}

	protected bool CanTriggerPerk(int perkId, FP cd, out int lv)
	{
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(summoner.dataID, perkId, out lv))
		{
			return CheckPerkCd(perkId, cd);
		}
		return false;
	}

	protected override bool CheckPerkCd(long perkId, FP Cd)
	{
		if (Cd <= 0)
		{
			return true;
		}
		bool result = false;
		if (_perkTriggerTimeDic.TryGetValue(perkId, out var value))
		{
			if (_actor.LogicTime - value > Cd)
			{
				result = true;
				_perkTriggerTimeDic.set_Item(perkId, _actor.LogicTime);
			}
		}
		else
		{
			_perkTriggerTimeDic.Add(perkId, _actor.LogicTime);
			result = true;
		}
		return result;
	}

	public void OnUpdate()
	{
	}
}
