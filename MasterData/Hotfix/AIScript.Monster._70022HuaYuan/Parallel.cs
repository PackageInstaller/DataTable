#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using AIScript.Monster.Template;
using AIScript.Utils;
using Nova.Hotfix;
using TrueSync;

namespace AIScript.Monster._70022HuaYuan;

public class Parallel : AIScript.Monster.Template.Parallel
{
	private static readonly Dictionary<int, FP> attackWindowTimeDic = new Dictionary<int, FP>
	{
		[7002200] = 4,
		[7002201] = 3,
		[7002202] = 3,
		[7002203] = 2,
		[7002204] = 5,
		[7002205] = 3,
		[7002206] = 5,
		[7002207] = 4,
		[7002208] = 6,
		[7002213] = 3,
		[7002214] = 4,
		[7002215] = 4,
		[7002217] = 4,
		[7002221] = 4,
		[7002222] = 4,
		[7002223] = 4,
		[7002224] = 4
	};

	private const int buffId_AttackWindow = 700220000;

	private List<int> shields = new List<int> { 29020301, 29020302, 29020303 };

	private int onceId_debuff;

	private CoroutineNode _attackWindowCor;

	private readonly int skill_hit_tag = CommonHelper.StringToHash("AchievementHitTag");

	private readonly List<int> fog_skillids = new List<int> { 7002208, 7002224 };

	private readonly HotfixEnum.travelerDuelBossType travelerDuelType = HotfixEnum.travelerDuelBossType.CHALLENGE;

	private bool HuaYuanLvRenBoss_001;

	private bool HuaYuanLvRenBoss_002;

	private bool HuaYuanLvRenBoss_003;

	private bool challengeMode;

	private bool onSkillBegin;

