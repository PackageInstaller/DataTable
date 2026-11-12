#define LOG_DEBUG
#define LOG_ERROR
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11901;

public class ParallelScript_MainControl : ParallelScript
{
	private string catchEffect = "Actor/Character/11901/FX/fx_11901_base_skill1_2";

	private Dictionary<int, string> dicBullutKey = new Dictionary<int, string>
	{
		[0] = "Bullet_11901_Skill1_BulltA",
		[1] = "Bullet_11901_Skill1_T3_BulltA",
		[2] = "Bullet_11901_Skill1_T4_BulltA",
		[3] = "Bullet_11901_Skill1_T3T4_BulltA"
	};

	private int spawnCount = 8;

	private const int perkId_1 = 511901;

	private int count_1 = 4;

	private string area_1 = "AreaEffect_119_T1_AOE";

	private const int perkId_2 = 511902;

	private int buffId_2 = 11950211;

	private const int perkId_3 = 511903;

	private const int perkId_4 = 511904;

	private int once_4 = 11950411;

	private const int perkId_5 = 511905;

	private const int buff_5 = 11950511;

	private const int perkId_6 = 511906;

	private const int buff_6 = 11950611;

	private const int once_6 = 11950601;

	private int once_ultra_6 = 11950602;

	private const int perkId_7 = 511907;

	private const int buff_7 = 11950711;

	private const int prob_7 = 30;

	private const int perkId_8 = 511908;

	private int dis_8 = 2;

	private const int once_8 = 11950801;

	private const int perkId_9 = 511909;

	private const int buff_9 = 11950911;

	private const int once_9 = 11950901;

	public const int perkId_10 = 511910;

	public const int castSkillQuota = 2;

	public const int buff_10 = 11951011;

	private const int perkId_11 = 511911;

	private const int buffId_11 = 11951111;

	private const int perkId_12 = 511912;

	private const int buff_12 = 11951211;

	private const int perkId_13 = 511913;

	private const int section_13 = 1;

	private const int buffId_13 = 11951311;

	protected Dictionary<string, int> _boomerangShootCountDic;

	protected int _boomerangIndex;

	protected FP _lastTriggerTime_T2;

	private PlayFX playFX = new PlayFX();

	private string tag_1 = "tag_1";

	private CoroutineNode corSkillHint;

	private CoroutineNode corSkillShoot;

	private int skillId;

