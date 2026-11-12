using System.Collections.Generic;
using AIScript.Monster._12301111FengTun;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12301;

public class Parallel : ParallelBase
{
	private int buff_m1 = 12396111;

	private readonly int ultraAtkTag = CommonHelper.StringToHash("123NrmUltraBoom");

	private int buff_m2 = 12396211;

	public const int buff_m3 = 12396311;

	private int buff_m4 = 12396411;

	private int buff_m5 = 12396511;

	private static readonly int nrmAtkTag = CommonHelper.StringToHash("123NrmAtk");

	private static readonly int trigger_Area_Tag = CommonHelper.StringToHash("123FengBoom");

	public const string area_123_Boom = "AreaEffect_123_FengBoom";

	public const string area_123_Boom_p2 = "AreaEffect_123_FengBoom_P2";

	private readonly FP trigger_area_cd = 1;

	private const int trigger_property = 25;

	public const int perkId_11 = 512311;

	private readonly int addNum_11 = 1;

	public const int buff_11 = 12311011;

	public static readonly int personalPerkId_41 = 512341;

	public const int shield_PerkId41 = 12354101;

	public static readonly int personalPerkId_42 = 512342;

	public const string area_42 = "AreaEffect_123_Ultra_T42";

	public static readonly FP dis_p42 = 0;

	public static readonly string evt_p42 = "xingzixiqi";

	private const int buff_42 = 12354211;

	public static readonly int personalPerkId_43 = 512343;

	public static readonly int count_p43 = 5;

	public const int parameterId_p43 = 12343001;

	public static string evt_clear = "xingzihoujiao";

	public static readonly int personalPerkId_21 = 512321;

	private readonly int personalPerkId_22 = 512322;

	private readonly FP playerCd_p22 = 2;

	private readonly int shield_p22 = 12322001;

	private const int buff_22 = 12352211;

	private static readonly int windEffectTag = CommonHelper.StringToHash("123WindWall");

	public static readonly int personalPerkId_23 = 512323;

	public static readonly string areaEffect_p23 = "AreaEffect_123_B2_WindWall_Wave_Hit";

	public static readonly int personalPerkId_24 = 512324;

	public static int attri_p24 = 12324001;

	protected readonly int personalPerkId_25 = 512325;

	protected readonly int hitWindTag = CommonHelper.StringToHash("123WindWallAtk");

	public const int buff_p25 = 12352511;

	public static readonly int personalPerkId_26 = 512326;

	public const int buff_p26 = 12352611;

	protected readonly int personalPerkId_27 = 512327;

	private const int buffId_27 = 12352711;

	protected readonly int personalPerkId_28 = 512328;

	public const int buff_p28 = 12352811;

	protected readonly int personalPerkId_29 = 512329;

	public const int buff_p29 = 12352911;

	protected readonly int personalPerkId_30 = 512330;

	public const int buff_p30 = 12353011;

	private static readonly int windEffectTag_Wave = CommonHelper.StringToHash("123WindWallBuff");

	protected readonly int personalPerkId_31 = 512331;

	protected const int attri_p31 = 12353101;

	protected readonly int personalPerkId_32 = 512332;

	protected const int buff_p32 = 12353211;

	protected readonly int personalPerkId_33 = 512333;

	protected readonly int percent_p33 = 35;

	protected const int attri_p33 = 12353301;

	private readonly int perkId_09 = 512309;

	private readonly FP cd_09 = 5;

	private readonly FP property_09 = 30;

	private const int buff_p9 = 12309011;

	private readonly int perkId_10 = 512310;

	private readonly FP cd_10 = 1;

	private const int parameterId_10 = 12310001;

	private readonly int numMax_10 = 10;

	private int triggerAreaId = 123999001;

	private Dictionary<long, FP> dicTime_p27 = new Dictionary<long, FP>(3);

	public static Dictionary<long, long> dicAreaBind_1 = new Dictionary<long, long>();

