#define LOG_DEBUG
using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12001;

public class Parallel : ParallelBase
{
	private int onceId_m1 = 12096111;

	private int buff_m2 = 12096211;

	private int buff_m3 = 12096311;

	private int buff_m4 = 12096411;

	private int onceId_m5 = 12096511;

	private const int buff_wind = 2011;

	private static readonly int windBoomHit = CommonHelper.StringToHash("120WindTagBoom");

	private readonly string windAreaEffect = "AreaEffect_120_WindMark1_Bloom";

	private const string tipsKey_TriggerMark = "WindMark_Trigger_Effect_01";

	private static readonly int Skill_MainHitTag = CommonHelper.StringToHash("120_B1");

	private static readonly int Skill_SupportHitTag = CommonHelper.StringToHash("120_B2");

	private readonly string MainSkill_Bullet_Tag = "120_B1_Garland";

	private readonly string SupportSkill_Bullet_Tag = "120_B2_Corolla";

	private static readonly int NormalHitTag = CommonHelper.StringToHash("120_NrmAtk");

	private static readonly int UltraHitTag = CommonHelper.StringToHash("120_UltraHitTag");

	public const int buff_WindPower_Id = 12004011;

	private static readonly int windAreaTag = CommonHelper.StringToHash("120_WindTag");

	private readonly string Support_fly__Bullet_Tag = "120_B2_Projectile";

	public const int perk_41 = 512041;

	private const int perk_42 = 512042;

	private const int buffId_42 = 12042011;

	public const int perk_43 = 512043;

	public const int buffId_43 = 12043011;

	public const int perk_01 = 512001;

	public const string bullet_01 = "Bullet_12001_B1_Skill_Garland_Mid";

	public const string bullet_01_p7 = "Bullet_12001_B1P7_Skill_Garland_BigMid";

	private const int perk_02 = 512002;

	private const int onceId_02 = 12050211;

	private readonly FP rotSpeed_02 = 300;

	private const int perk_03 = 512003;

	private const int buff_03 = 12003011;

	private const int prop_03 = 20;

	private readonly FP delay_time = 0.1f;

	private const int perk_04 = 512004;

	private const int num_04_01 = 5;

	private const int num_04_02 = 3;

	private const int num_max = 5;

	private const int onceId_04 = 12050411;

	private static readonly int NormalHitTag_04 = CommonHelper.StringToHash("120_NrmAtkStrength");

	private const int perk_05 = 512005;

	private const int buffId_05 = 12005011;

	public const int perk_06 = 512006;

	private readonly FP range_06 = 5.5;

	private readonly FP range_06_01 = 7.5;

	private const int buff_06 = 12006012;

	public const int perk_07 = 512007;

	private const int onceId_07 = 12050701;

	public const int perk_08 = 512008;

	public const int buffId_08 = 12008011;

	private const int perk_09 = 512009;

	private const int onceId_09 = 12050901;

	private const int perk_10 = 512010;

	private const int parameterId_cd_10 = 12051011;

	private const int onceId_10 = 12051001;

	private const int perk_11 = 512011;

	private const int buffId_11 = 12011011;

	private const int perk_12 = 512012;

	private const int buffId_12 = 12012011;

	private const int parameterId_12 = 12051211;

	public const int perk_13 = 512013;

	public const int buffId_13 = 12013011;

	private const int num_13 = 1;

	private readonly string bullet_normal = "Bullet_12001_B2_Skill_Corolla";

	private readonly string bullet_normal_p22 = "Bullet_12001_B2P22_Skill_Corolla";

	public const int perk_21 = 512021;

	private readonly int onceId_21 = 12052111;

	public const string bullet_21 = "Bullet_12001_B2P21_Skill_Corolla_Strength";

	public const string bullet_21_p22 = "Bullet_12001_B2P21P22_Skill_Corolla_Strength";

	private const int perk_22 = 512022;

	private const int onceId_22 = 12052211;

	private readonly FP scale_22 = 1.3;

	public const int perk_23 = 512023;

	private readonly FP rotSpeed_23 = -360;

	private const int onceId_23 = 12052311;

	private static readonly int hitTag_23 = CommonHelper.StringToHash("120_B2_Skill");

	public const int perk_24 = 512024;

	public const string event_24 = "120_B2P24";

	public const string bullet_24 = "Bullet_12001_B2P24_Wreath";

	public const string bullet_24_23 = "Bullet_12001_B2P24P23_Wreath";