	public override void OnEnable()
	{
		base.OnEnable();
		_boomerangShootCountDic?.Clear();
		_boomerangIndex = 0;
		_lastTriggerTime_T2 = 0;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BOOMERANG_FINISH", OnBoomerrangFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("WEAPON_BORN", OnSpecialEntityBegin);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		skillId = skillMgr.GetCurrentBindSkillId(ActionKey.B);
		if (GetPerkLv(511913, out var _))
		{
			SkillInfo skillCD = skillMgr.GetSkillCD(ActionKey.A);
			skillMgr.SetSkillTotalSection(ActionKey.A, skillCD.totalSectionAmount + 1, forceMaxSection: true);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BOOMERANG_FINISH", OnBoomerrangFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("WEAPON_BORN", OnSpecialEntityBegin);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		_boomerangShootCountDic?.Clear();
		_boomerangIndex = 0;
		_lastTriggerTime_T2 = 0;
		playFX.Stop();
		StopCoroutine(ref corSkillHint);
		StopCoroutine(ref corSkillShoot);
		MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintEnd", skillId);
		skillMgr.ResetSkillTotalSection(ActionKey.A);
	}

	public override void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		base.OnCastSkill(evt);
		int lv;
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			if (GetPerkLv(511902, out lv))
			{
				BuffEntity buffEntity = _actor.buffComponent.AddBuff(buffId_2, _actor);
				if (buffEntity != null)
				{
					FP time = FP.FromMyriad(buffEntity.buffValueConfig.Time);
					MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintEnd", skillId);
					MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintStart", skillId, time.AsFloat(), a3: true);
					StartCoroutine(ref corSkillHint, DoSkillHint(time));
				}
			}
			if (GetPerkLv(511910, out lv))
			{
				AdventureSummonCaskSkillEvent adventureSummonCaskSkillEvent = AdventureSummonCaskSkillEvent.Generate();
				adventureSummonCaskSkillEvent.sender = _actor;
				adventureSummonCaskSkillEvent.skillId = skillId_Boomerang;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureSummonCaskSkillEvent);
			}
			if (GetPerkLv(511911, out lv))
			{
				_actor.buffComponent.AddBuff(11951111, _actor);
			}
		}
		else if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.A && GetPerkLv(511913, out lv))
		{
			_actor.buffComponent.AddBuff(11951311, _actor);
		}
	}

	public override void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
		base.OnCastEndSkill(evt);
		HotfixEnum.skillSlotType skillSlotType = evt.skillEventInfo.skillSlotType;
		if (skillSlotType != HotfixEnum.skillSlotType.A)
		{
			_ = 2;
		}
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		base.OnBeforeHit(evt, monster);
		int lv;
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Normal))
		{
			if (GetPerkLv(511901, out lv))
			{
				monster.AddTag(tag_1);
				if (monster.GetTagCount(tag_1) >= count_1)
				{
					ILRuntimeAPI.PlayAreaEffect(_actor, area_1, monster.tsTransform.Position);
					monster.ClearTag(tag_1);
				}
			}
			if (GetPerkLv(511906, out lv))
			{
				int buffNumByID = _actor.buffComponent.GetBuffNumByID(11950611);
				if (buffNumByID > 0)
				{
					AdventureActor.AddFromAttr(11950601, _actor, buffNumByID);
				}
				if (once_ultra_6 > 0 && IsUltraCooling())
				{
					AdventureActor.AddFromAttr(once_ultra_6, _actor);
				}
			}
		}
		if (!CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MainSkill))
		{
			return;
		}
		if (GetPerkLv(511904, out lv))
		{
			AdventureActor.AddFromAttr(once_4, _actor);
		}
		if (GetPerkLv(511908, out lv) && TSVector2.Distance(monster.tsTransform.Position, _actor.tsTransform.Position) > dis_8)
		{
			AdventureActor.AddFromAttr(11950801, _actor);
		}
		if (GetPerkLv(511909, out lv))
		{
			int buffNumByID2 = _actor.buffComponent.GetBuffNumByID(11950911);
			if (buffNumByID2 > 0)
			{
				AdventureActor.AddFromAttr(11950901, _actor, buffNumByID2);
			}
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster)
	{
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, windHitTag) && GetPerkLv(511909, out var _) && CommonUtils.CheckElementMark(CommonDefine.Wind, monster))
		{
			_actor.buffComponent.AddBuff(11950911, _actor);
		}
		base.OnHitPost(evt, monster);
	}

	public override void OnCrit(AdventureActorReceiveCritDamageEvent evt)
	{
		base.OnCrit(evt);
		if (GetPerkLv(511907, out var _) && TSRandom.Range(0, 100) < 30)
		{
			_actor.buffComponent.AddBuff(11950711, _actor);
		}
	}

	public override void OnHurt(AdventureActorReceiveDamageEvent evt)
	{
		base.OnHurt(evt);
	}

	private void OnSpecialEntityBegin(IEvent evt)
	{
		AdventureWeaponBornEvent adventureWeaponBornEvent = evt as AdventureWeaponBornEvent;
		if (adventureWeaponBornEvent.owner.Id == _actor.Id && adventureWeaponBornEvent.sender as AdventureBoomerang != null && GetPerkLv(511905, out var _))
		{
			_actor.buffComponent.AddBuff(11950511, _actor);
		}
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		if ((evt as AdventureElementMarkTriggerEvent).elementType == HotfixEnum.elementType.AE && GetPerkLv(511912, out var _))
		{
			_actor.buffComponent.AddBuff(11951211, _actor);
		}
	}

	private bool IsUltraCooling()
	{
		int currentBindSkillId = skillMgr.GetCurrentBindSkillId(ActionKey.D);
		return skillMgr.CheckCD(currentBindSkillId);
	}

	public override void OnSkillShoot(IEvent evt)
	{
		StartCoroutine(ref corSkillShoot, DoSkillShoot(SkillScript_MainControl.shootDelay));
	}

	private IEnumerator DoSkillShoot(FP time)
	{
		ShootFirstBoomerang(_actor.tsTransform.Forward);
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(time));
		ShootFirstBoomerang(_actor.tsTransform.Forward);
	}

	private void ShootFirstBoomerang(TSVector2 dir)
	{
		NovaLogger.Debug("asdfasdfasdf");
		string boomerangPrefab = GetBoomerangPrefab();
		if (string.IsNullOrEmpty(boomerangPrefab))
		{
			return;
		}
		AdventureBoomerang adventureBoomerang = ILRuntimeAPI.Shoot(boomerangPrefab, _actor, _actor.tsTransform.Position, dir) as AdventureBoomerang;
		if (adventureBoomerang != null)
		{
			string key = (adventureBoomerang.customTag = $"{_actor.dataID}_{_boomerangIndex}");
			if (_boomerangShootCountDic == null)
			{
				_boomerangShootCountDic = new Dictionary<string, int>(5);
			}
			if (_boomerangShootCountDic.ContainsKey(key))
			{
				_boomerangShootCountDic.set_Item(key, 1);
			}
			else
			{
				_boomerangShootCountDic.Add(key, 1);
			}
			_boomerangIndex++;
		}
	}

	private void OnBoomerrangFinish(IEvent evt)
	{
		BoomerangFinishEvent boomerangFinishEvent = evt as BoomerangFinishEvent;
		if (boomerangFinishEvent.owner.Id != _actor.Id)
		{
			return;
		}
		if (_boomerangShootCountDic == null)
		{
			_boomerangShootCountDic = new Dictionary<string, int>(5);
		}
		if (boomerangFinishEvent.catchSucess)
		{
			TSVector2 dirction = _actor.tsTransform.Forward;
			if (_actor.attackTarget != null)
			{
				dirction = (_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
			}
			string tag = boomerangFinishEvent.tag;
			if (!string.IsNullOrEmpty(tag))
			{
				if (!_boomerangShootCountDic.TryGetValue(tag, out var value) || value >= spawnCount)
				{
					return;
				}
				playFX.Play(_actor, catchEffect, 1f, _actor.transform.position, _actor.transform.rotation);
				string boomerangPrefab = GetBoomerangPrefab();
				if (!string.IsNullOrEmpty(boomerangPrefab))
				{
					_ = boomerangFinishEvent.position;
					AdventureBoomerang adventureBoomerang = ILRuntimeAPI.Shoot(boomerangPrefab, _actor, _actor.tsTransform.Position, dirction) as AdventureBoomerang;
					if (adventureBoomerang != null)
					{
						adventureBoomerang.customTag = tag;
						_boomerangShootCountDic.get_Item(tag)++;
					}
				}
			}
			else
			{
				NovaLogger.Error("回旋镖标签错误");
			}
		}
		else if (!string.IsNullOrEmpty(boomerangFinishEvent.tag))
		{
			_boomerangShootCountDic.Remove(boomerangFinishEvent.tag);
		}
	}

	private string GetBoomerangPrefab()
	{
		int num = (GetPerkLv(511903, out var lv) ? 1 : 0);
		int num2 = (GetPerkLv(511904, out lv) ? 2 : 0);
		int key = num | num2;
		return dicBullutKey.get_Item(key);
	}

	private IEnumerator DoSkillHint(FP time)
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(time));
		MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintEnd", skillId);
	}
}
