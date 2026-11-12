using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using Nova.Hotfix;
using TrueSync;

namespace AIScript.Character._11101;

public class ParallelScript_MainControl : ParallelScript
{
	public int bullutTag = CommonHelper.StringToHash("111_B2_Bullet");

	public int hitTag_mid = CommonHelper.StringToHash("111_B1_Skill");

	public int hitTag_big = CommonHelper.StringToHash("111_B1P01_Skill");

	public int hitTag_aoe_small = CommonHelper.StringToHash("111_B1P02_Skill");

	public int hitTag_aoe_big = CommonHelper.StringToHash("111_B1P01P02_Skill");

	public int hitTag_small_P6 = CommonHelper.StringToHash("111_Attack_P06");

	public int hitTag_normal_Melee = CommonHelper.StringToHash("111_Attack_Melee");

	public int skillId_S1 = 11131001;

	public int skillId_S1_2 = 11131002;

	public int skillId_S2 = 11131003;

	private const int perkId_1 = 511101;

	private int buffId_1 = 11150111;

	private int buffId_1_Fbx = 11150112;

	private int maxCount_1 = 20;

	private const int perkId_2 = 511102;

	private FP interval_2 = 12;

	private string aoe_2_small = "AreaEffect_11101_B1P02_Skill_IceBolt_Boom";

	private string aoe_2_big = "AreaEffect_11101_B1P01P02_Skill_IceBolt_Boom";

	private const int perkId_3 = 511103;

	private const int perkId_4 = 511104;

	private readonly FP cd_4 = 0;

	private string areaEffect_4 = "AreaEffect_11101_B1P04_Skill_IceFalling";

	private FP interval_4 = 1;

	private int maxCount_4 = 3;

	private const int perkId_5 = 511105;

	private const int once_5 = 11150501;

	private const int perkId_6 = 511106;

	private readonly FP cd_6 = 0;

	private const int once_6 = 11150601;

	private const int perkId_7 = 511107;

	private readonly FP cd_7 = 0;

	private int paramId_7_interval = 11150711;

	private const int buff_7 = 11150711;

	private const int perkId_8 = 511108;

	private readonly FP cd_8 = 0.5;

	private int hitDmg_8 = 111508001;

	private const int perkId_9 = 511109;

	private FP cd_9 = 12;

	private int buffId_9 = 11150911;

	private const int perkId_11 = 511111;

	private const int parameterId_11 = 11151101;

	private string aoe_11 = "AreaEffect_11101_Perk11_IceBoom";

	private const int perkId_12 = 511112;

	private readonly FP cd_12 = 1;

	private int buffId_12 = 11151211;

	private const int parameterId_12 = 11151211;

	private int once_12 = 11151201;

	private const int perkId_13 = 511113;

	private const int buffId_13 = 11151311;

	private FP timer_2;

	private CoroutineNode corBuff;

	private CoroutineNode corRebind;

	private FP resetSkillTime;

	private bool hit_2;

	private bool isInS2;

	private List<FP> triggerTimes = new List<FP>();

	private CoroutineNode corHit;

