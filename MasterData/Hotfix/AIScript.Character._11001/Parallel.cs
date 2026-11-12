using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11001;

public class Parallel : ParallelBase
{
	private readonly int darkBoomHit = CommonHelper.StringToHash("110DarkTagBoom");

	private const int damageId_dark = 110000000;

	private const string darkHit_Fx = "FX/ActorCommon/fx_common_base_DarkTirgger_AnZhuo";

	private const int buff_dark = 11090000;

	private const int avatarId_A = 11000001;

	private const int avatarId_B = 11000002;

	private const int avatarId_A_Skin_1 = 11000003;

	private const int avatarId_B_Skin_1 = 11000004;

	private readonly int scriptPam_fsLeftTime = 11000012;

	private readonly int scriptPam_fsmaxCount = 11000011;

	private readonly int nrmalAtkTag = CommonHelper.StringToHash("110_Atk");

	private readonly int nrmalAtk5Tag = CommonHelper.StringToHash("110_Atk5");

	private readonly int skillMainTag = CommonHelper.StringToHash("110MainSanDuanZhanAtk");

	public static readonly FP fsInnerR = 2;

	public static readonly FP fsOutsiseR = 2;

	private const string fx_fsBorn = "fx_11001_bullet_FenShen_BirthBullt";

	private const float fx_Speed = 10f;

	private const string tipsKey_TriggerMark = "DarkMark_Trigger_Effect_03";

	private readonly int buff_m1 = 11096111;

	private readonly int buff_m1_sum = 11096121;

	private readonly int buff_m2 = 11096211;

	private readonly int buff_m2_sum = 11096221;

	private readonly int buff_m3 = 11096311;

	private readonly int buff_m3_sum = 11096321;

	private readonly int buff_m4 = 11096411;

	private readonly int buff_m5 = 11096511;

	private static readonly int ultral_atkTag = CommonHelper.StringToHash("110UltraAtk");

	public const int perk_41 = 511041;

	public const string fx_41 = "fx_11001_bullet_T41_EnergyAbsorb";

	public const float fxSpeed_41 = 5f;

	public const int buff_41 = 11054111;

	private const int perk_42 = 511042;

	private const int buff_42 = 11042011;

	public const int perk_43 = 511043;

	public const int buff_43 = 11043011;

	public const int perk_01 = 511001;

	private const int perk_02 = 511002;

	private const int hitCount_02 = 6;

	private const int buff_02 = 11002011;

	private readonly FP cd_02 = 0.5;

	private readonly FP hit_radius = 4;

	private readonly int hit_damageID = 110300002;

	private readonly string fx_hit_02 = "fx_11001_hit_atk";

	public const int perk_03 = 511003;

	private static readonly FP cd_03 = 5;

	public const int scriptPam_num_03 = 11030011;

	public const int perk_04 = 511004;

	public const string area_04 = "AreaEffect_110_Main_FenShen_DieBoom";

	private const int scriptPam_num_04 = 11040011;

	private const int perk_05 = 511005;

	private const int scriptPamPro1 = 11005011;

	private const int scriptPamPro2 = 11005012;

	private const string fx_05 = "Actor/Character/11001/Fx/fx_11001_base_T5_DaoGuang";

	private const int damageID_05 = 110300003;

	private readonly int scriptPamCd_05 = 11005013;

	private readonly int scriptPamCount_05 = 11005014;

	private const int perk_06 = 511006;

	private const int buff_06 = 11050611;

	public const int perk_07 = 511007;

	public const int buff_07 = 11050711;

	private const int perk_08 = 511008;

	private const int scriptPam_num_08 = 11080011;

	private const int buff_08 = 11050811;

	private const int perk_09 = 511009;

	private const int parameterId_09 = 11050901;

	private const int buff_09 = 11050911;

	public const int perk_10 = 511010;

	private const int buff_10 = 11051011;

	private const int perk_11 = 511011;

	private const int buff_11 = 11051111;

	public const int perk_12 = 511012;

	private const int buff_12 = 11051211;

	public const int perk_13 = 511013;

	private const int add_num = 1;

	public const int buff_13 = 11051311;

	public const int perk_21 = 511021;

