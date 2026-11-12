using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._10701;

public class Parallel : ParallelBase
{
	public const int buff_m1 = 10796111;

	private int buff_m2 = 10796211;

	public const int buff_m3 = 10796311;

	private int buff_m4 = 10796411;

	public const int buff_m5 = 10796511;

	private readonly int atk_nomal3 = CommonHelper.StringToHash("107_NormalAttack");

	private readonly int ultraDamageTag = CommonHelper.StringToHash("107_Ultra");

	private readonly int atk_backTag = CommonHelper.StringToHash("107_Main_Hurt");

	private readonly int atk_skillTag = CommonHelper.StringToHash("107_Main_Skill");

	private readonly int atk_sp_skillTag = CommonHelper.StringToHash("107_Support_Skill");

	public const string fx_jiedun = "fx_10701_base_Support_CatchShield";

	private const int buff_main_id = 10793014;

	private const int buff_sp_id = 10795012;

	private readonly int parameterId_Prop_m1 = 10798011;

	private const string area_m1 = "AreaEffect_107_Common_HeartStone_02";

	private readonly int parameterId_cd_m1 = 10798012;

	public const int perk_41 = 510741;

	private const int onceHitId_41 = 10741001;

	private const int buff_xuanYuan = 10741011;

	private static readonly int perk_42 = 510742;

	private const int shield_42 = 10742001;

	public static readonly int perk_43 = 510743;

	public const int buff_43 = 10743011;

	public const int perk_01 = 510701;

	public const string fx_01 = "fx_10701_loop_main_skill_p01_shield_strengthen";

	public const int perk_02 = 510702;

	public const int buff_02 = 10702011;

	public static readonly FP tiliaShieldDuration = 8;

	public static readonly FP tiliaShieldRotateSpeed = 45;

	public const int perk_03 = 510703;

	public const int perk_04 = 510704;

	public const string area_04 = "AreaEffect_107_Main_Skill_P04_LightDefenseDown";

	public const int perk_05 = 510705;

	public const int buff_05 = 10705011;

	public const int perk_06 = 510706;

	public const string area_06 = "AreaEffect_107_Main_Skill_P06_Boom";

	public const int perk_07 = 510707;

	private const int buff_07 = 10707011;

	public const int num_07 = 12;

	public const int perk_08 = 510708;

	public const int buff_08 = 10708011;

	private const int parameterId_08 = 10708011;

	public const int perk_09 = 510709;

	public const int buff_09 = 10709011;

	public const int perk_10 = 510710;

	public const string fx_10 = "fx_10701_base_Main_Skill_P10_Revive";

	public const int buff_10 = 10710011;

	private const int perk_11 = 510711;

	private const int buff_11 = 10711011;

	private const int perk_12 = 510712;

	private static readonly FP cd_12 = 10;

	private const int buff_12 = 10712011;

	private const int perk_13 = 510713;

	private readonly FP cd_13 = 1;

	private const int parameterId_13 = 10713011;

	private const int buff_13 = 10713011;

	private const int perk_21 = 510721;

	private const string area_21 = "AreaEffect_107_Support_Skill_P21_LightTag";

	private const int perk_22 = 510722;

	private const int parameterId_time_22 = 10722011;

	private const int parameterId_cout_22 = 10722012;

	public static readonly int perk_23 = 510723;

	private readonly string areaEffect_p23 = "AreaEffect_107_Support_Skill_P23_Boom";

	public static readonly int perk_24 = 510724;

	public const int cout_24 = 5;

	public static readonly FP forwardDis_24 = 1;

	public static readonly FP radius_out_24 = 10;

	public static readonly FP radius_in_24 = 1;

	public static readonly FP angle_24 = 260;

	private readonly int perk_25 = 510725;

	private readonly string areaEffect_p25 = "AreaEffect_107_Support_Skill_P25_Boom";

	private const int buff_25 = 10725011;

	private const int perk_26 = 510726;

	private const int buff_26 = 10726011;

	private readonly int perk_27 = 510727;

	private const int parameterId_CD_27 = 10727012;

	private const int parameterId_27 = 10727011;

	private const int buff_27 = 10727011;

	private readonly int perk_28 = 510728;

	private readonly FP cd_28 = 0;

	private const int buff_28 = 10728011;

	protected readonly int perk_29 = 510729;

	private const int buff_29 = 10729011;

	protected readonly int perk_30 = 510730;

	private readonly int parameterId_30 = 10730001;

