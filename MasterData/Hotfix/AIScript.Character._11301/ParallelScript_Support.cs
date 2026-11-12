using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11301;

public class ParallelScript_Support : ParallelScript
{
	private int bullutTag = CommonHelper.StringToHash("SkillSup_ShuiJian");

	private const int perkId_21 = 511321;

	private int once_21 = 11321011;

	private int hitTag_21 = CommonHelper.StringToHash("113SkillSupShuiJian");

	private const int perkId_23 = 511323;

	private int once_23 = 11323011;

	private int hitTag_23 = CommonHelper.StringToHash("113SkillSupShuiJian");

	private const int perkId_25 = 511325;

	private int buffId_25 = 11325011;

	private const int perkId_26 = 511326;

	private FP radius_26 = 15;

	private int count_26 = 3;

	private int buffId_26_1 = 11326011;

	private int buffTag_26 = CommonHelper.StringToHash("113P26DeBuff");

	private int buffId_26_2 = 11326012;

	private int buffId_26_3 = 11326013;

	private const int perkId_27 = 511327;

	private int buffId_27 = 11327011;

	private const int perkId_28 = 511328;

	private int buffId_28 = 11328011;

	private FP interval_28 = 1;

	private const int perkId_29 = 511329;

	private string areaEffect_29 = "AreaEffect_11301_Skill_Support_P29_Wave";

	private FP interval_29 = 5;

	private const int perkId_30 = 511330;

	private string areaEffect_30 = "AreaEffect_11301_Skill_Support_P30_Wave";

	private FP cd_30 = 5;

	private const int perkId_31 = 511331;

	private int once_31_1 = 11331001;

	private int once_31_2 = 11331002;

	private const int perkId_32 = 511332;

	private int paramId_32_energy = 11332001;

	private int maxCount_32 = 3;

	private FP interval_32 = 5;

	private const int perkId_33 = 511333;

	private int buffId_33 = 11333011;

	private CoroutineNode corAddBuff;

	private CoroutineNode corAddBuff2;

	private CoroutineNode corCastArea;

	private List<LogicEntity> entities = new List<LogicEntity>();

	private Dictionary<long, bool> dicBullet = new Dictionary<long, bool>();