	public static readonly FP addTime_21 = 3;

	public const string area_21 = "Actor/Character/11001/Weapons/AreaEffect_110_Support_QuanZhang_LoopAOE";

	private const int perk_22 = 511022;

	private static readonly int leftAreaTag = CommonHelper.StringToHash("110_Support_QuanZhang");

	private const string area_boom = "Actor/Character/11001/Weapons/AreaEffect_110_Support_QuanZhang_Boom";

	public const int perk_23 = 511023;

	public const int addNum_23 = 2;

	private const int scriptPam_num_23 = 11230011;

	public const int perk_24 = 511024;

	public const int addTime_24 = 5;

	private const int perk_25 = 511025;

	private const int parameterIdTriggerCount = 11052512;

	private static readonly int skillB_tag = CommonHelper.StringToHash("110SupportQuanZhangAtk");

	private const int parameterId_25 = 11052511;

	private const int onceId_25 = 11052501;

	private const int perk_26 = 511026;

	private const int attri_26 = 11052601;

	private const int perk_27 = 511027;

	private const int buff_27 = 11052711;

	public const int perk_29 = 511029;

	public const string area_29 = "AreaEffect_110_Support_FenShen_DieBoom";

	private const int perk_31 = 511031;

	private const int buff_31 = 11053111;

	private const int perk_33 = 511033;

	private const int buff_33 = 11053311;

	public static List<LogicEntity> fsEntitys = new List<LogicEntity>(5);

	private FP cd_03_Ct;

	private FP cd_11_Ct;

	public static List<long> areaLeftId = new List<long>();

	public static List<long> areaBoomId = new List<long>();

	public static FP normalComboTime;

	private CommomAreaHitConfig _areaHitConfig;

	private FP current_cd_02;

	private int triggerCount_05;

	private int triggerCount_25;

	private bool de_All;

	private int mainSkillHitCount;

	private int deCount;