	public static Dictionary<long, long> dicAreaBind_2 = new Dictionary<long, long>();

	public static long summmerID;

	public static int numMax;

	private int areaCount;

	public override void OnEnable()
	{
		base.OnEnable();
		areaCount = 0;
		numMax = 0;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("AREA_EFFECT_ENTER_EXIT", OnAreaEnterOrExit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("BULLET_BLOCK", OnBulletBlock);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("AREA_EFFECT_BEGIN", OnAreaBegin);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("AREA_EFFECT_FINISH", OnAreaFinish);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_PLAYER_ENTER", OnPlayerEnter);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		if (GetPerk(personalPerkId_42))
		{
			_actor.buffComponent.AddBuff(12354211, _actor);
		}
		if (GetPerk(512311))
		{
			PlayerSkillCd playerSkillCd = (_actor as PlayerAdventureActor).playerSkillCd;
			SkillInfo skillCD = playerSkillCd.GetSkillCD(ActionKey.A);
			playerSkillCd.SetSkillTotalSection(ActionKey.A, skillCD.totalSectionAmount + addNum_11, forceMaxSection: true);
		}
		if (!CheckTalentLevel(5))
		{
			return;
		}
		int num = 0;
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			if (SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).actorElementInfo.elementType == HotfixEnum.elementType.AE)
			{
				num++;
			}
		}
		if (num >= 3)
		{
			Singleton<BuffManager>.Instance.AddBufftoGroup(buff_m5, _actor);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		dicAreaBind_1.Clear();
		dicAreaBind_2.Clear();
		dicTime_p27.Clear();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_ENTER_EXIT", OnAreaEnterOrExit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_BLOCK", OnBulletBlock);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_BEGIN", OnAreaBegin);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_FINISH", OnAreaFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_PLAYER_ENTER", OnPlayerEnter);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		if (activedPlayerActor != null && GetPerk(personalPerkId_32) && activedPlayerActor.buffComponent.CheckBuffByBuffID(12353211))
		{
			activedPlayerActor.buffComponent?.RemoveBuffByBuffId(12353211);
		}
	}

	private void OnPlayerEnter(IEvent _evt)
	{
		AdventurePlayerEnterEvent adventurePlayerEnterEvent = _evt as AdventurePlayerEnterEvent;
		if (!(adventurePlayerEnterEvent.player != null) || !GetPerk(512308))
		{
			return;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			if (playerAdventureActor.isAssist && playerAdventureActor.Id != adventurePlayerEnterEvent.player.Id)
			{
				playerAdventureActor.buffComponent.AddBuff(12308011, _actor);
			}
		}
	}

	private void OnGetBuff(IEvent evt)
	{
		AdventureActorGetBuff adventureActorGetBuff = evt as AdventureActorGetBuff;
		if (!(adventureActorGetBuff.from != _actor) && adventureActorGetBuff.eventInfo.buffTags.Contains(CommonDefine.WindMark1) && CheckTalentLevel(2))
		{
			Singleton<BuffManager>.Instance.AddBufftoGroup(buff_m2, _actor);
		}
	}

	private void OnBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (!(_actor == null) && !(adventureActorReceiveDamageBeforeHitEvent.to == null) && adventureActorReceiveDamageBeforeHitEvent.hitDamageTag != null)
		{
			if (_actor.Id == adventureActorReceiveDamageBeforeHitEvent.from?.Id && GetPerk(personalPerkId_31) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, hitWindTag))
			{
				AdventureActor.AddFromAttr(12353101, _actor);
			}
			if (adventureActorReceiveDamageBeforeHitEvent.from is PlayerAdventureActor playerAdventureActor && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.AE && GetPerk(personalPerkId_33) && TSRandom.Range(0, 100) < percent_p33)
			{
				AdventureActor.AddFromAttr(12353301, _actor);
			}
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (!(_actor != null) || adventureActorReceiveDamageEvent.hitDamageTag == null || !(adventureActorReceiveDamageEvent.to is MonsterAdventureActor monsterAdventureActor))
		{
			return;
		}
		if (_actor.Id == adventureActorReceiveDamageEvent.from.Id)
		{
			if (CheckTalentLevel(1) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, ultraAtkTag) && !_actor.buffComponent.CheckBuffByBuffID(buff_m1))
			{
				Singleton<BuffManager>.Instance.AddBufftoGroup(buff_m1, _actor);
			}
			if (GetPerk(personalPerkId_25) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, hitWindTag))
			{
				monsterAdventureActor.buffComponent.AddBuff(12352511, _actor);
			}
			if (GetPerk(personalPerkId_28) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, hitWindTag))
			{
				monsterAdventureActor.buffComponent.AddBuff(12352811, _actor);
			}
		}
		if (_actor.Id == adventureActorReceiveDamageEvent.from.Id || adventureActorReceiveDamageEvent.from.Id == summmerID)
		{
			OnTriggerWindArea(adventureActorReceiveDamageEvent.hitDamageTag, monsterAdventureActor);
		}
	}

	private void OnAreaBegin(IEvent evt)
	{
		AdventureAreaEffectBeginEvent adventureAreaEffectBeginEvent = evt as AdventureAreaEffectBeginEvent;
		if (_actor != null && adventureAreaEffectBeginEvent.owner.Id == _actor.Id)
		{
			areaCount++;
			PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
			if (!(activedPlayerActor == null) && areaCount > 0 && GetPerk(personalPerkId_32) && !activedPlayerActor.buffComponent.CheckBuffByBuffID(12353211))
			{
				activedPlayerActor.buffComponent?.AddBuff(12353211, _actor);
			}
		}
	}

	private void OnAreaFinish(IEvent evt)
	{
		AdventureAreaEffectFinishEvent adventureAreaEffectFinishEvent = evt as AdventureAreaEffectFinishEvent;
		if (!(adventureAreaEffectFinishEvent.owner == null) && adventureAreaEffectFinishEvent.owner.Id == _actor.Id && adventureAreaEffectFinishEvent.sender is AreaEffectEntity areaEffectEntity)
		{
			areaCount--;
			PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
			if (areaCount <= 0 && GetPerk(personalPerkId_32) && activedPlayerActor.buffComponent.CheckBuffByBuffID(12353211))
			{
				activedPlayerActor.buffComponent?.RemoveBuffByBuffId(12353211);
			}
			if (dicAreaBind_1.TryGetValue(areaEffectEntity.Id, out var value))
			{
				ILRuntimeAPI.StopAreaEffect(value);
				dicAreaBind_1.Remove(areaEffectEntity.Id);
			}
			if (dicAreaBind_2.TryGetValue(areaEffectEntity.Id, out var value2))
			{
				ILRuntimeAPI.StopAreaEffect(value2);
				dicAreaBind_2.Remove(areaEffectEntity.Id);
			}
		}
	}

	private void OnAreaEnterOrExit(IEvent evt)
	{
		AdventureAreaEnterExitEvent adventureAreaEnterExitEvent = evt as AdventureAreaEnterExitEvent;
		if (!(_actor != null) || !(adventureAreaEnterExitEvent.triggerCollider?.Entity != null) || !(adventureAreaEnterExitEvent.sender is AreaEffectEntity areaEffectEntity))
		{
			return;
		}
		if (adventureAreaEnterExitEvent.iEnter)
		{
			if (GetPerk(personalPerkId_30) && adventureAreaEnterExitEvent.triggerCollider.Entity is MonsterAdventureActor monsterAdventureActor && areaEffectEntity.CheckTag(windEffectTag_Wave))
			{
				monsterAdventureActor.buffComponent.AddBuff(12353011, _actor);
			}
			return;
		}
		if (GetPerk(personalPerkId_22) && adventureAreaEnterExitEvent.triggerCollider.Entity is PlayerAdventureActor { isAssist: false } playerAdventureActor && areaEffectEntity.CheckTag(windEffectTag) && CheckPerkCd(playerAdventureActor.Id, playerCd_p22))
		{
			playerAdventureActor.actorShield.AddShield(shield_p22, _actor);
			playerAdventureActor.buffComponent.AddBuff(12352211, _actor);
		}
		if (GetPerk(personalPerkId_29) && areaEffectEntity.CheckTag(windEffectTag) && adventureAreaEnterExitEvent.triggerCollider.Entity is PlayerAdventureActor { isAssist: false } playerAdventureActor2)
		{
			playerAdventureActor2.buffComponent.AddBuff(12352911, _actor);
		}
		if (GetPerk(personalPerkId_30) && adventureAreaEnterExitEvent.triggerCollider.Entity is MonsterAdventureActor monsterAdventureActor2 && areaEffectEntity.CheckTag(windEffectTag_Wave))
		{
			monsterAdventureActor2.buffComponent.RemoveBuffByBuffId(12353011);
		}
	}

	private void OnBulletBlock(IEvent evt)
	{
		AdventureBulletBlockEvent adventureBulletBlockEvent = evt as AdventureBulletBlockEvent;
		if (evt.sender is AreaEffectEntity areaEffectEntity && _actor != null && _actor.Id == adventureBulletBlockEvent.owner.Id && GetPerk(personalPerkId_27) && areaEffectEntity.CheckTag(windEffectTag))
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor;
			if (playerAdventureActor != null)
			{
				playerAdventureActor.buffComponent.AddBuff(12352711, _actor);
			}
		}
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		if ((evt as AdventureElementMarkTriggerEvent).elementType == HotfixEnum.elementType.AE)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance?.ActivedPlayerActor;
			if (playerAdventureActor != null && CheckTalentLevel(4))
			{
				playerAdventureActor.buffComponent.AddBuff(buff_m4, _actor);
			}
			if (GetPerk(perkId_09) && TSRandom.Range(0, 100) < property_09 && CheckPerkCd(perkId_09, cd_09))
			{
				_actor.buffComponent.AddBuff(12309011, _actor);
			}
			if (GetPerk(perkId_10) && TSRandom.Range(0, 100) < CommonUtils.GetScriptValue(_actor, 12310001) && numMax < numMax_10)
			{
				numMax++;
				(_actor as PlayerAdventureActor).playerSkillCd.ModifyResumeTimeAbs(-cd_10, ActionKey.B);
			}
		}
	}

	private void OnAirBorneDamageFalseEvent(IEvent evt)
	{
	}

	private void OnTriggerWindArea(IList<int> hitDamageTag, AdventureActor _monster)
	{
		bool flag = false;
		FP fP = 25;
		if (GetPerk(512307))
		{
			fP += AIScript.Monster._12301111FengTun.Parallel.parmValue_07;
		}
		if (TSRandom.Range(0, 100) < fP)
		{
			if (CommonUtils.CheckHitByTag(hitDamageTag, trigger_Area_Tag) && CheckPerkCd(triggerAreaId, trigger_area_cd))
			{
				flag = true;
			}
			else if (summmerID > 0 && CommonUtils.CheckHitByTag(hitDamageTag, nrmAtkTag) && GetPerk(512301, trigger_area_cd))
			{
				flag = true;
			}
		}
		if (!flag)
		{
			return;
		}
		string fxAlias = "AreaEffect_123_FengBoom";
		if (GetPerk(512302))
		{
			fxAlias = "AreaEffect_123_FengBoom_P2";
		}
		if (ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, _monster.tsTransform.Position) > 0)
		{
			if (GetPerk(512301))
			{
				Singleton<BuffManager>.Instance?.AddBufftoGroup(12301011, _actor);
			}
			if (GetPerk(512305))
			{
				Singleton<BuffManager>.Instance?.AddBufftoGroup(12305011, _actor);
			}
		}
	}

	public void OnUpdate()
	{
	}
}