	private readonly int parameterId_cd_30 = 10730012;

	protected readonly int perk_31 = 510731;

	private const int buff_31 = 10731011;

	protected readonly int perk_33 = 510733;

	private const int buff_33 = 10733011;

	public static int perkId_st = 9107999;

	public const string area_st = "AreaEffect_107_Support_Skill_Test_AllTag";

	public static int current_cout_22;

	public static int current_cout_07;

	private long m1CD_Id = 10700001L;

	public static Dictionary<long, long> dicArea_p21 = new Dictionary<long, long>(3);

	public static Dictionary<long, long> dicArea_st = new Dictionary<long, long>(3);

	private List<MonsterAdventureActor> _lists_p25 = new List<MonsterAdventureActor>(5);

	private List<MonsterAdventureActor> _lists_p25_later = new List<MonsterAdventureActor>(5);

	private FP hpPercent;

	private bool iAddPerk13;

	public static bool iAdd_p10;

	private FP scriptValue_08;

	private PlayFX fxP;

	private int count_7;

	public static bool dodgeSkill;

	public static bool mainSkill;

	public override void OnEnable()
	{
		base.OnEnable();
		iAddPerk13 = false;
		iAdd_p10 = false;
		count_7 = 0;
		if (GetPerk(510708))
		{
			scriptValue_08 = CommonUtils.GetScriptValue(_actor, 10708011);
		}
		if (GetPerk(510713))
		{
			hpPercent = CommonUtils.GetScriptValue(_actor, 10713011);
		}
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("TRIGGER_PERFECTDODGE", OnPrefectDodge);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("AREA_EFFECT_FINISH", OnAreaFinish);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("FLY_SHIELD_HIT", OnShieldHit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_PLAYER_ENTER", OnActorEnter);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		if (GetPerk(510710))
		{
			_actor.buffComponent.AddBuff(10710011, _actor);
		}
		if (GetPerk(perk_33))
		{
			PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
			if (activedPlayerActor != null && activedPlayerActor.actorHealthInfo.isAlive)
			{
				activedPlayerActor.buffComponent.AddBuff(10733011, _actor);
			}
		}
		if (!CheckTalentLevel(5))
		{
			return;
		}
		int num = 0;
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			if (SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).actorElementInfo.elementType == HotfixEnum.elementType.LE)
			{
				num++;
			}
		}
		if (num >= 3)
		{
			Singleton<BuffManager>.Instance.AddBufftoGroup(10796511, _actor);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		dicArea_st.Clear();
		dicArea_p21.Clear();
		_lists_p25.Clear();
		_lists_p25_later.Clear();
		fxP?.Stop();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRIGGER_PERFECTDODGE", OnPrefectDodge);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_FINISH", OnAreaFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("FLY_SHIELD_HIT", OnShieldHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_PLAYER_ENTER", OnActorEnter);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
	}

	private void OnCastSkill(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		if (_actor != null)
		{
			if (adventureActorCastSkillEvent.sender as AdventureActor == _actor && adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
			{
				count_7 = 0;
			}
			if (adventureActorCastSkillEvent.sender is PlayerAdventureActor { isAssist: false } playerAdventureActor && adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D && CheckTalentLevel(2))
			{
				playerAdventureActor.buffComponent.AddBuff(buff_m2, _actor);
			}
		}
	}

	private void OnActorEnter(IEvent _evt)
	{
		if (_evt is AdventurePlayerEnterEvent adventurePlayerEnterEvent && adventurePlayerEnterEvent.player == _actor && GetPerk(perk_31))
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor;
			if (playerAdventureActor != null)
			{
				playerAdventureActor.buffComponent.AddBuff(10731011, _actor);
			}
		}
	}

	private void OnPrefectDodge(IEvent evt)
	{
		_ = (evt as AdventurePerfectDodgeTrigger).actor == _actor;
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		if ((evt as AdventureElementMarkTriggerEvent).elementType != HotfixEnum.elementType.LE)
		{
			return;
		}
		if (GetPerk(perk_27, CommonUtils.GetScriptValue(_actor, 10727012)))
		{
			(_actor as PlayerAdventureActor).playerSkillCd.AddEnergy(CommonUtils.GetScriptValue(_actor, 10727011));
			Singleton<BuffManager>.Instance.AddBufftoGroup(10727011, _actor);
		}
		if (CheckTalentLevel(4))
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor;
			if (playerAdventureActor != null)
			{
				playerAdventureActor.buffComponent.AddBuff(buff_m4, _actor);
			}
		}
	}