	private List<FP> triggerTimes = new List<FP>();

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_BORN", OnBulletBorn);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_BORN", OnBulletBorn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		StopCoroutine(ref corAddBuff);
		StopCoroutine(ref corAddBuff2);
		StopCoroutine(ref corCastArea);
		dicBullet.Clear();
		entities.Clear();
		triggerTimes.Clear();
	}

	public override void OnActorEnter(AdventurePlayerEnterEvent evt)
	{
		if (GetPerkLv(511326, out var lv))
		{
			StartCoroutine(ref corAddBuff, DoAddBuff());
		}
		if (GetPerkLv(511328, out lv))
		{
			StartCoroutine(ref corAddBuff2, DoAddBuff2());
		}
		if (GetPerkLv(511329, out lv))
		{
			StartCoroutine(ref corCastArea, DoCastArea());
		}
	}

	public override void OnActorLeave(AdventurePlayerLeaveEvent evt)
	{
		StopCoroutine(ref corAddBuff);
		StopCoroutine(ref corAddBuff2);
		StopCoroutine(ref corCastArea);
		_actor.buffComponent.RemoveBuffByBuffId(buffId_28);
		_actor.buffComponent.RemoveBuffByBuffId(buffId_26_2);
	}

	public override void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		base.OnCastSkill(evt);
		if (GetPerkLv(511333, out var _) && evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			Singleton<BuffManager>.Instance.AddBufftoGroup(buffId_33, _actor);
		}
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		base.OnBeforeHit(evt, monster);
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SS);
		bool flag2 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SS_Default);
		bool flag3 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra);
		if (GetPerkLv(511331, out var lv) && (flag | flag2 | flag3))
		{
			if (monster.buffComponent.CheckBuffByBuffTag(buffTag_Cold))
			{
				AdventureActor.AddFromAttr(once_31_1, _actor);
			}
			if (monster.monsterToughnessInfo.isToughnessBroken)
			{
				AdventureActor.AddFromAttr(once_31_2, _actor);
			}
		}
		if (GetPerkLv(511321, out lv) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_21))
		{
			AdventureActor.AddFromAttr(once_21, _actor);
		}
		if (GetPerkLv(511323, out lv) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_23))
		{
			AdventureActor.AddFromAttr(once_23, _actor);
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster)
	{
		base.OnHitPost(evt, monster);
		bool flag = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SS);
		bool flag2 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SS_Default);
		bool flag3 = CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Ultra);
		if (GetPerkLv(511325, out var _) && flag && (monster.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE || monster.IsBossMonster()) && evt.weapon != null && evt.weapon is AdventureBullet adventureBullet && dicBullet.TryGetValue(adventureBullet.Id, out var value))
		{
			if (!value)
			{
				_actor.buffComponent.AddBuff(buffId_25, _actor);
			}
			dicBullet.set_Item(adventureBullet.Id, true);
		}
		if (GetPerkLv(511326, out var lv2) && flag)
		{
			monster.buffComponent.AddBuff(buffId_26_1, _actor);
		}
		if (GetPerkLv(511327, out lv2) && flag)
		{
			_actor.buffComponent.AddBuff(buffId_27, _actor);
		}
		if (GetPerkLv(511330, out lv2) && (flag | flag2 | flag3) && evt.isKill && CheckCd(511330, cd_30))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_30, monster.tsTransform.Position, _actor.tsTransform.Rotation);
		}
		if (!GetPerkLv(511332, out lv2) || !(flag | flag2 | flag3))
		{
			return;
		}
		BuffCom buffComponent = monster.buffComponent;
		if (!evt.isKill || (!buffComponent.CheckBuffByBuffTag(buffTag_Frozen) && !buffComponent.CheckBuffByBuffTag(buffTag_Cold) && !buffComponent.CheckBuffByBuffTag(CommonDefine.WaterMark1)))
		{
			return;
		}
		FP logicTime = _actor.LogicTime;
		FP fP = _actor.LogicTime - interval_32;
		for (int num = triggerTimes.Count - 1; num >= 0; num--)
		{
			if (triggerTimes.get_Item(num) < fP)
			{
				triggerTimes.RemoveAt(num);
			}
		}
		if (triggerTimes.Count < maxCount_32)
		{
			skillMgr.AddEnergy(CommonUtils.GetScriptValue(_actor, paramId_32_energy));
			triggerTimes.Add(logicTime);
		}
	}

	private void OnBulletBorn(IEvent evt)
	{
		AdventureBulletBornEvent adventureBulletBornEvent = evt as AdventureBulletBornEvent;
		if (adventureBulletBornEvent.owner != null && adventureBulletBornEvent.owner.Id == _actor.Id && adventureBulletBornEvent.bulletHashCode == bullutTag)
		{
			AdventureBullet adventureBullet = adventureBulletBornEvent.sender as AdventureBullet;
			if (adventureBullet != null)
			{
				dicBullet.Add(adventureBullet.Id, value: false);
			}
		}
	}

	private void OnBulletFinish(IEvent evt)
	{
		AdventureBulletFinishEvent adventureBulletFinishEvent = evt as AdventureBulletFinishEvent;
		if (adventureBulletFinishEvent.owner != null && adventureBulletFinishEvent.owner.Id == _actor.Id && adventureBulletFinishEvent.bulletHashCode == bullutTag)
		{
			AdventureBullet adventureBullet = adventureBulletFinishEvent.sender as AdventureBullet;
			if (adventureBullet != null)
			{
				dicBullet.Remove(adventureBullet.Id);
			}
		}
	}

	private IEnumerator DoAddBuff()
	{
		while (true)
		{
			if (!_actor.buffComponent.CheckBuffByBuffID(buffId_26_1))
			{
				CommonUtils.SearchNearTargetsByCircle(_actor, radius_26, isConfront: true, includeSelf: false, entities);
				if (entities.Count > 0 && entities.FindAll((LogicEntity x) => (x as AdventureActor).buffComponent.CheckBuffByBuffTag(buffTag_26)).Count >= count_26)
				{
					_actor.buffComponent.AddBuff(buffId_26_2, _actor);
				}
			}
			yield return null;
		}
	}

	private IEnumerator DoAddBuff2()
	{
		FP timer = 0;
		while (true)
		{
			if (_actor.movementState == ActorState.StandBy)
			{
				if (timer >= interval_28)
				{
					_actor.buffComponent.AddBuff(buffId_28, _actor);
					timer = 0;
				}
			}
			else
			{
				timer = 0;
			}
			yield return null;
			timer += _actor.LogicDeltaTime;
		}
	}

	private IEnumerator DoCastArea()
	{
		FP timer = 0;
		while (true)
		{
			if (timer >= interval_29)
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_29, _actor.tsTransform.Position, _actor.tsTransform.Rotation);
				timer = 0;
			}
			yield return null;
			timer += _actor.LogicDeltaTime;
		}
	}
}