	private const string area_24 = "AreaEffect_12001_B2P24_Wreath";

	private const int perk_25 = 512025;

	private const int buffId_25 = 12025011;

	private const int perk_26 = 512026;

	private const int onceId_26 = 12052601;

	private const int strengh_26 = 4;

	private readonly int perk_27 = 512027;

	private const int onceId_27 = 12052701;

	private const int buffId_27 = 12027011;

	private readonly int perk_28 = 512028;

	private readonly FP cd_28 = 1f;

	private const int onceId_28 = 12052801;

	private readonly int perk_29 = 512029;

	private const int onceId_29 = 12052901;

	private const int perk_30 = 512030;

	private const int buffId_30 = 12030011;

	private readonly int perk_31 = 512031;

	private const int onceId_31 = 12053101;

	public const int perk_33 = 512033;

	public static readonly FP time_33 = 0;

	private const int buffId_33 = 12033011;

	private Dictionary<long, int> _b2t4AttackHitCount = new Dictionary<long, int>();

	private int mainWeapCount;

	private int normalHit_10;

	private int huaWeaponCount;

	public static bool normalBulletCopy;

	private int powerNum;

	public static AdventureRotateWeapon bigSupportWeapon;

	public static int bigSupWeaponRotateIndex;

	private FP pro_12;

	public static bool dodgeSkill;

	public static bool ultraSkill;

	public static bool normalSkill;

	public static bool mainSkill;

	private readonly Dictionary<FP, AdventureBullet> delayBullets = new Dictionary<FP, AdventureBullet>(10);

	private readonly Dictionary<FP, TSVector2> delayBulletPos = new Dictionary<FP, TSVector2>(10);

	private readonly Dictionary<FP, TSVector2> delayBulletDir = new Dictionary<FP, TSVector2>(10);

	private readonly List<AdventureRotateWeapon> weapons = new List<AdventureRotateWeapon>(2);

	private readonly List<long> copy_buleltsID = new List<long>(6);

	private int num_28;

	private FP lastTime_06;

	private FP dis_06;

	public static List<long> monsterId_m3 = new List<long>();