	public override void OnEnable()
	{
		base.OnEnable();
		timer_2 = 0;
		hit_2 = false;
		isInS2 = false;
		Skill skill = Singleton<HotfixDataController>.Instance.GetSkill(skillId_S2);
		resetSkillTime = FP.FromMyriad(skill.UseTimeHint);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_BORN", OnBulletBorn);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
		if (GetPerkLv(511107, out var lv))
		{
			StartCoroutine(ref corBuff, IntervalBuff(lv));
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_BORN", OnBulletBorn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		StopCoroutine(ref corBuff);
		StopCoroutine(ref corRebind);
		StopCoroutine(ref corHit);
		triggerTimes.Clear();
	}

	public override void OnRebindSkill(AdventurRebindSkill evt)
	{
		base.OnRebindSkill(evt);
		if (evt.skillId == skillId_S1)
		{
			isInS2 = false;
			StopCoroutine(ref corRebind);
			ResetSkill_1();
		}
		skillMgr.BindSkillIdToButton(evt.slotKey, evt.skillId);
		MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintActive", skillId_S1_2, evt.skillId == skillId_S1_2);
		if (evt.skillId == skillId_S2)
		{
			isInS2 = true;
			StartCoroutine(ref corRebind, ResetSkill());
		}
	}

	public override void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		base.OnCastSkill(evt);
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			if (GetPerkLv(511101, out var lv) && evt.skillEventInfo.skillId == skillId_S1_2)
			{
				MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintActive", skillId_S1_2, a2: false);
			}
			if (GetPerkLv(511109, out lv))
			{
				_actor.buffComponent.AddBuff(buffId_9, _actor);
				_actor.EnableSuperArmor();
			}
		}
	}

	public override void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
		base.OnCastEndSkill(evt);
		if (evt.skillEventInfo.skillSlotType != HotfixEnum.skillSlotType.B)
		{
			return;
		}
		if (GetPerkLv(511101, out var lv))
		{
			if (evt.skillEventInfo.skillId == skillId_S1 || evt.skillEventInfo.skillId == skillId_S1_2)
			{
				_actor.buffComponent.RemoveBuffByBuffId(buffId_1);
				_actor.buffComponent.RemoveBuffByBuffId(buffId_1_Fbx);
			}
			if (!isInS2 && evt.skillEventInfo.skillId == skillId_S1_2)
			{
				StopCoroutine(ref corRebind);
				skillMgr.BindSkillIdToButton(ActionKey.B, skillId_S1, resetSection: true);
			}
		}
		if (GetPerkLv(511107, out lv))
		{
			_actor.buffComponent.RemoveBuffByBuffId(11150711);
		}
		if (GetPerkLv(511109, out lv))
		{
			_actor.buffComponent.RemoveBuffByBuffId(buffId_9);
			_actor.DisableSuperArmor();
		}
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		base.OnBeforeHit(evt, monster);
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Normal);
		bool flag2 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_S2P5);
		int lv;
		if (flag)
		{
			if (GetPerkLv(511105, out lv))
			{
				AdventureActor.AddFromAttr(11150501, _actor);
			}
			if (GetPerkLv(511106, out lv) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_small_P6))
			{
				AdventureActor.AddFromAttr(11150601, _actor);
			}
			if (GetPerkLv(511112, out lv) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_normal_Melee))
			{
				AdventureActor.AddFromAttr(once_12, _actor);
			}
		}
		if (flag2 && GetPerkLv(511105, out lv))
		{
			AdventureActor.AddFromAttr(11150501, _actor);
		}
	}

	public override void OnHitPre(AdventureActorReceiveAttackEvent evt, MonsterAdventureActor monster)
	{
		base.OnHitPre(evt, monster);
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Normal);
		bool flag2 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Skill);
		bool flag3 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra);
		int lv;
		if (flag)
		{
			if (!GetPerkLv(511101, out lv))
			{
				return;
			}
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(buffId_1);
			if (buffNumByID < maxCount_1)
			{
				_actor.buffComponent.AddBuff(buffId_1, _actor);
				if (buffNumByID + 1 == maxCount_1)
				{
					_actor.buffComponent.AddBuff(buffId_1_Fbx, _actor);
					AdventurRebindSkill adventurRebindSkill = AdventurRebindSkill.Generate();
					adventurRebindSkill.sender = _actor;
					adventurRebindSkill.slotKey = ActionKey.B;
					adventurRebindSkill.skillId = skillId_S1_2;
					ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventurRebindSkill);
				}
			}
		}
		else if (flag2)
		{
			bool flag4 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_mid);
			bool flag5 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_big);
			if (GetPerkLv(511102, out lv) && hit_2)
			{
				if (flag4)
				{
					ILRuntimeAPI.PlayAreaEffect(_actor, aoe_2_small, monster.tsTransform.Position);
				}
				else if (flag5)
				{
					ILRuntimeAPI.PlayAreaEffect(_actor, aoe_2_big, monster.tsTransform.Position);
				}
			}
		}
		else if (flag3 && GetPerkLv(511113, out lv) && TriggerMask(monster, evt.hitDamageTag, ignoreHitTag: true))
		{
			_actor.buffComponent.AddBuff(11151311, _actor);
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster)
	{
		base.OnHitPost(evt, monster);
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Normal);
		bool flag2 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Skill);
		CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra);
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_aoe_small))
		{
			if (monster.buffComponent.CheckBuffByBuffID(buffA))
			{
				monster.buffComponent.RemoveBuffByBuffId(buffA);
				monster.buffComponent.AddBuff(buffB, _actor);
			}
		}
		else if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_aoe_big))
		{
			monster.buffComponent.RemoveBuffByBuffId(buffA);
			monster.buffComponent.AddBuff(buffB, _actor);
		}
		int lv;
		if (flag)
		{
			if (GetPerkLv(511112, out lv) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_normal_Melee) && TSRandom.Range(0, 100) < CommonUtils.GetScriptValue(_actor, 11151211))
			{
				monster.buffComponent.AddBuff(buffId_12, _actor);
			}
		}
		else
		{
			if (!flag2)
			{
				return;
			}
			if (GetPerkLv(511108, out lv) && evt.isCrit)
			{
				StartCoroutine(ref corHit, DelayHit(monster));
			}
			if (!TriggerMask(monster, evt.hitDamageTag) || !GetPerkLv(511104, out var _))
			{
				return;
			}
			FP logicTime = _actor.LogicTime;
			FP fP = _actor.LogicTime - interval_4;
			for (int num = triggerTimes.Count - 1; num >= 0; num--)
			{
				if (triggerTimes.get_Item(num) < fP)
				{
					triggerTimes.RemoveAt(num);
				}
			}
			if (triggerTimes.Count >= maxCount_4)
			{
				return;
			}
			ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_4, monster.tsTransform.Position, default, (AreaEffectEntity areaEntity) =>
			{
				AreaEffect_FollowComponent component = areaEntity.GetComponent<AreaEffect_FollowComponent>();
				if (component != null)
				{
					component.FollowTarget = monster;
				}
			});
			triggerTimes.Add(logicTime);
		}
	}

	public override void OnHurt(AdventureActorReceiveDamageEvent evt)
	{
		base.OnHurt(evt);
		if (GetPerkLv(511111, out var _) && evt.attackType == DamageType.Melee && CheckCd(511111, CommonUtils.GetScriptValue(_actor, 11151101)))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, aoe_11, _actor.tsTransform.Position);
		}
	}

	private void OnBulletBorn(IEvent evt)
	{
		AdventureBulletBornEvent adventureBulletBornEvent = evt as AdventureBulletBornEvent;
		if (adventureBulletBornEvent.owner != null && adventureBulletBornEvent.owner.Id == _actor.Id && adventureBulletBornEvent.bulletHashCode == bullutTag && adventureBulletBornEvent.sender as AdventureBullet != null && GetPerkLv(511102, out var _) && (_actor.LogicTime - timer_2 > interval_2 || timer_2 == 0))
		{
			timer_2 = _actor.LogicTime;
			hit_2 = true;
		}
	}

	private void OnBulletFinish(IEvent evt)
	{
		AdventureBulletFinishEvent adventureBulletFinishEvent = evt as AdventureBulletFinishEvent;
		if (adventureBulletFinishEvent.owner != null && adventureBulletFinishEvent.owner.Id == _actor.Id && adventureBulletFinishEvent.bulletHashCode == bullutTag && adventureBulletFinishEvent.sender as AdventureBullet != null)
		{
			hit_2 = false;
		}
	}

	private IEnumerator DelayHit(AdventureActor monster)
	{
		yield return null;
		if (monster != null)
		{
			ILRuntimeAPI.HitActor(_actor, monster, hitDmg_8);
		}
	}

	private IEnumerator IntervalBuff(int lv)
	{
		while (true)
		{
			_actor.buffComponent.AddBuff(11150711, _actor);
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(CommonUtils.GetScriptValue(_actor, paramId_7_interval)));
		}
	}

	private IEnumerator ResetSkill()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(resetSkillTime));
		isInS2 = false;
		ResetSkill_1();
	}

	private void ResetSkill_1()
	{
		if (GetPerkLv(511101, out var _))
		{
			if (_actor.buffComponent.GetBuffNumByID(buffId_1) >= maxCount_1)
			{
				skillMgr.BindSkillIdToButton(ActionKey.B, skillId_S1_2, resetSection: true);
			}
			else
			{
				skillMgr.BindSkillIdToButton(ActionKey.B, skillId_S1, resetSection: true);
			}
		}
		else
		{
			skillMgr.BindSkillIdToButton(ActionKey.B, skillId_S1, resetSection: true);
		}
	}
}