	public override void OnEnable()
	{
		base.OnEnable();
		normalComboTime = 0;
		current_cd_02 = 0;
		triggerCount_05 = 0;
		triggerCount_25 = 0;
		mainSkillHitCount = 0;
		deCount = 0;
		areaLeftId.Clear();
		areaBoomId.Clear();
		if (GetPerk(511003))
		{
			cd_03_Ct = cd_03;
		}
		if (GetPerk(511013))
		{
			PlayerSkillCd playerSkillCd = (_actor as PlayerAdventureActor).playerSkillCd;
			SkillInfo skillCD = playerSkillCd.GetSkillCD(ActionKey.A);
			playerSkillCd.SetSkillTotalSection(ActionKey.A, skillCD.totalSectionAmount + 1, forceMaxSection: true);
		}
		de_All = true;
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.DE)
			{
				deCount++;
				if (GetPerk(511033))
				{
					playerAdventureActor.buffComponent.AddBuff(11053311, _actor);
				}
				if (GetPerk(511011))
				{
					_actor.buffComponent.AddBuff(11051111, _actor);
				}
			}
			else
			{
				de_All = false;
			}
		}
		if (de_All && CheckTalentLevel(5))
		{
			_actor.buffComponent.AddBuff(buff_m5, _actor);
		}
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("TRIGGER_PERFECTDODGE", OnTriggerPerfectDodge);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		fsEntitys.Clear();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRIGGER_PERFECTDODGE", OnTriggerPerfectDodge);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
	}

	private void OnAreaEffectFinish(IEvent evt)
	{
		AdventureAreaEffectFinishEvent adventureAreaEffectFinishEvent = evt as AdventureAreaEffectFinishEvent;
		if (!(_actor != null) || adventureAreaEffectFinishEvent.owner.Id != _actor.Id || !(adventureAreaEffectFinishEvent.sender is AreaEffectEntity areaEffectEntity))
		{
			return;
		}
		if (GetPerk(511022) && areaEffectEntity.CheckTag(leftAreaTag))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "Actor/Character/11001/Weapons/AreaEffect_110_Support_QuanZhang_Boom", areaEffectEntity.tsTransform.Position);
		}
		if (areaLeftId.Contains(areaEffectEntity.Id))
		{
			int num = areaLeftId.IndexOf(areaEffectEntity.Id);
			if (areaBoomId.Count > num)
			{
				ILRuntimeAPI.StopAreaEffect(areaBoomId.get_Item(num));
				areaBoomId.RemoveAt(num);
			}
			areaLeftId.RemoveAt(num);
		}
	}

	private void OnCastSkill(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		PlayerAdventureActor playerAdventureActor = adventureActorCastSkillEvent.sender as PlayerAdventureActor;
		if (!(playerAdventureActor == null) && _actor.Id == playerAdventureActor.Id && adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			if (CheckTalentLevel(3))
			{
				_actor.buffComponent.AddBuff(buff_m3, _actor);
				AddBuffToSumon(buff_m3_sum);
			}
			triggerCount_25 = 0;
		}
	}

	private void OnGetBuff(IEvent evt)
	{
		AdventureActorGetBuff adventureActorGetBuff = evt as AdventureActorGetBuff;
		if (adventureActorGetBuff.sender is MonsterAdventureActor && adventureActorGetBuff.eventInfo.buffTags.Contains(CommonDefine.Dark) && CheckTalentLevel(4))
		{
			_actor.buffComponent.AddBuff(buff_m4, _actor);
		}
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
	}

	protected void OnTriggerPerfectDodge(IEvent evt)
	{
		_ = (evt as AdventurePerfectDodgeTrigger).actor != _actor;
	}

	private void OnBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (_actor == null || adventureActorReceiveDamageBeforeHitEvent.to == null || adventureActorReceiveDamageBeforeHitEvent.hitDamageTag == null)
		{
			return;
		}
		MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageBeforeHitEvent.to as MonsterAdventureActor;
		if (monsterAdventureActor != null)
		{
			if (GetPerk(511025) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, skillB_tag))
			{
				AdventureActor.AddFromAttr(11052501, _actor);
			}
			if (GetPerk(511026) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, skillB_tag) && monsterAdventureActor.buffComponent.CheckBuffByBuffID(11090000))
			{
				AdventureActor.AddFromAttr(11052601, _actor);
			}
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (_actor != null && _actor.Id == adventureActorReceiveDamageEvent.from.Id && adventureActorReceiveDamageEvent.to is MonsterAdventureActor monsterAdventureActor && adventureActorReceiveDamageEvent.hitDamageTag != null)
		{
			if (GetPerk(511042))
			{
				_actor.buffComponent?.AddBuff(11042011, _actor);
			}
			if (GetPerk(511002) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, skillMainTag))
			{
				mainSkillHitCount++;
				if (mainSkillHitCount >= 6)
				{
					mainSkillHitCount = 0;
					_actor.buffComponent?.AddBuff(11002011, _actor);
				}
			}
			if (GetPerk(511005) && adventureActorReceiveDamageEvent.damageType == HotfixEnum.damageType.SKILL && TSRandom.Range(0, 100) < (de_All ? CommonUtils.GetScriptValue(_actor, 11005012) : CommonUtils.GetScriptValue(_actor, 11005011)))
			{
				triggerCount_05++;
				int num = (int)(long)CommonUtils.GetScriptValue(_actor, scriptPamCount_05);
				if (triggerCount_05 >= num && CheckPerkCd(511005L, CommonUtils.GetScriptValue(_actor, scriptPamCd_05)))
				{
					triggerCount_05 = 0;
				}
				if (triggerCount_05 < num)
				{
					ILRuntimeAPI.HitActor(_actor, monsterAdventureActor, 110300003, "Actor/Character/11001/Fx/fx_11001_base_T5_DaoGuang");
				}
			}
			if (GetPerk(511007) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, nrmalAtkTag))
			{
				_actor.buffComponent.AddBuff(11050711, _actor);
			}
			if (GetPerk(511027) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, skillB_tag))
			{
				_actor.buffComponent.AddBuff(11052711, _actor);
			}
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, darkBoomHit))
			{
				OnDarkHit(monsterAdventureActor, adventureActorReceiveDamageEvent.hitDamageTag);
			}
		}
		else
		{
			if (fsEntitys.Count <= 0 || !(adventureActorReceiveDamageEvent.to is MonsterAdventureActor monster) || adventureActorReceiveDamageEvent.hitDamageTag == null)
			{
				return;
			}
			for (int i = 0; i < fsEntitys.Count; i++)
			{
				if (fsEntitys.get_Item(i).Id == adventureActorReceiveDamageEvent.from.Id)
				{
					if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, darkBoomHit))
					{
						OnDarkHit(monster, adventureActorReceiveDamageEvent.hitDamageTag);
					}
					break;
				}
			}
		}
	}

	private void OnDarkHit(AdventureActor _monster, IList<int> hitDamageTag)
	{
		if (!(_monster == null) && CommonUtils.CheckElementMark(CommonDefine.Dark, _monster) && CommonUtils.CheckTriggerElementMarkCD(_actor, _monster))
		{
			if (CheckTalentLevel(1))
			{
				_actor.buffComponent.AddBuff(buff_m1, _actor);
				AddBuffToSumon(buff_m1_sum);
			}
			if (GetPerk(511006))
			{
				_actor.buffComponent.AddBuff(11050611, _actor);
			}
			if (GetPerk(511043))
			{
				_actor.buffComponent.AddBuff(11043011, _actor);
			}
			if (CommonUtils.CheckHitByTag(hitDamageTag, skillB_tag) && GetPerk(511025) && triggerCount_25 < (int)(long)CommonUtils.GetScriptValue(_actor, 11052512))
			{
				triggerCount_25++;
				(_actor as PlayerAdventureActor).playerSkillCd.ModifyResumeTimeAbs(-CommonUtils.GetScriptValue(_actor, 11052511), ActionKey.B);
			}
			_monster.buffComponent.RemoveBuffByTag(CommonDefine.Dark);
			ILRuntimeAPI.HitActor(_actor, _monster, 110000000, null, "FX/ActorCommon/fx_common_base_DarkTirgger_AnZhuo", attackFxPlayOnTarget: true);
			_monster.buffComponent.AddBuff(11090000, _actor);
			CommonUtils.TriggerElementMarkEvent(CommonDefine.Dark, HotfixEnum.AdventureActorElementTriggerType.DarkElementTriggerType1, _actor, _monster, "DarkMark_Trigger_Effect_03");
		}
	}

	private void AddBuffToSumon(int buffid)
	{
		List<LogicEntity> list = fsEntitys;
		if (list != null && list.Count > 0)
		{
			for (int i = 0; i < fsEntitys.Count; i++)
			{
				(fsEntitys.get_Item(i) as AdventureActor).buffComponent?.AddBuff(buffid, _actor);
			}
		}
	}

	private int GetSummonid(bool isAssist)
	{
		if (_actor.skinID == 11003)
		{
			if (!isAssist)
			{
				return 11000003;
			}
			return 11000004;
		}
		if (!isAssist)
		{
			return 11000001;
		}
		return 11000002;
	}

	private void OnSummonAvatar()
	{
		SummonCfg summonCfg = new SummonCfg();
		summonCfg.summonFollowType = SummonFollowType.NotFollow;
		summonCfg.summonAttrType = SummonAttrType.InheritByInitialSnapshot;
		summonCfg.summonRelation = SummonRelation.Coexisted;
		summonCfg.attrPercent = 100;
		FP scriptValue = CommonUtils.GetScriptValue(_actor, scriptPam_fsLeftTime);
		bool isAssist = (_actor as PlayerAdventureActor).isAssist;
		if (GetPerk(511009))
		{
			scriptValue += CommonUtils.GetScriptValue(_actor, 11050901);
		}
		if (GetPerk(511024))
		{
			scriptValue += (FP)5;
		}
		summonCfg.leftTime = scriptValue;
		TSVector2 pos = _actor.RandomActorReachablePointInsideRing(_actor.tsTransform.Position, fsInnerR, fsOutsiseR);
		ILRuntimeAPI.SummonMonster(_actor, 0, GetSummonid(isAssist), pos, _actor.tsTransform.Forward, summonCfg, null, (MonsterAdventureActor monster) =>
		{
			if (GetPerk(511008))
			{
				monster.buffComponent.AddBuff(11050811, _actor);
			}
			if (GetPerk(511009))
			{
				monster.buffComponent.AddBuff(11050911, _actor);
			}
			if (GetPerk(511010))
			{
				monster.buffComponent.AddBuff(11051011, _actor);
			}
			if (GetPerk(511012))
			{
				monster.buffComponent.AddBuff(11051211, _actor);
			}
			if (GetPerk(511031))
			{
				monster.buffComponent.AddBuff(11053111, _actor);
			}
			FP logicTagValue = _actor.logicVariable.GetLogicTagValue("110_skill");
			if (logicTagValue > 0)
			{
				monster.logicVariable.SetLogicTagValue("110_skill", logicTagValue);
			}
			if (fsEntitys.Count >= GetFsMaxCount() && fsEntitys.Count > 0)
			{
				(fsEntitys.get_Item(0) as AdventureActor).DestroySelf();
				fsEntitys.RemoveAt(0);
			}
			_actor.PlayMovableFx("fx_11001_bullet_FenShen_BirthBullt", _actor.transform.position, monster.transform.position, 10f);
			fsEntitys.Add(monster);
			if (CheckTalentLevel(2))
			{
				_actor.buffComponent.AddBuff(buff_m2, _actor);
				AddBuffToSumon(buff_m2_sum);
			}
		});
	}

	private int GetFsMaxCount()
	{
		int num = (int)(long)CommonUtils.GetScriptValue(_actor, scriptPam_fsmaxCount);
		if (GetPerk(511004) && deCount - 1 > 0)
		{
			num += (deCount - 1) * (int)(long)CommonUtils.GetScriptValue(_actor, 11040011);
		}
		if (GetPerk(511008))
		{
			num += (int)(long)CommonUtils.GetScriptValue(_actor, 11080011);
		}
		if (GetPerk(511023))
		{
			num += (int)(long)CommonUtils.GetScriptValue(_actor, 11230011);
		}
		return num;
	}

	public void OnUpdate()
	{
		if (GetPerk(511002))
		{
			current_cd_02 -= _actor.LogicDeltaTime;
			if (current_cd_02 <= 0 && _actor.buffComponent.CheckBuffByBuffID(11002011))
			{
				current_cd_02 = cd_02;
				if (_areaHitConfig == null)
				{
					_areaHitConfig = new CommomAreaHitConfig
					{
						damageImmuneDuration = -1,
						hitDamageId = hit_damageID,
						hittedEffectAlias = fx_hit_02
					};
				}
				_areaHitConfig.position = _actor.tsTransform.Position;
				ILRuntimeAPI.CircleAreaHit(_actor, _areaHitConfig, hit_radius, 0);
			}
		}
		FP logicTagValue = _actor.logicVariable.GetLogicTagValue("fenSheng");
		if (logicTagValue > 0)
		{
			_actor.logicVariable.SetLogicTagValue("fenSheng", 0);
			for (int i = 0; i < logicTagValue; i++)
			{
				OnSummonAvatar();
			}
		}
		if (fsEntitys.Count > 0)
		{
			for (int num = fsEntitys.Count - 1; num > -1; num--)
			{
				if (fsEntitys.get_Item(num).IsDead())
				{
					fsEntitys.RemoveAt(num);
				}
			}
		}
		if (cd_03_Ct > 0)
		{
			cd_03_Ct -= _actor.LogicDeltaTime;
			if (cd_03_Ct <= 0)
			{
				_actor.logicVariable.SetLogicTagValue("110_skill", 0);
				OnSummonAvatar();
				cd_03_Ct = cd_03;
			}
		}
		if (cd_11_Ct > 0)
		{
			cd_11_Ct -= _actor.LogicDeltaTime;
			if (cd_11_Ct <= 0)
			{
				_actor.logicVariable.SetLogicTagValue("110_skill", 1);
				AdventurActorNormalEvent adventurActorNormalEvent = AdventurActorNormalEvent.Generate();
				adventurActorNormalEvent.sender = _actor;
				adventurActorNormalEvent.stateID = 1;
				adventurActorNormalEvent.enventTag = "fsSkill";
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventurActorNormalEvent);
			}
		}
	}
}
