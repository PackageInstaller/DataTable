using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11201;

public class Parallel : ParallelBase
{
	private int buff_m1 = 11296111;

	private int buff_m2 = 11296211;

	public const int buff_m3 = 11296311;

	private int buff_m4 = 11296411;

	private int buff_m5 = 11296511;

	private static readonly int windBoomHit = CommonHelper.StringToHash("112WindTagBoom");

	private readonly string windAreaEffect_1 = "AreaEffect_112_WindTagTrigger_XuanFeng";

	private const string tipsKey_TriggerMark = "WindMark_Trigger_Effect_04";

	private readonly FP windAearaPos_radius = 1.5f;

	private readonly int personalPerkId_10 = 511210;

	private readonly int buffID_10 = 11251011;

	private const int attri_PerkId10 = 11251001;

	private readonly int personalPerkId_11 = 511211;

	private readonly FP perkId_11_CD = 10;

	private const int parameterId_11 = 11251101;

	private readonly int personalPerkId_12 = 511212;

	private readonly FP dis_12 = 2;

	private const int add_num = 1;

	private const int attri_PerkId12 = 11251201;

	public const int personalPerkId_13 = 511213;

	private readonly FP dis_13 = 2;

	private const int attri_PerkId13 = 11251301;

	private readonly int personalPerkId_33 = 511233;

	private readonly FP perkId_33_CD = 7;

	private const int parameterId_33 = 11253301;

	private readonly int atk_nomal = CommonHelper.StringToHash("NrmAtk");

	protected readonly int personalPerkId_3 = 511203;

	private const int parameterId_Cd_03 = 11250301;

	private const int parameterId_Power_03 = 11250303;

	private const int parameterId_Pr_03 = 11250302;

	private const string areaRes_p3 = "AreaEffect_112_T3";

	protected readonly int personalPerkId_4 = 511204;

	private readonly FP perkId_4_CD = 6;

	private FP range_p4 = 7;

	private readonly int skillTag = CommonHelper.StringToHash("SkillAtk");

	private readonly int UltraAtk = CommonHelper.StringToHash("UltraAtk");

	private readonly int personalPerkId_9 = 511209;

	private readonly int num_9 = 10;

	private const int attri_PerkId9 = 11250901;

	private readonly int personalPerkId_41 = 511241;

	private readonly int count_max_p41 = 5;

	private const int parameterId_41 = 11254101;

	public static readonly int personalPerkId_42 = 511242;

	public const int buff_PerkId42 = 11254211;

	private readonly int personalPerkId_43 = 511243;

	public const int buff_PerkId43 = 11254311;

	public static readonly int personalPerkId_1 = 511201;

	public static readonly int skillId_StageOne = 11231001;

	public static readonly int skillId_StageTwo = 11231002;

	private FP waitTime_resetSkill = 3;

	public const int personalPerkId_P2 = 511202;

	public const int personalPerkId_P5 = 511205;

	public const int personalPerkId_P6 = 511206;

	private readonly int personalPerkId_P7 = 511207;

	private const int buff_P7 = 11250711;

	public static readonly int personalPerkId_8 = 511208;

	private FP perkId_8_CD = 7;

	public const int buff_P8 = 11250811;

	public static readonly int personalPerkId_21 = 511221;

	public static readonly int personalPerkId_22 = 511222;

	public static readonly int personalPerkId_23 = 511223;

	private readonly int xFenrHitTag = CommonHelper.StringToHash("LightWBlade");

	public static readonly int personalPerkId_24 = 511224;

	private readonly int personalPerkId_25 = 511225;

	private readonly int daFenrHitTag = CommonHelper.StringToHash("HeavyWBlade");

	private const int onceId_25 = 11252501;

	public static readonly int personalPerkId_26 = 511226;

	private const int onceId_26 = 11252601;

	private readonly int personalPerkId_27 = 511227;

	private FP cd_27 = 0;

	private int hitCount_27 = 1;

	private readonly int buffId_27 = 11252711;

	private const int onceId_27 = 11252701;

	private readonly int personalPerkId_28 = 511228;

	private const int onceId_28 = 11252801;

	public static readonly int personalPerkId_29 = 511229;

	private readonly int frHitTag = CommonHelper.StringToHash("FengRen");

	private const int attri_PerkId29 = 11252901;

	private readonly int personalPerkId_30 = 511230;

	private FP cd_30 = 5;