	private void OnBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (_actor == null || adventureActorReceiveDamageBeforeHitEvent.to == null || adventureActorReceiveDamageBeforeHitEvent.hitDamageTag == null || _actor.Id != adventureActorReceiveDamageBeforeHitEvent.from?.Id || !CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, ultraDamageTag))
		{
			return;
		}
		if (GetPerk(510741) && adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor monsterAdventureActor)
		{
			monsterAdventureActor.buffComponent.AddBuff(10741011, _actor);
			AdventureActor.AddFromAttr(10741001, _actor);
		}
		if (GetPerk(perk_42))
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor;
			if (playerAdventureActor != null)
			{
				playerAdventureActor.actorShield.AddShield(10742001, _actor);
			}
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (_actor != null && _actor.Id == adventureActorReceiveDamageEvent.from.Id && adventureActorReceiveDamageEvent.to is MonsterAdventureActor monsterAdventureActor)
		{
			if ((monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE || monsterAdventureActor.IsBossMonster()) && GetPerk(510712, cd_12))
			{
				Singleton<BuffManager>.Instance?.AddBufftoGroup(10712011, _actor);
			}
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, atk_nomal3) && GetPerk(510707) && count_7 < 12)
			{
				Singleton<BuffManager>.Instance?.AddBufftoGroup(10707011, _actor);
				count_7++;
			}
			if (GetPerk(510708) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, atk_skillTag) && CheckProbability(scriptValue_08))
			{
				Singleton<BuffManager>.Instance?.AddBufftoGroup(10708011, _actor);
			}
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, atk_skillTag))
			{
				Singleton<BuffManager>.Instance.AddBufftoGroup(10793014, _actor);
			}
			else if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, atk_sp_skillTag))
			{
				Singleton<BuffManager>.Instance.AddBufftoGroup(10795012, _actor);
			}
		}
		if (adventureActorReceiveDamageEvent.from is PlayerAdventureActor playerAdventureActor && IsTeamMember(playerAdventureActor) && adventureActorReceiveDamageEvent.to is MonsterAdventureActor target && CommonUtils.CheckElementMark(CommonDefine.Light, target) && CheckTalentLevel(1))
		{
			playerAdventureActor.buffComponent.AddBuff(10796111, _actor);
		}
	}

	protected void OnRemoveBuff(IEvent evt)
	{
		AdventureActorRemoveBuff adventureActorRemoveBuff = evt as AdventureActorRemoveBuff;
		if (adventureActorRemoveBuff.froms.Count > 0 && adventureActorRemoveBuff.eventInfo != null)
		{
			_ = adventureActorRemoveBuff.eventInfo.buffTags;
		}
	}

	private void OnGetBuff(IEvent evt)
	{
		AdventureActorGetBuff adventureActorGetBuff = evt as AdventureActorGetBuff;
		if (adventureActorGetBuff.from != _actor || !adventureActorGetBuff.eventInfo.buffTags.Contains(CommonDefine.LightMark1))
		{
			return;
		}
		if (adventureActorGetBuff.sender is MonsterAdventureActor monsterAdventureActor)
		{
			if (GetPerk(510726))
			{
				monsterAdventureActor.buffComponent.AddBuff(10726011, _actor);
			}
			if (GetPerk(510711))
			{
				monsterAdventureActor.buffComponent.AddBuff(10711011, _actor);
			}
		}
		if (CheckTalentLevel(3))
		{
			Singleton<BuffManager>.Instance.AddBufftoGroup(10796311, _actor);
		}
	}

	protected void OnShieldHit(IEvent evt)
	{
		FlyShieldHitEvent flyShieldHitEvent = evt as FlyShieldHitEvent;
		if (flyShieldHitEvent.owner != _actor || flyShieldHitEvent.target == null)
		{
			return;
		}
		if (flyShieldHitEvent.target is MonsterAdventureActor monsterAdventureActor)
		{
			if (GetPerk(510721) && !dicArea_p21.ContainsKey(monsterAdventureActor.Id))
			{
				dicArea_p21.Add(monsterAdventureActor.Id, ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_107_Support_Skill_P21_LightTag", monsterAdventureActor.tsTransform.Position));
			}
			if (GetPerk(510722) && current_cout_22 < (int)(long)CommonUtils.GetScriptValue(_actor, 10722012))
			{
				current_cout_22++;
				(_actor as PlayerAdventureActor).playerSkillCd.ModifyResumeTimeAbs(-CommonUtils.GetScriptValue(_actor, 10722011), ActionKey.B);
			}
			if (GetPerk(perk_25))
			{
				_lists_p25.Add(monsterAdventureActor);
			}
			if (GetPerk(perk_30) && (FP)monsterAdventureActor.actorHealthInfo.hpPercentage * 100 < CommonUtils.GetScriptValue(_actor, parameterId_30) && CheckPerkCd(perk_30, CommonUtils.GetScriptValue(_actor, parameterId_cd_30)))
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_p23, monsterAdventureActor.tsTransform.Position);
			}
			if (GetPerk(perkId_st) && !dicArea_st.ContainsKey(monsterAdventureActor.Id))
			{
				dicArea_st.Add(monsterAdventureActor.Id, ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_107_Support_Skill_Test_AllTag", monsterAdventureActor.tsTransform.Position));
			}
		}
		else if (SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor != null && flyShieldHitEvent.target.Id == SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.Id)
		{
			LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
			ILRuntimeAPI.PlayFX(ref fxP, _actor, "fx_10701_base_Support_CatchShield", 1f, activedPlayerActor.transform, Vector3.zero, Vector3.zero);
			if (GetPerk(perk_23))
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_p23, flyShieldHitEvent.target.tsTransform.Position);
			}
			if (GetPerk(perk_28, cd_28))
			{
				SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.buffComponent.AddBuff(10728011, _actor);
			}
		}
		if (!GetPerk(perk_29) || flyShieldHitEvent.reboundTime <= 0)
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (!playerAdventureActor.isDead)
			{
				playerAdventureActor.buffComponent.AddBuff(10729011, _actor);
			}
		}
	}

	private void OnAreaFinish(IEvent evt)
	{
		AdventureAreaEffectFinishEvent adventureAreaEffectFinishEvent = evt as AdventureAreaEffectFinishEvent;
		if (adventureAreaEffectFinishEvent.owner == null || adventureAreaEffectFinishEvent.owner.Id != _actor.Id || !(adventureAreaEffectFinishEvent.sender is AreaEffectEntity areaEffectEntity))
		{
			return;
		}
		if (GetPerk(510721))
		{
			long num = 0L;
			foreach (long key in dicArea_p21.Keys)
			{
				if (dicArea_p21.get_Item(key) == areaEffectEntity.Id)
				{
					num = key;
					break;
				}
			}
			if (num > 0)
			{
				dicArea_p21.Remove(num);
			}
		}
		if (!GetPerk(perkId_st))
		{
			return;
		}
		long num2 = 0L;
		foreach (long key2 in dicArea_st.Keys)
		{
			if (dicArea_st.get_Item(key2) == areaEffectEntity.Id)
			{
				num2 = key2;
				break;
			}
		}
		if (num2 > 0)
		{
			dicArea_st.Remove(num2);
		}
	}

	public void OnUpdate()
	{
		if (GetPerk(510713))
		{
			if (!iAddPerk13 && CheckPerkCd(510713L, cd_13) && (FP)_actor.actorHealthInfo.hpPercentage < hpPercent)
			{
				iAddPerk13 = true;
				_actor.buffComponent.AddBuff(10713011, _actor);
			}
			else if (iAddPerk13 && (FP)_actor.actorHealthInfo.hpPercentage >= hpPercent)
			{
				iAddPerk13 = false;
				_actor.buffComponent.RemoveBuffByBuffId(10713011);
			}
		}
		if (!GetPerk(perk_25))
		{
			return;
		}
		for (int i = 0; i < _lists_p25_later.Count; i++)
		{
			if (_lists_p25_later.get_Item(i).actorHealthInfo.isAlive && (!_lists_p25_later.get_Item(i).isStrongStun || _lists_p25_later.get_Item(i).isStunWeakened))
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_p25, _lists_p25_later.get_Item(i).tsTransform.Position);
				_lists_p25_later.get_Item(i).buffComponent.AddBuff(10725011, _actor);
			}
		}
		_lists_p25_later.Clear();
		for (int j = 0; j < _lists_p25.Count; j++)
		{
			if (!_lists_p25.get_Item(j).IsCanNotBeHit)
			{
				_lists_p25_later.Add(_lists_p25.get_Item(j));
			}
		}
		_lists_p25.Clear();
	}
}