	public override void OnStart()
	{
		base.OnStart();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_SHIELD", OnShieldChange);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_ADD_SHIELD", OnShieldAdd);
		OnEnabled();
	}

	private void OnBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (!(_actor == null) && !(adventureActorReceiveDamageBeforeHitEvent.to == null) && adventureActorReceiveDamageBeforeHitEvent.hitDamageTag != null && !(adventureActorReceiveDamageBeforeHitEvent.from == null) && adventureActorReceiveDamageBeforeHitEvent.damageType == HotfixEnum.damageType.MARK && adventureActorReceiveDamageBeforeHitEvent.from is AdventureActor fromActor && (adventureActorReceiveDamageBeforeHitEvent.from is PlayerAdventureActor || adventureActorReceiveDamageBeforeHitEvent.from.IsPlayerMinion(out var _)))
		{
			AdventureActor.AddFromAttr(onceId_debuff, fromActor);
		}
	}

	private void OnCastSkill(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		if (!(adventureActorCastSkillEvent.sender as MonsterAdventureActor != _actor))
		{
			OnSkillCastStart(adventureActorCastSkillEvent.skillEventInfo.skillId);
			ForceStopAattckWindow();
		}
	}

	private void OnCastSkillEnd(IEvent evt)
	{
		AdventureActorCastSkillEndEvent adventureActorCastSkillEndEvent = evt as AdventureActorCastSkillEndEvent;
		if (!(adventureActorCastSkillEndEvent.sender as MonsterAdventureActor != _actor))
		{
			int skillId = adventureActorCastSkillEndEvent.skillEventInfo.skillId;
			OnSkillCastEnd(skillId);
			if (attackWindowTimeDic.TryGetValue(skillId, out var value) && value > 0)
			{
				ForceStopAattckWindow();
				_attackWindowCor = _actor.StartLogicCoroutine(AttackWindowLogic(value), runImmediately: true);
				NovaLogger.Debug($"攻击窗口开始,技能Id:{skillId},持续时间{value}");
			}
		}
	}

	private IEnumerator AttackWindowLogic(FP durationTime)
	{
		_actor.buffComponent.AddBuff(700220000, _actor);
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(durationTime));
		_actor.buffComponent.RemoveBuffByBuffId(700220000);
		_attackWindowCor = null;
		NovaLogger.Debug("攻击窗口结束");
	}

	private void ForceStopAattckWindow()
	{
		if (_attackWindowCor != null)
		{
			_actor.StopLogicCoroutine(_attackWindowCor);
			_actor.buffComponent.RemoveBuffByBuffId(700220000);
			NovaLogger.Debug("打断当前攻击窗口");
		}
		_attackWindowCor = null;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_SHIELD", OnShieldChange);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_ADD_SHIELD", OnShieldAdd);
		ForceStopAattckWindow();
		OnDisabled();
		(_actor as MonsterAdventureActor).monsterToughnessInfo.lockToughness = false;
	}

	private void OnShieldChange(IEvent evt)
	{
		if (_actor != null)
		{
			bool flag = false;
			for (int i = 0; i < shields.Count; i++)
			{
				flag |= _actor.actorShield.CheckShieldByID(shields.get_Item(i));
			}
			if (!flag)
			{
				(_actor as MonsterAdventureActor).monsterToughnessInfo.lockToughness = false;
			}
		}
	}

	public virtual void OnShieldAdd(IEvent evt)
	{
		if (_actor != null && evt is AdventureActorAddShield adventureActorAddShield && shields.Contains(adventureActorAddShield.shieldId))
		{
			(_actor as MonsterAdventureActor).monsterToughnessInfo.lockToughness = true;
		}
	}

	protected void OnEnabled()
	{
		onSkillBegin = false;
		initChallengeMode();
		HuaYuanLvRenBoss_001 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.HuaYuanLvRenBoss_001);
		HuaYuanLvRenBoss_002 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.HuaYuanLvRenBoss_002);
		HuaYuanLvRenBoss_003 = ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.HuaYuanLvRenBoss_003);
		if (!HuaYuanLvRenBoss_002)
		{
			ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		}
	}

	protected void OnDisabled()
	{
		if (!HuaYuanLvRenBoss_002)
		{
			ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		}
	}

	private void initChallengeMode()
	{
		challengeMode = false;
		if (AdventureGameContext.LevelLoadParam == null || AdventureGameContext.LevelLoadParam.loadType != AdventureModuleLevelLoadParams.BootConfigLoadType.TravelerDuel)
		{
			return;
		}
		TravelerDuelBossLevel travelerDuelBossLevel = Singleton<HotfixDataController>.Instance.GetTravelerDuelBossLevel(CommonUtils.ParseStringParamToInt(AdventureGameContext.LevelLoadParam.id));
		if (travelerDuelBossLevel != null)
		{
			TravelerDuelBoss travelerDuelBoss = Singleton<HotfixDataController>.Instance.GetTravelerDuelBoss(travelerDuelBossLevel.BossId);
			if (travelerDuelBoss != null)
			{
				challengeMode = travelerDuelBoss.TravelerDuelBossType == (int)travelerDuelType;
			}
		}
	}

	private void OnSkillCastStart(int skillid)
	{
		if (fog_skillids.Contains(skillid))
		{
			onSkillBegin = true;
		}
	}

	private void OnSkillCastEnd(int skillid)
	{
		if (fog_skillids.Contains(skillid) && onSkillBegin && !HuaYuanLvRenBoss_002)
		{
			ModuleController<AdventureModuleController>.Instance?.SetAchievementFinish(HotfixEnum.questCompleteCondClient.HuaYuanLvRenBoss_002);
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (onSkillBegin && _actor != null && _actor.Id == adventureActorReceiveDamageEvent.from.Id && adventureActorReceiveDamageEvent.to == _player && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, skill_hit_tag))
		{
			onSkillBegin = false;
		}
	}

	protected override void OnActorDied(IEvent e)
	{
		base.OnActorDied(e);
		if (e is AdventureActorDiedEvent adventureActorDiedEvent && adventureActorDiedEvent.actor.Id == _actor.Id && !(adventureActorDiedEvent.killer == null) && adventureActorDiedEvent.killer.Id != _actor.Id)
		{
			if (!HuaYuanLvRenBoss_001)
			{
				ModuleController<AdventureModuleController>.Instance?.SetAchievementFinish(HotfixEnum.questCompleteCondClient.HuaYuanLvRenBoss_001);
			}
			if (challengeMode && !HuaYuanLvRenBoss_003)
			{
				ModuleController<AdventureModuleController>.Instance?.SetAchievementFinish(HotfixEnum.questCompleteCondClient.HuaYuanLvRenBoss_003);
			}
		}
	}
}
