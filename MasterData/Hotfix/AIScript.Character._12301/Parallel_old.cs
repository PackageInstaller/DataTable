using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using Nova.Hotfix;
using TrueSync;

namespace AIScript.Character._12301;

public class Parallel_old : ParallelBase
{
	private int skillId_Strike = 12356000;

	private int skillId_Dodge = 12320000;

	private static readonly int hitTag_aoe = CommonHelper.StringToHash("123_Attack3");

	private static readonly int hitTag_strike = CommonHelper.StringToHash("123_Park10");

	private static readonly int hitTag_ultr = CommonHelper.StringToHash("123_Ultra");

	private static readonly int hitTag_area_B2T24 = CommonHelper.StringToHash("123_area_b2t24");

	private Dictionary<int, int> dicOnce_B2T24 = new Dictionary<int, int>
	{
		[1] = 0,
		[2] = 0,
		[3] = 0,
		[4] = 0,
		[5] = 0
	};

	private const int perkId_1 = 512301;

	private readonly Dictionary<int, int> dicBuff_1 = new Dictionary<int, int>
	{
		[1] = 12355111,
		[2] = 12355121,
		[3] = 12355131,
		[4] = 12355141,
		[5] = 12355151
	};

	private const int perkId_2 = 512302;

	private readonly Dictionary<int, int> dicBuff_2 = new Dictionary<int, int>
	{
		[1] = 12355211,
		[2] = 12355221,
		[3] = 12355231,
		[4] = 12355241,
		[5] = 12355251
	};

	private const int perkId_4 = 512304;

	private readonly Dictionary<int, int> dicBuff_4 = new Dictionary<int, int>
	{
		[1] = 12355411,
		[2] = 12355421,
		[3] = 12355431,
		[4] = 12355441,
		[5] = 12355451
	};

	private const int perkId_6 = 512306;

	private readonly Dictionary<int, int> dicEngery_6 = new Dictionary<int, int>
	{
		[1] = 1,
		[2] = 2,
		[3] = 3,
		[4] = 4,
		[5] = 5
	};

	private const int perkId_7 = 512307;

	private readonly Dictionary<int, int> dicOnce_7 = new Dictionary<int, int>
	{
		[1] = 12355711,
		[2] = 12355721,
		[3] = 12355731,
		[4] = 12355741,
		[5] = 12355751
	};

	private const int perkId_8 = 512308;

	private readonly Dictionary<int, int> dicOnce_8 = new Dictionary<int, int>
	{
		[1] = 12355811,
		[2] = 12355821,
		[3] = 12355831,
		[4] = 12355841,
		[5] = 12355851
	};

	private const int perkId_9 = 512309;

	private readonly Dictionary<int, int> dicOnce_9 = new Dictionary<int, int>
	{
		[1] = 12355911,
		[2] = 12355921,
		[3] = 12355931,
		[4] = 12355941,
		[5] = 12355951
	};

	private const int perkId_10 = 512310;

	private readonly Dictionary<int, int> dicOnce_10 = new Dictionary<int, int>
	{
		[1] = 12356011,
		[2] = 12356021,
		[3] = 12356031,
		[4] = 12356041,
		[5] = 12356051
	};

	private const int perkId_11 = 512311;

	private Dictionary<int, int> dicCd_11 = new Dictionary<int, int>
	{
		[1] = 30,
		[2] = 27,
		[3] = 24,
		[4] = 21,
		[5] = 18
	};

	private const int perkId_12 = 512312;

	private FP cd_12 = 20;

	private readonly Dictionary<int, int> dicBuff_12 = new Dictionary<int, int>
	{
		[1] = 12356211,
		[2] = 12356221,
		[3] = 12356231,
		[4] = 12356241,
		[5] = 12356251
	};

	private const int perkId_13 = 512313;

	private int effect_13 = 12356311;

	private readonly Dictionary<int, FP> dicHp_13 = new Dictionary<int, FP>
	{
		[1] = 20,
		[2] = 25,
		[3] = 30,
		[4] = 35,
		[5] = 40
	};