	private const int parameterId_30 = 11253001;

	private readonly int personalPerkId_31 = 511231;

	private readonly int buff_31 = 11253111;

	private readonly int personalPerkId_32 = 511232;

	private const int attri_PerkId32 = 11253201;

	private static int perkId_st = 9102999;

	private readonly string fenrengTag = "";

	private const string bullet_st = "";

	protected PlayerSkillCd _skillManager;

	protected CoroutineNode _resetSkillNode;

	protected long m1CD_Id = 11200001L;

	private int p9Normal_hitNum;

	private Dictionary<long, FP> cdDic = new Dictionary<long, FP>(10);

	private Dictionary<long, FP> cdDic_Value = new Dictionary<long, FP>(10);

	private Dictionary<long, int> perk27_Dic = new Dictionary<long, int>(10);

	public static FP normalComboTime;

	public static int num_p41;

	public static bool dodgeSkill;

	public override void OnEnable()
	{
		base.OnEnable();
		cdDic.Clear();
		cdDic_Value.Clear();
		perk27_Dic.Clear();
		_actor.logicVariable.SetLogicTagValue("normalCount", 0);
		normalComboTime = 0;
		num_p41 = 0;
		if (_skillManager == null)
		{
			_skillManager = (_actor as PlayerAdventureActor)?.playerSkillCd;
		}
		if (GetPerk(personalPerkId_12))
		{
			PlayerSkillCd playerSkillCd = (_actor as PlayerAdventureActor).playerSkillCd;
			SkillInfo skillCD = playerSkillCd.GetSkillCD(ActionKey.A);
			playerSkillCd.SetSkillTotalSection(ActionKey.A, skillCD.totalSectionAmount + 1, forceMaxSection: true);
		}
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_CANCAUSE_DEAD", OnReceiveDamageBeDeath);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		_actor.actorSearchTargetInfo.ResetSearchRange(ActorSearchTarget.SearchType.allRange);
		if (ModuleController<AdventureModuleController>.Instance._LogicValue.TryGetValue("112BeginReset", out var value) && value)
		{
			_skillManager?.BindSkillIdToButton(ActionKey.B, skillId_StageOne, resetSection: true);
			_actor.logicVariable.ToggleLogicTag("FinishReset", value: false);
			ModuleController<AdventureModuleController>.Instance?.SetLevelLogicValue("112BeginReset", value: false);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		StopCoroutine(ref _resetSkillNode);
		_skillManager = null;
		_actor.logicVariable.ToggleLogicTag("DogeSkill", value: false);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_CANCAUSE_DEAD", OnReceiveDamageBeDeath);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
	}

	private bool CanTriggerPerk(int perkId, out int perkLevel)
	{
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out perkLevel))
		{
			return GetCurrentCd(perkId) <= 0;
		}
		return false;
	}

	private FP GetCurrentCd(long key)
	{
		if (cdDic.Count > 0 && cdDic.TryGetValue(key, out var value))
		{
			if (!(_actor.LogicTime - cdDic_Value.get_Item(key) > value))
			{
				return value;
			}
			cdDic.Remove(key);
			cdDic_Value.Remove(key);
		}
		return 0;
	}

	public void SetCurrentCd(long key, FP _value)
	{
		if (!cdDic.ContainsKey(key))
		{
			cdDic.Add(key, _value);
			cdDic_Value.Add(key, _actor.LogicTime);
		}
		else
		{
			cdDic_Value.set_Item(key, _actor.LogicTime);
		}
	}

	private void OnBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (!(_actor != null) || _actor.Id != adventureActorReceiveDamageBeforeHitEvent.from?.Id || !(adventureActorReceiveDamageBeforeHitEvent.to != null))
		{
			return;
		}
		if (GetPerk(personalPerkId_9))
		{
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, atk_nomal))
			{
				p9Normal_hitNum++;
			}
			else if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, UltraAtk))
			{
				p9Normal_hitNum = ((p9Normal_hitNum > num_9) ? num_9 : p9Normal_hitNum);
				AdventureActor.AddFromAttr(11250901, _actor, p9Normal_hitNum);
			}
		}
		if (GetPerk(personalPerkId_10) && adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor monsterAdventureActor)
		{
			monsterAdventureActor.buffComponent.AddBuff(buffID_10, _actor);
			int buffNum = monsterAdventureActor.buffComponent.GetBuffNum(buffID_10, 0);
			AdventureActor.AddFromAttr(11251001, _actor, buffNum);
		}
		if (GetPerk(personalPerkId_12) && _actor.DistanceWithRadius(adventureActorReceiveDamageBeforeHitEvent.to) <= dis_12)
		{
			AdventureActor.AddFromAttr(11251201, _actor);
		}
		if (GetPerk(511213) && _actor.DistanceWithRadius(adventureActorReceiveDamageBeforeHitEvent.to) > dis_13)
		{
			AdventureActor.AddFromAttr(11251301, _actor);
		}
		if (GetPerk(personalPerkId_25) && adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor target && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, daFenrHitTag) && CommonUtils.CheckElementMark(CommonDefine.WindMark1, target))
		{
			AdventureActor.AddFromAttr(11252501, _actor);
		}
		if (GetPerk(personalPerkId_26))
		{
			AdventureActor.AddFromAttr(11252601, _actor);
		}
		if (GetPerk(personalPerkId_27) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, daFenrHitTag))
		{
			AdventureActor.AddFromAttr(11252701, _actor);
		}
		if (GetPerk(personalPerkId_28) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, xFenrHitTag))
		{
			AdventureActor.AddFromAttr(11252801, _actor);
		}
		if (GetPerk(personalPerkId_29) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, frHitTag))
		{
			AdventureActor.AddFromAttr(11252901, _actor);
		}
		if (GetPerk(personalPerkId_32) && adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor monsterAdventureActor2 && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, frHitTag) && (monsterAdventureActor2.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE || monsterAdventureActor2.IsBossMonster()))
		{
			AdventureActor.AddFromAttr(11253201, _actor);
		}
		if (GetPerk(personalPerkId_43) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, UltraAtk))
		{
			_actor.buffComponent.AddBuff(11254311, _actor);
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (!(_actor != null) || _actor.Id != adventureActorReceiveDamageEvent.from.Id || !(adventureActorReceiveDamageEvent.to != null))
		{
			return;
		}
		OnTriggerWindBrust(adventureActorReceiveDamageEvent);
		if (GetPerk(personalPerkId_P7) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, skillTag))
		{
			_actor.buffComponent?.AddBuff(11250711, _actor);
		}
		if (GetPerk(personalPerkId_11, perkId_11_CD) && adventureActorReceiveDamageEvent.to is MonsterAdventureActor monsterAdventureActor)
		{
			long damage = (long)(CommonUtils.GetScriptValue(_actor, 11251101) * monsterAdventureActor.monsterToughnessInfo.toughnessMax);
			monsterAdventureActor.monsterToughnessInfo.DamageToToughness(_actor, damage);
		}
		if (CheckTalentLevel(1) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, UltraAtk) && !_actor.buffComponent.CheckBuffByBuffID(buff_m1))
		{
			_actor.buffComponent.AddBuff(buff_m1, _actor);
		}
		if (CheckTalentLevel(3))
		{
			_actor.buffComponent.AddBuff(11296311, _actor);
		}
		if (CheckTalentLevel(5) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, atk_nomal) && !_actor.buffComponent.CheckBuffByBuffID(buff_m5))
		{
			_actor.buffComponent.AddBuff(buff_m5, _actor);
		}
		if (GetPerk(personalPerkId_27) && adventureActorReceiveDamageEvent.to is MonsterAdventureActor monsterAdventureActor2 && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, daFenrHitTag))
		{
			if (perk27_Dic.TryGetValue(monsterAdventureActor2.Id, out var value))
			{
				if (GetCurrentCd(monsterAdventureActor2.Id) <= 0)
				{
					perk27_Dic.Remove(monsterAdventureActor2.Id);
					value = 0;
				}
				else
				{
					value++;
					perk27_Dic.set_Item(monsterAdventureActor2.Id, value);
				}
			}
			else
			{
				perk27_Dic.Add(monsterAdventureActor2.Id, 1);
				SetCurrentCd(monsterAdventureActor2.Id, cd_27);
			}
			if (value >= hitCount_27)
			{
				monsterAdventureActor2.buffComponent.AddBuff(buffId_27, _actor);
				perk27_Dic.Remove(monsterAdventureActor2.Id);
			}
		}
		if (GetPerk(perkId_st) && adventureActorReceiveDamageEvent.weapon != null && adventureActorReceiveDamageEvent.weapon is AdventureBullet adventureBullet && string.Equals(adventureBullet.bulletTag, fenrengTag) && adventureActorReceiveDamageEvent.to == _actor.attackTarget)
		{
			TSVector2 velocityDirection = adventureBullet.velocityDirection;
			ILRuntimeAPI.ShootByDirection("", _actor, default, TSVector2.Rotate(velocityDirection, 90));
			ILRuntimeAPI.ShootByDirection("", _actor, default, TSVector2.Rotate(velocityDirection, 90));
		}
	}

	private void OnReceiveDamageBeDeath(IEvent evt)
	{
		AdventureActorReceiveDamageCanCauseDeadEvent adventureActorReceiveDamageCanCauseDeadEvent = evt as AdventureActorReceiveDamageCanCauseDeadEvent;
		if (_actor != null && _actor.Id == adventureActorReceiveDamageCanCauseDeadEvent.from.Id && adventureActorReceiveDamageCanCauseDeadEvent.hitDamageTag != null)
		{
			if (CheckTalentLevel(4))
			{
				_actor.buffComponent.AddBuff(buff_m4, _actor);
			}
			if (GetPerk(personalPerkId_30) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageCanCauseDeadEvent.hitDamageTag, frHitTag))
			{
				SetCurrentCd(personalPerkId_30, cd_30);
				_skillManager.ModifyResumeTimeAbs(-CommonUtils.GetScriptValue(_actor, 11253001), ActionKey.B);
			}
			if (GetPerk(personalPerkId_41) && num_p41 < count_max_p41 && adventureActorReceiveDamageCanCauseDeadEvent.to is MonsterAdventureActor && CommonUtils.CheckHitByTag(adventureActorReceiveDamageCanCauseDeadEvent.hitDamageTag, UltraAtk))
			{
				num_p41++;
				_skillManager.AddEnergy(CommonUtils.GetScriptValue(_actor, 11254101));
			}
		}
	}

	public void OnTriggerWindBrust(AdventureActorReceiveDamageEvent damageEvt)
	{
		bool flag = false;
		if (damageEvt.from == _actor && damageEvt.to is MonsterAdventureActor monsterAdventureActor)
		{
			if (CommonUtils.CheckHitByTag(damageEvt.hitDamageTag, atk_nomal) && CanTriggerPerk(personalPerkId_3, out var _) && TSRandom.Range(0, 100) < CommonUtils.GetScriptValue(_actor, 11250302))
			{
				SetCurrentCd(personalPerkId_3, CommonUtils.GetScriptValue(_actor, 11250301));
				_skillManager.AddEnergy(CommonUtils.GetScriptValue(_actor, 11250303));
				ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_112_T3", monsterAdventureActor.tsTransform.Position, _actor.tsTransform.Rotation);
			}
			if (GetPerk(personalPerkId_28) && CommonUtils.CheckHitByTag(damageEvt.hitDamageTag, xFenrHitTag))
			{
				flag = true;
			}
			if (!flag && CommonUtils.CheckHitByTag(damageEvt.hitDamageTag, windBoomHit))
			{
				flag = true;
			}
			if (flag && checkWindMaskCanbeTrigger(monsterAdventureActor))
			{
				OnWindBrust(monsterAdventureActor);
				CommonUtils.TriggerElementMarkEvent(CommonDefine.WindMark1, HotfixEnum.AdventureActorElementTriggerType.WindElementTriggerType1, _actor, monsterAdventureActor, "WindMark_Trigger_Effect_04");
			}
		}
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		AdventureElementMarkTriggerEvent obj = evt as AdventureElementMarkTriggerEvent;
		AdventureActor triggerActor = obj.triggerActor;
		if (obj.elementTag == CommonDefine.WindMark1)
		{
			if (triggerActor != null && triggerActor.Id == _actor.Id && CheckTalentLevel(2))
			{
				_actor.buffComponent.AddBuff(buff_m2, _actor);
			}
			if (GetPerk(personalPerkId_31))
			{
				_actor.buffComponent.AddBuff(buff_31, _actor);
			}
		}
	}

	private void OnElementTriggerComplete(IEvent _evt)
	{
	}

	private TSVector2 GetAreaPos(TSVector2 _pos)
	{
		int num = TSRandom.Range(0, 360);
		return _pos + TSVector2.Rotate(TSVector2.one, num).normalized * windAearaPos_radius;
	}

	private void OnWindBrust(AdventureActor _monster)
	{
		string fxAlias = windAreaEffect_1;
		_monster.buffComponent.RemoveBuffByTag(CommonDefine.WindMark1);
		ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, GetAreaPos(_monster.tsTransform.Position), _actor.tsTransform.Rotation);
		if (!(_actor as PlayerAdventureActor).isAssist || !(SceneSingleton<AdventurePlayerController>.Instance != null) || !CanTriggerPerk(personalPerkId_33, out var _))
		{
			return;
		}
		SetCurrentCd(personalPerkId_33, perkId_33_CD);
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor != _actor && playerAdventureActor.isAssist)
			{
				playerAdventureActor.playerSkillCd.AddEnergy(CommonUtils.GetScriptValue(_actor, 11253301));
				break;
			}
		}
	}

	private bool checkWindMaskCanbeTrigger(AdventureActor target)
	{
		if (!CommonUtils.CheckTriggerElementMarkCD(_actor, target))
		{
			return false;
		}
		return CommonUtils.CheckElementMark(CommonDefine.WindMark1, target);
	}

	protected IEnumerator ResetSkill()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(waitTime_resetSkill));
		_skillManager?.BindSkillIdToButton(ActionKey.B, skillId_StageOne);
		_actor.logicVariable.ToggleLogicTag("FinishReset", value: false);
		ModuleController<AdventureModuleController>.Instance?.SetLevelLogicValue("112BeginReset", value: false);
	}

	public void OnUpdate()
	{
		if (_actor.logicVariable.GetLogicTagToggle("ChenShaZaDi") && GetPerk(personalPerkId_4))
		{
			_actor.logicVariable.ToggleLogicTag("ChenShaZaDi", value: false);
			_actor.logicVariable.ToggleLogicTag("ChenShaZaDi_Skill", value: true);
			SetCurrentCd(personalPerkId_4, perkId_4_CD);
			_actor.actorSearchTargetInfo.AddSearchRange(range_p4, ActorSearchTarget.SearchType.allRange);
			int currentBindSkillId = _skillManager.GetCurrentBindSkillId(ActionKey.Normal);
			MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintEnd", currentBindSkillId);
			MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintStart", currentBindSkillId, perkId_4_CD.AsFloat(), a3: true);
		}
		if (GetCurrentCd(personalPerkId_4) <= 0 && _actor.logicVariable.GetLogicTagToggle("ChenShaZaDi_Skill"))
		{
			_actor.logicVariable.ToggleLogicTag("ChenShaZaDi_Skill", value: false);
			_actor.actorSearchTargetInfo.ResetSearchRange(ActorSearchTarget.SearchType.allRange);
			int currentBindSkillId2 = _skillManager.GetCurrentBindSkillId(ActionKey.Normal);
			MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintEnd", currentBindSkillId2);
		}
		if (_actor.logicVariable.GetLogicTagToggle("UltraAtk_Clear"))
		{
			p9Normal_hitNum = 0;
			_actor.logicVariable.ToggleLogicTag("UltraAtk_Clear", value: false);
		}
		if (_actor.logicVariable.GetLogicTagToggle("p8_cdin"))
		{
			SetCurrentCd(personalPerkId_8, perkId_8_CD);
			_actor.logicVariable.ToggleLogicTag("p8_trigger", value: true);
			_actor.logicVariable.ToggleLogicTag("p8_cdin", value: false);
		}
		if (GetCurrentCd(personalPerkId_8) <= 0 && _actor.logicVariable.GetLogicTagToggle("p8_trigger"))
		{
			_actor.logicVariable.ToggleLogicTag("p8_trigger", value: false);
		}
		if (_actor.logicVariable.GetLogicTagToggle("m2_SkillAtkTag"))
		{
			_actor.logicVariable.ToggleLogicTag("m2_SkillAtkTag", value: false);
		}
		if (_actor.logicVariable.GetLogicTagToggle("BeginReset"))
		{
			_actor.logicVariable.ToggleLogicTag("BeginReset", value: false);
			StartCoroutine(ref _resetSkillNode, ResetSkill());
		}
		else if (_actor.logicVariable.GetLogicTagToggle("FinishReset"))
		{
			_actor.logicVariable.ToggleLogicTag("FinishReset", value: false);
			ModuleController<AdventureModuleController>.Instance?.SetLevelLogicValue("112BeginReset", value: false);
			StopCoroutine(ref _resetSkillNode);
		}
	}
}