	public override void OnEnable()
	{
		base.OnEnable();
		NovaLogger.Debug("_12001 Parallel OnEnable");
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_CANCAUSE_DEAD", OnReceiveDamageBeDeath);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnToughnessState);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("WEAPON_BORN", OnWeaponBorn);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("WEAPON_FINISH", OnWeaponFinish);
		mainWeapCount = 0;
		normalBulletCopy = false;
		normalHit_10 = 0;
		bigSupportWeapon = null;
		bigSupWeaponRotateIndex = 0;
		num_28 = 0;
		dis_06 = range_06;
		if (GetPerk(512001))
		{
			dis_06 = range_06_01;
		}
		if (GetPerk(512003))
		{
			_actor.buffComponent.AddBuff(12003011, _actor);
		}
		if (GetPerk(512013))
		{
			PlayerSkillCd playerSkillCd = (_actor as PlayerAdventureActor).playerSkillCd;
			SkillInfo skillCD = playerSkillCd.GetSkillCD(ActionKey.A);
			playerSkillCd.SetSkillTotalSection(ActionKey.A, skillCD.totalSectionAmount + 1, forceMaxSection: true);
		}
		if (GetPerk(512033))
		{
			for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
			{
				if (SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).actorElementInfo.elementType == HotfixEnum.elementType.AE)
				{
					_actor.buffComponent.AddBuff(12033011, _actor);
				}
			}
		}
		if (GetPerk(512012))
		{
			pro_12 = CommonUtils.GetScriptValue(_actor, 12051211);
		}
	}

	public override void OnDisable()
	{
		NovaLogger.Debug("_12001 Parallel OnDisable");
		base.OnDisable();
		_b2t4AttackHitCount.Clear();
		delayBullets.Clear();
		delayBulletPos.Clear();
		delayBulletDir.Clear();
		weapons.Clear();
		copy_buleltsID.Clear();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE_CANCAUSE_DEAD", OnReceiveDamageBeDeath);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_TOUGHNESS_STATECHANGE", OnToughnessState);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("WEAPON_BORN", OnWeaponBorn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("WEAPON_FINISH", OnWeaponFinish);
	}

	private void OnCastSkill(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		if (!(_actor != null) || !(adventureActorCastSkillEvent.sender is PlayerAdventureActor playerAdventureActor))
		{
			return;
		}
		if (GetPerk(512004))
		{
			powerNum = _actor.buffComponent.GetBuffNumByID(12004011);
			if (adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
			{
				int num = ((playerAdventureActor == _actor) ? 5 : 3);
				num += powerNum;
				num = ((num > 5) ? 5 : num);
				num -= powerNum;
				if (num <= 0)
				{
					return;
				}
				_actor.buffComponent.AddBuffNum(12004011, num, _actor);
				powerNum += num;
			}
			else if (adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.NORMAL)
			{
				_ = playerAdventureActor == _actor;
			}
		}
		if (GetPerk(512008) && adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			_actor.buffComponent.AddBuff(12008011, _actor);
		}
		if (adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.A && playerAdventureActor.Id == _actor.Id)
		{
			if (GetPerk(512010, CommonUtils.GetScriptValue(_actor, 12051011)))
			{
				_actor.logicVariable.SetLogicTagValue("SkillNormalAttackStage_120", 5);
				normalHit_10 = 2;
			}
			if (GetPerk(512013))
			{
				_actor.buffComponent.AddBuff(12013011, _actor);
			}
		}
		if (adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && playerAdventureActor.Id == _actor.Id)
		{
			for (int num2 = weapons.Count - 1; num2 >= 0; num2--)
			{
				weapons.get_Item(num2).Finish();
			}
		}
	}

	protected void OnBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (adventureActorReceiveDamageBeforeHitEvent.from is PlayerAdventureActor fromActor && adventureActorReceiveDamageBeforeHitEvent.to is AdventureActor adventureActor)
		{
			if (huaWeaponCount > 0 && CheckTalentLevel(1))
			{
				AdventureActor.AddFromAttr(onceId_m1, _actor);
			}
			if (CheckTalentLevel(5) && !adventureActor.IsBossMonster())
			{
				AdventureActor.AddFromAttr(onceId_m5, _actor);
			}
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, hitTag_23))
			{
				if (GetPerk(512023))
				{
					AdventureActor.AddFromAttr(12052311, fromActor);
				}
				if (GetPerk(perk_28) && num_28 > 0)
				{
					AdventureActor.AddFromAttr(12052801, fromActor, num_28);
				}
				if (GetPerk(perk_29) && bigSupWeaponRotateIndex > 0)
				{
					AdventureActor.AddFromAttr(12052901, fromActor, bigSupWeaponRotateIndex);
				}
			}
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Skill_SupportHitTag))
			{
				if (GetPerk(512021))
				{
					AdventureActor.AddFromAttr(onceId_21, fromActor);
				}
				if (GetPerk(512022))
				{
					AdventureActor.AddFromAttr(12052211, fromActor);
				}
				if (GetPerk(512026) && adventureActor is MonsterAdventureActor monsterAdventureActor && (monsterAdventureActor.IsBossMonster() || monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE))
				{
					AdventureActor.AddFromAttr(12052601, fromActor);
				}
				if (GetPerk(perk_27))
				{
					AdventureActor.AddFromAttr(12052701, fromActor);
				}
			}
			if (GetPerk(512004) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, NormalHitTag_04))
			{
				AdventureActor.AddFromAttr(12050411, fromActor);
			}
		}
		if (!(adventureActorReceiveDamageBeforeHitEvent.from == _actor) || !(adventureActorReceiveDamageBeforeHitEvent.to is AdventureActor))
		{
			return;
		}
		if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Skill_MainHitTag))
		{
			if (GetPerk(512002))
			{
				AdventureActor.AddFromAttr(12050211, _actor);
			}
			if (GetPerk(512007))
			{
				AdventureActor.AddFromAttr(12050701, _actor);
			}
		}
		if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, NormalHitTag) && normalHit_10 > 0 && (int)(long)_actor.logicVariable.GetLogicTagValue("SkillNormalAttackStage_120") == 1)
		{
			AdventureActor.AddFromAttr(12051001, _actor);
			normalHit_10--;
		}
		if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, UltraHitTag) && adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor monsterAdventureActor2)
		{
			if (GetPerk(perk_31))
			{
				AdventureActor.AddFromAttr(12053101, _actor);
			}
			if (CheckTalentLevel(3) && !monsterId_m3.Contains(monsterAdventureActor2.Id))
			{
				monsterId_m3.Add(monsterAdventureActor2.Id);
				Singleton<BuffManager>.Instance.AddBufftoGroup(buff_m3, _actor);
			}
		}
		if (GetPerk(512009) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, windAreaTag))
		{
			AdventureActor.AddFromAttr(12050901, _actor);
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (!(_actor != null) || (_actor.Id != adventureActorReceiveDamageEvent.from.Id && adventureActorReceiveDamageEvent.from.Id != SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.Id) || !(adventureActorReceiveDamageEvent.to is MonsterAdventureActor monsterAdventureActor))
		{
			return;
		}
		if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, UltraHitTag))
		{
			if (GetPerk(perk_31))
			{
				monsterAdventureActor.buffComponent.AddBuff(2011, _actor);
			}
			if (GetPerk(512042))
			{
				_actor.buffComponent.AddBuff(12042011, _actor);
			}
		}
		if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, NormalHitTag) && GetPerk(512012) && CheckProbability(pro_12))
		{
			monsterAdventureActor.buffComponent.AddBuff(12012011, _actor);
		}
		if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Skill_SupportHitTag))
		{
			if (GetPerk(512025))
			{
				monsterAdventureActor.buffComponent.AddBuff(12025011, _actor);
			}
			if (GetPerk(perk_28, cd_28))
			{
				num_28++;
			}
		}
		OnWindBrust(adventureActorReceiveDamageEvent);
	}

	protected void OnElementMarkTrigger(IEvent evt)
	{
		AdventureElementMarkTriggerEvent adventureElementMarkTriggerEvent = evt as AdventureElementMarkTriggerEvent;
		if (adventureElementMarkTriggerEvent.elementType == HotfixEnum.elementType.AE)
		{
			if (_actor != null && CheckTalentLevel(4))
			{
				_actor.buffComponent.AddBuff(buff_m4, _actor);
			}
			if (adventureElementMarkTriggerEvent.triggerActor is PlayerAdventureActor)
			{
				_ = adventureElementMarkTriggerEvent.markActor is MonsterAdventureActor;
			}
		}
	}

	protected void OnWeaponBorn(IEvent evt)
	{
		AdventureWeaponBornEvent adventureWeaponBornEvent = evt as AdventureWeaponBornEvent;
		if (adventureWeaponBornEvent.owner == null || (adventureWeaponBornEvent.owner.Id != _actor.Id && adventureWeaponBornEvent.owner.Id != SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.Id))
		{
			return;
		}
		if (adventureWeaponBornEvent.sender is AdventureRotateWeapon adventureRotateWeapon)
		{
			huaWeaponCount++;
			if (adventureRotateWeapon.weaponTag == MainSkill_Bullet_Tag)
			{
				mainWeapCount++;
				if (GetPerk(512002))
				{
					adventureRotateWeapon.rotateSpeed = rotSpeed_02;
				}
				if (GetPerk(512005))
				{
					int num = adventureRotateWeapon.weaponColliders.Length;
					Singleton<BuffManager>.Instance.SetBuffNumtoGroup(12005011, num, _actor);
				}
				weapons.Add(adventureRotateWeapon);
			}
			else if (adventureRotateWeapon.weaponTag == SupportSkill_Bullet_Tag)
			{
				num_28 = 0;
				if (GetPerk(512023))
				{
					adventureRotateWeapon.rotateSpeed = rotSpeed_23;
				}
				if (GetPerk(512026))
				{
					adventureRotateWeapon.hitBox.featureData.hitStrenth = 4;
				}
				weapons.Add(adventureRotateWeapon);
			}
		}
		else
		{
			if (!(adventureWeaponBornEvent.owner == _actor) || !(adventureWeaponBornEvent.sender is AdventureBullet adventureBullet))
			{
				return;
			}
			if (GetPerk(512003) && !copy_buleltsID.Contains(adventureBullet.Id) && TSRandom.Range(0, 100) < 20 && !delayBullets.ContainsKey(_actor.LogicTime))
			{
				if (normalHit_10 > 0 && (int)(long)_actor.logicVariable.GetLogicTagValue("SkillNormalAttackStage_120") == 1)
				{
					normalHit_10++;
				}
				delayBullets.Add(_actor.LogicTime, adventureBullet);
				delayBulletPos.Add(_actor.LogicTime, adventureBullet.tsTransform.Position);
				delayBulletDir.Add(_actor.LogicTime, adventureBullet.velocityDirection);
			}
			if (normalSkill)
			{
				normalSkill = false;
				if (powerNum != 0)
				{
					_actor.buffComponent.RemoveBuffByBuffId(12004011, 1);
					powerNum--;
				}
			}
		}
	}

	protected void OnWeaponFinish(IEvent evt)
	{
		AdventureWeaponFinishEvent adventureWeaponFinishEvent = evt as AdventureWeaponFinishEvent;
		if (adventureWeaponFinishEvent.owner == null)
		{
			return;
		}
		if (adventureWeaponFinishEvent.sender is AdventureRotateWeapon adventureRotateWeapon)
		{
			huaWeaponCount--;
			if (adventureRotateWeapon.weaponTag == MainSkill_Bullet_Tag)
			{
				mainWeapCount--;
				if (GetPerk(512005))
				{
					int num = adventureRotateWeapon.weaponColliders.Length;
					Singleton<BuffManager>.Instance.SetBuffNumtoGroup(12005011, -num);
				}
				weapons.Remove(adventureRotateWeapon);
			}
			else if (adventureRotateWeapon.weaponTag == SupportSkill_Bullet_Tag)
			{
				if (bigSupportWeapon != null && bigSupportWeapon.Id == adventureRotateWeapon.Id)
				{
					bigSupportWeapon = null;
				}
				weapons.Remove(adventureRotateWeapon);
			}
		}
		else
		{
			if (!(adventureWeaponFinishEvent.owner == _actor) || !(adventureWeaponFinishEvent.sender is AdventureBullet adventureBullet))
			{
				return;
			}
			if (copy_buleltsID.Contains(adventureBullet.Id))
			{
				copy_buleltsID.Remove(adventureBullet.Id);
			}
			if (!(adventureBullet.weaponTag == Support_fly__Bullet_Tag))
			{
				return;
			}
			string bulletAlias = bullet_normal;
			if (GetPerk(512021))
			{
				bulletAlias = "Bullet_12001_B2P21_Skill_Corolla_Strength";
				if (GetPerk(512022))
				{
					bulletAlias = "Bullet_12001_B2P21P22_Skill_Corolla_Strength";
				}
			}
			else if (GetPerk(512022))
			{
				bulletAlias = bullet_normal_p22;
			}
			LogicEntity logicEntity = SceneSingleton<AdventurePlayerController>.Instance?.activedPlayerActor;
			if (logicEntity == null)
			{
				logicEntity = _actor;
			}
			bigSupportWeapon = ILRuntimeAPI.ShootRotateWepon(bulletAlias, _actor, _actor, logicEntity.tsTransform.Forward);
			bigSupWeaponRotateIndex = 0;
			if (GetPerk(512033))
			{
				bigSupportWeapon.fixLeftTime(time_33);
			}
			if (GetPerk(512024))
			{
				AdventureRotateWeapon adventureRotateWeapon2 = null;
				adventureRotateWeapon2 = ((!GetPerk(512023)) ? ILRuntimeAPI.ShootRotateWepon("Bullet_12001_B2P24_Wreath", _actor, _actor, logicEntity.tsTransform.Forward) : ILRuntimeAPI.ShootRotateWepon("Bullet_12001_B2P24P23_Wreath", _actor, _actor, logicEntity.tsTransform.Forward));
				if (GetPerk(512033))
				{
					adventureRotateWeapon2.fixLeftTime(time_33);
				}
			}
		}
	}

	private void OnReceiveDamageBeDeath(IEvent evt)
	{
		AdventureActorReceiveDamageCanCauseDeadEvent adventureActorReceiveDamageCanCauseDeadEvent = evt as AdventureActorReceiveDamageCanCauseDeadEvent;
		if (_actor != null && _actor.Id == adventureActorReceiveDamageCanCauseDeadEvent.from.Id && adventureActorReceiveDamageCanCauseDeadEvent.hitDamageTag != null && CheckTalentLevel(2))
		{
			_actor.buffComponent.AddBuff(buff_m2, _actor);
		}
	}

	private void OnToughnessState(IEvent evt)
	{
		MonsterToughnessStateChangeEvent monsterToughnessStateChangeEvent = evt as MonsterToughnessStateChangeEvent;
		if (_actor != null && (_actor.Id == monsterToughnessStateChangeEvent.source.Id || SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.Id == monsterToughnessStateChangeEvent.source.Id) && monsterToughnessStateChangeEvent.isToughnessBroken && GetPerk(perk_27) && CommonUtils.CheckHitByTag(monsterToughnessStateChangeEvent.hitDamageTag, Skill_SupportHitTag))
		{
			monsterToughnessStateChangeEvent.actor.buffComponent?.AddBuff(12027011, monsterToughnessStateChangeEvent.source);
		}
	}

	private void OnWindBrust(AdventureActorReceiveDamageEvent damageEvt)
	{
		if (!(damageEvt.from == _actor) || !(damageEvt.to is MonsterAdventureActor monsterAdventureActor))
		{
			return;
		}
		bool flag = false;
		bool flag2 = false;
		if (CommonUtils.CheckHitByTag(damageEvt.hitDamageTag, windBoomHit))
		{
			flag = true;
		}
		if (GetPerk(512011) && CommonUtils.CheckHitByTag(damageEvt.hitDamageTag, UltraHitTag))
		{
			flag2 = true;
			flag = true;
		}
		if (flag && CommonUtils.CheckElementMark(CommonDefine.WindMark1, monsterAdventureActor) && CommonUtils.CheckTriggerElementMarkCD(_actor, monsterAdventureActor))
		{
			if (flag2)
			{
				_actor.buffComponent.AddBuff(12011011, _actor);
			}
			monsterAdventureActor.buffComponent.RemoveBuffByTag(CommonDefine.WindMark1);
			ILRuntimeAPI.PlayAreaEffect(_actor, windAreaEffect, monsterAdventureActor.tsTransform.Position);
			CommonUtils.TriggerElementMarkEvent(CommonDefine.WindMark1, HotfixEnum.AdventureActorElementTriggerType.WindElementTriggerType2, _actor, monsterAdventureActor, "WindMark_Trigger_Effect_01");
		}
	}

	private void OnBulletInit(LogicEntity weapon)
	{
		copy_buleltsID.Add(weapon.Id);
	}

	public void OnUpdate()
	{
		lastTime_06 -= _actor.LogicDeltaTime;
		if (GetPerk(512006) && mainWeapCount > 0 && lastTime_06 < 0)
		{
			lastTime_06 = 0.25;
			ILRuntimeAPI.SearchByRange(_actor, dis_06, (List<LogicEntity> monsters) =>
			{
				if (monsters != null && monsters.Count > 0)
				{
					for (int i = 0; i < monsters.Count; i++)
					{
						MonsterAdventureActor monsterAdventureActor = monsters.get_Item(i) as MonsterAdventureActor;
						if (monsterAdventureActor != null)
						{
							monsterAdventureActor.buffComponent.AddBuff(12006012, _actor);
						}
					}
				}
			}, isConfront: true);
		}
		if (bigSupportWeapon != null)
		{
			int num = (bigSupWeaponRotateIndex + 1) * 360;
			if (FP.Abs(bigSupportWeapon.GetAngel()) > num)
			{
				bigSupWeaponRotateIndex++;
				if (GetPerk(512030))
				{
					SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.buffComponent.AddBuff(12030011, _actor);
				}
				if (GetPerk(512024))
				{
					AdventureActor actor = _actor;
					TSVector2 position = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.tsTransform.Position;
					AdventureActor actor2 = _actor;
					ILRuntimeAPI.PlayAreaEffect(actor, "AreaEffect_12001_B2P24_Wreath", position, default, null, actor2);
				}
			}
		}
		if (delayBullets.Count <= 0)
		{
			return;
		}
		foreach (FP key in delayBullets.Keys)
		{
			if (key + delay_time < _actor.LogicTime)
			{
				if (!copy_buleltsID.Contains(delayBullets.get_Item(key).Id))
				{
					int length = delayBullets.get_Item(key).name.IndexOf('(');
					string bulletAlias = delayBullets.get_Item(key).name.Substring(0, length);
					AdventureActor actor3 = _actor;
					FP range = 0;
					TSVector2 shootDir = delayBulletDir.get_Item(key);
					TSVector2 position2 = delayBulletPos.get_Item(key);
					FP positionY = 1.8;
					Action<LogicEntity> onInit = OnBulletInit;
					ILRuntimeAPI.ShootByDirection(bulletAlias, actor3, range, shootDir, position2, positionY, default, null, AimType.Default, null, onInit);
				}
				else
				{
					copy_buleltsID.Remove(delayBullets.get_Item(key).Id);
				}
				delayBulletPos.Remove(key);
				delayBulletDir.Remove(key);
				delayBullets.Remove(key);
				break;
			}
		}
	}
}