	private const int perkId_14 = 512314;

	private int effect_14 = 12356411;

	private readonly Dictionary<int, FP> dicHp_14 = new Dictionary<int, FP>
	{
		[1] = 20,
		[2] = 25,
		[3] = 30,
		[4] = 35,
		[5] = 40
	};

	private const int perkId_15 = 512315;

	private int effect_15 = 12356511;

	private readonly Dictionary<int, FP> dicHp_15 = new Dictionary<int, FP>
	{
		[1] = 20,
		[2] = 25,
		[3] = 30,
		[4] = 35,
		[5] = 40
	};

	private int fate6_once = 12304061;

	private readonly Dictionary<int, FP> perkCd = new Dictionary<int, FP>();

	public PlayerSkillCd skillMgr;

	private PlayerSkillBranchType branchId;

	private FP resetSkillTime;

	private CoroutineNode corRebind;

	private bool isTriggerPerk13;

	private bool isTriggerPerk14;

	private bool isTriggerPerk15;

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TRIGGER_PERFECTDODGE", OnPrefectDodge);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnReceiveDamageBeforeSettlement);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_FINISH_RELOAD", OnFinishReload);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnReceiveCrit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REBIND_SKILL", OnRebindSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_BLOCK", OnBullutBlock);
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
		branchId = (_actor as PlayerAdventureActor).GetSkillBranchType();
		perkCd.Clear();
		Skill skill = Singleton<HotfixDataController>.Instance.GetSkill(skillId_Strike);
		resetSkillTime = FP.FromMyriad(skill.UseTimeHint);
		isTriggerPerk13 = false;
		isTriggerPerk14 = false;
		isTriggerPerk15 = false;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRIGGER_PERFECTDODGE", OnPrefectDodge);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_BEFORE_SETTLEMENT", OnReceiveDamageBeforeSettlement);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_FINISH_RELOAD", OnFinishReload);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnReceiveCrit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REBIND_SKILL", OnRebindSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_BLOCK", OnBullutBlock);
		StopCoroutine(ref corRebind);
	}

	public void OnUpdate()
	{
		FDP hpPercentage = _actor.actorHealthInfo.hpPercentage;
		if (GetPerkLv(512313, out var lv))
		{
			if (hpPercentage < dicHp_13.get_Item(lv))
			{
				if (!isTriggerPerk13)
				{
					_actor.effectManage.AddEffectByAI(effect_13);
					isTriggerPerk13 = true;
				}
			}
			else if (isTriggerPerk13)
			{
				_actor.effectManage.RemoveEffectByAI(effect_13);
				isTriggerPerk13 = false;
			}
		}
		if (GetPerkLv(512314, out lv))
		{
			if (hpPercentage < dicHp_14.get_Item(lv))
			{
				if (!isTriggerPerk14)
				{
					_actor.effectManage.AddEffectByAI(effect_14);
					isTriggerPerk14 = true;
				}
			}
			else if (isTriggerPerk14)
			{
				_actor.effectManage.RemoveEffectByAI(effect_14);
				isTriggerPerk14 = false;
			}
		}
		if (!GetPerkLv(512315, out lv))
		{
			return;
		}
		if (hpPercentage < dicHp_15.get_Item(lv))
		{
			if (!isTriggerPerk15)
			{
				_actor.effectManage.AddEffectByAI(effect_15);
				isTriggerPerk15 = true;
			}
		}
		else if (isTriggerPerk15)
		{
			_actor.effectManage.RemoveEffectByAI(effect_15);
			isTriggerPerk15 = false;
		}
	}

	private void OnPrefectDodge(IEvent evt)
	{
		AdventurePerfectDodgeTrigger adventurePerfectDodgeTrigger = evt as AdventurePerfectDodgeTrigger;
		if (adventurePerfectDodgeTrigger.actor == _actor)
		{
			OnPerfectDodge(adventurePerfectDodgeTrigger);
		}
	}

	private void OnCastSkill(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		if (_actor != null && adventureActorCastSkillEvent.sender as AdventureActor == _actor)
		{
			OnCastSkill(adventureActorCastSkillEvent);
		}
	}

	private void OnCastEndSkill(IEvent evt)
	{
		AdventureActorCastSkillEndEvent adventureActorCastSkillEndEvent = evt as AdventureActorCastSkillEndEvent;
		if (_actor != null && adventureActorCastSkillEndEvent.sender as AdventureActor == _actor)
		{
			OnCastEndSkill(adventureActorCastSkillEndEvent);
		}
	}

	private void OnReceiveDamageBeforeSettlement(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeSettlementEvent adventureActorReceiveDamageBeforeSettlementEvent = evt as AdventureActorReceiveDamageBeforeSettlementEvent;
		if (_actor != null && _actor.Id == adventureActorReceiveDamageBeforeSettlementEvent.from.Id)
		{
			OnHitPre(adventureActorReceiveDamageBeforeSettlementEvent);
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (_actor != null && _actor.Id == adventureActorReceiveDamageEvent.from.Id)
		{
			OnHitPost(adventureActorReceiveDamageEvent);
		}
		else if (_actor != null && _actor.Id == adventureActorReceiveDamageEvent.to.Id)
		{
			OnHurt(adventureActorReceiveDamageEvent);
		}
	}

	private void OnFinishReload(IEvent evt)
	{
		AdventureActorFinishReload adventureActorFinishReload = evt as AdventureActorFinishReload;
		if (_actor != null && adventureActorFinishReload.sender as AdventureActor == _actor)
		{
			OnFinishReload(adventureActorFinishReload);
		}
	}

	private void OnReceiveCrit(IEvent evt)
	{
		AdventureActorReceiveCritDamageEvent adventureActorReceiveCritDamageEvent = evt as AdventureActorReceiveCritDamageEvent;
		if (_actor != null && _actor.Id == adventureActorReceiveCritDamageEvent.from.Id && adventureActorReceiveCritDamageEvent.to as MonsterAdventureActor != null)
		{
			OnCrit(adventureActorReceiveCritDamageEvent);
		}
	}

	private void OnRebindSkill(IEvent _evt)
	{
		if (_evt is AdventurRebindSkill adventurRebindSkill && adventurRebindSkill.sender as AdventureActor == _actor)
		{
			OnRebindSkill(adventurRebindSkill);
		}
	}

	private void OnReceiveBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (_actor != null && adventureActorReceiveDamageBeforeHitEvent.from.Id == _actor.Id)
		{
			OnBeforeHit(adventureActorReceiveDamageBeforeHitEvent);
		}
	}

	private void OnBullutBlock(IEvent evt)
	{
		AdventureBulletBlockEvent adventureBulletBlockEvent = evt as AdventureBulletBlockEvent;
		if (_actor != null && adventureBulletBlockEvent.owner.Id == _actor.Id)
		{
			OnBullutBlock(adventureBulletBlockEvent);
		}
	}

	public virtual void OnPerfectDodge(AdventurePerfectDodgeTrigger evt)
	{
		if (GetPerkLv(512311, out var lv) && CheckCd(512311, dicCd_11.get_Item(lv)))
		{
			skillMgr.ResetSkillCD(ActionKey.B);
		}
		if (GetPerkLv(512312, out lv) && CheckCd(512312, cd_12))
		{
			_actor.buffComponent.AddBuff(dicBuff_12.get_Item(lv), _actor);
		}
	}

	public virtual void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		if (evt.skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.B)
		{
			return;
		}
		int lv;
		if (branchId == PlayerSkillBranchType.Branch1)
		{
			if (GetPerkLv(512301, out lv))
			{
				Singleton<BuffManager>.Instance.AddBufftoGroup(dicBuff_1.get_Item(lv), _actor);
			}
			if (GetPerkLv(512302, out lv))
			{
				Singleton<BuffManager>.Instance.AddBufftoGroup(dicBuff_2.get_Item(lv), _actor);
			}
		}
		else if (GetPerkLv(512304, out lv))
		{
			Singleton<BuffManager>.Instance.AddBufftoGroup(dicBuff_4.get_Item(lv), _actor);
		}
	}

	public virtual void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.A && evt.skillEventInfo.skillId == skillId_Strike)
		{
			StopCoroutine(ref corRebind);
			skillMgr.BindSkillIdToButton(ActionKey.A, skillId_Dodge);
		}
	}

	public virtual void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt)
	{
		int lv = 0;
		if (!(evt.to as MonsterAdventureActor != null))
		{
			return;
		}
		if (evt.skillSlotType == HotfixEnum.skillSlotType.NORMAL)
		{
			if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_aoe))
			{
				if (GetPerkLv(512307, out lv))
				{
					AdventureActor.AddFromAttr(dicOnce_7.get_Item(lv), _actor);
				}
				if (GetPerkLv(512308, out lv))
				{
					AdventureActor.AddFromAttr(dicOnce_8.get_Item(lv), _actor);
				}
				if (GetPerkLv(512309, out lv))
				{
					AdventureActor.AddFromAttr(dicOnce_9.get_Item(lv), _actor);
				}
			}
		}
		else if (evt.skillSlotType == HotfixEnum.skillSlotType.A)
		{
			if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_strike) && GetPerkLv(512310, out lv))
			{
				AdventureActor.AddFromAttr(dicOnce_10.get_Item(lv), _actor);
			}
		}
		else if (evt.skillSlotType == HotfixEnum.skillSlotType.D)
		{
			if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_ultr))
			{
				int num = (int)(long)_actor.logicVariable.GetLogicTagValue("clearCount");
				for (int i = 0; i < num; i++)
				{
					AdventureActor.AddFromAttr(fate6_once, _actor);
				}
			}
		}
		else if (evt.skillSlotType == HotfixEnum.skillSlotType.B && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_area_B2T24))
		{
			AdventureActor.AddFromAttr(dicOnce_B2T24.get_Item(lv), _actor);
		}
	}

	public virtual void OnHitPre(AdventureActorReceiveDamageBeforeSettlementEvent evt)
	{
		_ = evt.to as MonsterAdventureActor != null;
	}

	public virtual void OnHitPost(AdventureActorReceiveDamageEvent evt)
	{
		_ = evt.to as MonsterAdventureActor != null;
	}

	public virtual void OnHurt(AdventureActorReceiveDamageEvent _evt)
	{
	}

	public virtual void OnFinishReload(AdventureActorFinishReload evt)
	{
	}

	public virtual void OnCrit(AdventureActorReceiveCritDamageEvent evt)
	{
	}

	public virtual void OnRebindSkill(AdventurRebindSkill evt)
	{
		skillMgr.BindSkillIdToButton(evt.slotKey, evt.skillId);
		if (evt.skillId == skillId_Strike)
		{
			StartCoroutine(ref corRebind, ResetSkill());
		}
	}

	public virtual void OnBullutBlock(AdventureBulletBlockEvent evt)
	{
		if (GetPerkLv(512306, out var lv))
		{
			SceneSingleton<AdventurePlayerController>.Instance.AddEnergy(dicEngery_6.get_Item(lv));
		}
	}

	private IEnumerator ResetSkill()
	{
		yield return resetSkillTime;
		skillMgr.BindSkillIdToButton(ActionKey.A, skillId_Dodge, resetSection: true);
	}

	public bool CheckCd(int perkId, FP Cd)
	{
		bool result = false;
		if (perkCd.TryGetValue(perkId, out var value))
		{
			if (_actor.LogicTime - value > Cd)
			{
				result = true;
				perkCd.set_Item(perkId, value);
			}
		}
		else
		{
			perkCd.Add(perkId, _actor.LogicTime);
			result = true;
		}
		return result;
	}

	public bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
