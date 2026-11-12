using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11401;

public class ParallelScript_MainControl : ParallelScript
{
	private FP searchRange = 10;

	private string bullet_First = "Bullet_114_Main_Skill_Shoot";

	private string bullet_S1 = "Bullet_114_Main_Skill_Shoot";

	private int reflectCount_S1 = 5;

	private int count_S1 = 2;

	private List<TSVector2> shootOffsets_XZ = new List<TSVector2>
	{
		new TSVector2(0.7, -1),
		new TSVector2(-0.7, -1)
	};

	private List<FP> shootOffsets_Y = new List<FP> { 1.5, 1.5 };

	private FP defalultShootDistance = 5;

	private int buffId_S2 = 11401011;

	private int buffTag_S2 = CommonHelper.StringToHash("114_B1_Base");

	private int totleTime_S2 = 15;

	private string areaEffect_S2 = "AreaEffect_114_Main_Skill_Hit_Lv1";

	private string areaEffect_S2_P3 = "AreaEffect_114_Main_Skill_Hit_Lv1_Quick";

	private int shootEvent = CommonHelper.StringToHash("shootEvent");

	private readonly FP holdSkillKeyTime_P1_P2 = 1;

	private const int perkId_1 = 511401;

	private string areaEffect_1 = "AreaEffect_114_Main_Skill_Boom_P01_Big";

	private int once_1 = 11401011;

	private const int perkId_2 = 511402;

	private int count_2 = 2;

	private FP delay_2 = 0.4f;

	private int once_2 = 11402011;

	private const int perkId_3 = 511403;

	private int once_3 = 11403011;

	private const int perkId_4 = 511404;

	private int buffId_S2_4_1 = 11404011;

	private string areaEffect_S2_4_1 = "AreaEffect_114_Main_Skill_Hit_Lv2";

	private string areaEffect_S2_4_1_P3 = "AreaEffect_114_Main_Skill_Hit_Lv2_Quick";

	private int buffId_S2_4_2 = 11404012;

	private string areaEffect_S2_4_2 = "AreaEffect_114_Main_Skill_Hit_Lv3";

	private string areaEffect_S2_4_2_P3 = "AreaEffect_114_Main_Skill_Hit_Lv3_Quick";

	private int buffId_S2_4_3 = 11404013;

	private string areaEffect_S2_4_3 = "AreaEffect_114_Main_Skill_Hit_Lv4";

	private string areaEffect_S2_4_3_P3 = "AreaEffect_114_Main_Skill_Hit_Lv4_Quick";

	private int once_4 = 11404011;

	private const int perkId_5 = 511405;

	private int once_5 = 11405001;

	private int count_5 = 1;

	private const int perkId_6 = 511406;

	private int buff_6 = 11406011;

	private string bullet_6_back = "Bullet_114_Main_Skill_Shoot_P05_Re";

	private string bullet_6 = "Bullet_114_Main_Skill_Shoot_P05_Big";

	private int buff_6_dmg = 11406012;

	private const int perkId_7 = 511407;

	private int buffId_7 = 11407011;

	private int once_7_Crit = 11407002;

	private int once_7 = 11407001;

	private const int perkId_8 = 511408;

	private int once_8 = 11408001;

	private int paramId_8_cd = 11408011;

	private int hitDmgId_8 = 114508001;

	private const int perkId_9 = 511409;

	private int buff_9 = 11409011;

	private int once_9 = 11409001;

	private int once_9_crit = 11409002;

	private int paramId_9_cd = 11409011;

	private const int perkId_10 = 511410;

	private int once_10 = 11410001;

	private int buff_10 = 11410011;

	private int perkId_11 = 511411;

	private int buff_11 = 11411011;

	private int perkId_12 = 511412;

	private int buff_12 = 11412011;

	private int perkId_13 = 511413;

	private int paramId_8_hpPercent = 11413011;

	private int once_13 = 11413001;

	private List<ReflectWeapon> reflectWeapons = new List<ReflectWeapon>();

	private Dictionary<long, ReflectWeapon> dicReflectWeapon = new Dictionary<long, ReflectWeapon>();

	private List<LogicEntity> entities = new List<LogicEntity>();

	private CoroutineNode cor_1;

	private List<CoroutineNode> corList = new List<CoroutineNode>();

	private Dictionary<long, CoroutineNode> dicMonsterCor = new Dictionary<long, CoroutineNode>();

	private Dictionary<long, long> dicMonsterArea = new Dictionary<long, long>();

	private long uidGen;

	private Dictionary<long, int> dicCount = new Dictionary<long, int>();

	private Dictionary<long, FP> dicShootTime = new Dictionary<long, FP>();

	private long totleDmg;

	public override void OnEnable()
	{
		base.OnEnable();
		uidGen = 0L;
		totleDmg = 0L;
		if (GetPerk(perkId_11))
		{
			SkillInfo skillCD = skillMgr.GetSkillCD(ActionKey.A);
			skillMgr.SetSkillTotalSection(ActionKey.A, skillCD.originalTotalSectionAmount + 1, forceMaxSection: true);
		}
		if (GetPerk(511401) || GetPerk(511402))
		{
			((PlayerAdventureActor)_actor).SetActionCondition(ActionKey.B, holdSkillKeyTime_P1_P2);
		}
		else
		{
			((PlayerAdventureActor)_actor).SetActionCondition(ActionKey.B, 0);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		skillMgr.ResetSkillTotalSection(ActionKey.A);
		for (int i = 0; i < reflectWeapons.Count; i++)
		{
			if (!reflectWeapons.get_Item(i).isFinished)
			{
				reflectWeapons.get_Item(i).Finish();
			}
		}
		reflectWeapons.Clear();
		entities.Clear();
		dicReflectWeapon.Clear();
		StopCoroutine(ref cor_1);
		foreach (CoroutineNode cor in corList)
		{
			StopCoroutine(cor);
		}
		foreach (CoroutineNode value in dicMonsterCor.Values)
		{
			StopCoroutine(value);
		}
		foreach (long value2 in dicMonsterArea.Values)
		{
			ILRuntimeAPI.StopAreaEffect(value2);
		}
		corList.Clear();
		dicMonsterCor.Clear();
		dicCount.Clear();
		dicShootTime.Clear();
	}

	public override void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		base.OnCastSkill(evt);
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && GetPerk(perkId_11))
		{
			_actor.buffComponent.AddBuff(buff_11, _actor);
		}
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		base.OnBeforeHit(evt, monster);
		if (GetPerk(511401) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MS1))
		{
			AdventureActor.AddFromAttr(once_1, _actor);
		}
		if (GetPerk(511402) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MS1))
		{
			AdventureActor.AddFromAttr(once_2, _actor);
		}
		if (GetPerk(511403) && monster.buffComponent.CheckBuffByBuffTag(buffTag_S2))
		{
			AdventureActor.AddFromAttr(once_3, _actor);
		}
		if (GetPerk(511404) && (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MS2_2) || CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MS2)))
		{
			AdventureActor.AddFromAttr(once_4, _actor);
		}
		if (GetPerk(511405) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MS1))
		{
			AdventureActor.AddFromAttr(once_5, _actor);
		}
		if (GetPerk(511407) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MS1))
		{
			int buffNumByID = monster.buffComponent.GetBuffNumByID(buffId_7);
			if (buffNumByID > 0)
			{
				AdventureActor.AddFromAttr(once_7, _actor, buffNumByID);
			}
			AdventureActor.AddFromAttr(once_7_Crit, _actor);
		}
		if (GetPerk(511408) && (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MS2_2) || CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MS2)))
		{
			AdventureActor.AddFromAttr(once_8, _actor);
		}
		if (GetPerk(511409) && (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MS2_2) || CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MS2)))
		{
			AdventureActor.AddFromAttr(once_9_crit, _actor);
			if (_actor.buffComponent.CheckBuffByBuffID(buff_9))
			{
				AdventureActor.AddFromAttr(once_9, _actor);
			}
		}
		if (GetPerk(511410) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MS2_2))
		{
			int buffNumByID2 = _actor.buffComponent.GetBuffNumByID(buff_10);
			AdventureActor.AddFromAttr(once_10, _actor, buffNumByID2);
		}
		if (GetPerk(perkId_13))
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, paramId_8_hpPercent);
			if (monster.actorHealthInfo.hpPercentage > scriptValue)
			{
				AdventureActor.AddFromAttr(once_13, _actor);
			}
		}
	}

	public override void OnHitPre(AdventureActorReceiveAttackEvent evt, MonsterAdventureActor monster)
	{
		base.OnHitPre(evt, monster);
		if (!CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MS2))
		{
			return;
		}
		if (GetPerk(511404))
		{
			if (monster.buffComponent.CheckBuffByBuffID(buffId_S2))
			{
				monster.buffComponent.RemoveBuffByTag(buffTag_S2);
				monster.buffComponent.AddBuff(buffId_S2_4_1, _actor);
			}
			else if (monster.buffComponent.CheckBuffByBuffID(buffId_S2_4_1))
			{
				monster.buffComponent.RemoveBuffByTag(buffTag_S2);
				monster.buffComponent.AddBuff(buffId_S2_4_2, _actor);
			}
			else if (monster.buffComponent.CheckBuffByBuffID(buffId_S2_4_2))
			{
				monster.buffComponent.RemoveBuffByTag(buffTag_S2);
				monster.buffComponent.AddBuff(buffId_S2_4_3, _actor);
			}
			else if (monster.buffComponent.CheckBuffByBuffID(buffId_S2_4_3))
			{
				monster.buffComponent.AddBuff(buffId_S2_4_3, _actor);
			}
			else
			{
				monster.buffComponent.AddBuff(buffId_S2, _actor);
			}
		}
		else
		{
			monster.buffComponent.AddBuff(buffId_S2, _actor);
		}
		if (dicMonsterCor.TryGetValue(monster.Id, out var value))
		{
			StopCoroutine(value);
			dicMonsterCor.Remove(monster.Id);
		}
		if (dicMonsterArea.TryGetValue(monster.Id, out var value2))
		{
			ILRuntimeAPI.StopAreaEffect(value2);
			dicMonsterArea.Remove(monster.Id);
		}
		value = StartCoroutine(DotHit(monster));
		dicMonsterCor.Add(monster.Id, value);
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster)
	{
		base.OnHitPost(evt, monster);
		if (GetPerk(511406) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MS1) && evt.weapon is AdventureBulletBase adventureBulletBase && dicReflectWeapon.TryGetValue(adventureBulletBase.tagUid, out var value))
		{
			value.totleDmg += evt.damage;
		}
		if (GetPerk(511408) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Normal) && monster.buffComponent.CheckBuffByBuffTag(buffTag_S2))
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, paramId_8_cd);
			if (CheckPerkCd(511408L, scriptValue))
			{
				ILRuntimeAPI.HitActor(_actor, monster, hitDmgId_8);
			}
		}
	}

	public override void OnCrit(AdventureActorReceiveCritDamageEvent evt, bool isSelf, PlayerAdventureActor actor, MonsterAdventureActor monster)
	{
		base.OnCrit(evt, isSelf, actor, monster);
		if (!isSelf)
		{
			return;
		}
		if (GetPerk(511407) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MS1))
		{
			monster.buffComponent.AddBuff(buffId_7, _actor);
		}
		if (GetPerk(511409) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MS2))
		{
			_actor.buffComponent.AddBuff(buff_9, _actor);
			FP scriptValue = CommonUtils.GetScriptValue(_actor, paramId_9_cd);
			if (CheckPerkCd(511409L, scriptValue))
			{
				skillMgr.ResetSkillCD(ActionKey.B);
			}
		}
		if (GetPerk(511410) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_MS2_2))
		{
			_actor.buffComponent.AddBuff(buff_10, _actor);
		}
	}

	public override void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		base.OnCustomEvent(evt);
		if (evt.eventHashCode != shootEvent)
		{
			return;
		}
		if (_actor.buffComponent.CheckBuffByBuffID(buff_6) && _actor.attackTarget != null)
		{
			string bulletAlias = bullet_6;
			AdventureActor actor = _actor;
			TSVector2 position = _actor.tsTransform.Position;
			FP positionY = _actor.tsTransform.PositionY;
			LogicEntity attackTarget = _actor.attackTarget;
			ILRuntimeAPI.Shoot(bulletAlias, actor, default, position, positionY, default, attackTarget, AimType.Target, BulletDirectionType.BulletToTarget);
			_actor.buffComponent.RemoveBuffByBuffId(buff_6);
		}
		if (evt.intParam == 1)
		{
			if (GetPerk(511406))
			{
				_actor.buffComponent.AddBuff(buff_6_dmg, _actor);
			}
			CoroutineNode item = StartCoroutine(DotShoot());
			corList.Add(item);
		}
	}

	public override void OnTriggerMask(AdventureActorReceiveDamageEvent evt)
	{
		base.OnTriggerMask(evt);
		if (GetPerk(perkId_12))
		{
			_actor.buffComponent.AddBuff(buff_12, _actor);
		}
	}

	private IEnumerator DoAddBuff(TSVector2 startPos, FP startY, long uid)
	{
		string bulletAlias = bullet_6_back;
		AdventureActor actor = _actor;
		LogicEntity actor2 = _actor;
		AdventureBulletBase bullet = ILRuntimeAPI.Shoot(bulletAlias, actor, default, startPos, startY, default, actor2, AimType.Target, BulletDirectionType.BulletToTarget);
		while (!bullet.isFinished)
		{
			yield return null;
		}
		_actor.buffComponent.AddBuff(buff_6, _actor);
		if (dicReflectWeapon.TryGetValue(uid, out var value))
		{
			totleDmg += value.totleDmg;
		}
	}

	private IEnumerator DotHit(MonsterAdventureActor monster)
	{
		FP time = totleTime_S2;
		long areaEffectId = DoHit(monster);
		dicMonsterArea.Add(monster.Id, areaEffectId);
		for (; time > 0; time -= _actor.LogicDeltaTime)
		{
			if (!(monster != null))
			{
				break;
			}
			if (!monster.actorHealthInfo.isAlive)
			{
				break;
			}
			yield return null;
		}
		ILRuntimeAPI.StopAreaEffect(areaEffectId);
		if (monster != null)
		{
			dicMonsterArea.Remove(monster.Id);
			monster.buffComponent.RemoveBuffByTag(buffTag_S2);
		}
	}

	private long DoHit(MonsterAdventureActor monster)
	{
		bool perk = GetPerk(511403);
		string fxAlias = (perk ? areaEffect_S2_P3 : areaEffect_S2);
		if (monster.buffComponent.CheckBuffByBuffID(buffId_S2_4_1))
		{
			fxAlias = (perk ? areaEffect_S2_4_1_P3 : areaEffect_S2_4_1);
		}
		else if (monster.buffComponent.CheckBuffByBuffID(buffId_S2_4_2))
		{
			fxAlias = (perk ? areaEffect_S2_4_2_P3 : areaEffect_S2_4_2);
		}
		else if (monster.buffComponent.CheckBuffByBuffID(buffId_S2_4_3))
		{
			fxAlias = (perk ? areaEffect_S2_4_3_P3 : areaEffect_S2_4_3);
		}
		return ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, monster.tsTransform.Position, default, (AreaEffectEntity areaEffect) =>
		{
			AreaEffect_FollowComponent areaEffectComponent = areaEffect.GetAreaEffectComponent<AreaEffect_FollowComponent>();
			if (areaEffectComponent != null)
			{
				areaEffectComponent.targetType = AreaEffect_FollowComponent.FollowTargetType.SpecifiedTarget;
				areaEffectComponent.FollowTarget = monster;
			}
		});
	}

	private IEnumerator DotShoot()
	{
		int count = ((!GetPerk(511402)) ? 1 : count_2);
		for (int j = 0; j < count; j++)
		{
			CommonUtils.SearchNearTargetsByCircle(_actor, searchRange, isConfront: true, includeSelf: false, entities);
			if (entities.Count > 0)
			{
				if (_actor.attackTarget != null && entities.Contains(_actor.attackTarget))
				{
					entities.Remove(_actor.attackTarget);
					entities.Insert(0, _actor.attackTarget);
				}
				for (int i = 0; i < count_S1; i++)
				{
					int index = i % entities.Count;
					ReflectWeapon reflectWeapon = new ReflectWeapon();
					reflectWeapon.uid = GenUid();
					reflectWeapon.owner = _actor;
					reflectWeapon.weaponType = 1;
					reflectWeapon.reboundRange = 10;
					int reflectCount = (GetPerk(511405) ? (reflectCount_S1 + count_5) : reflectCount_S1);
					reflectWeapon.reflectCount = reflectCount;
					reflectWeapon.firBullet = bullet_First;
					reflectWeapon.sedBullet_1 = bullet_S1;
					TSVector2 shootPosXZ = _actor.tsTransform.TransformLocalPointToWorldSpace(shootOffsets_XZ.get_Item(i));
					FP shootPosY = shootOffsets_Y.get_Item(i);
					reflectWeapon.Shoot(entities.get_Item(index), shootPosXZ, shootPosY);
					reflectWeapons.Add(reflectWeapon);
					dicReflectWeapon.Add(reflectWeapon.uid, reflectWeapon);
					reflectWeapon.OnOnceFinish = (ReflectWeapon weapon) =>
					{
						if (GetPerk(511401))
						{
							ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_1, weapon.Position);
						}
					};
					reflectWeapon.OnFinish = (ReflectWeapon weapon) =>
					{
						if (GetPerk(511406))
						{
							CoroutineNode item = StartCoroutine(DoAddBuff(weapon.Position, weapon.PositionY, weapon.uid));
							corList.Add(item);
						}
					};
				}
			}
			else
			{
				TSVector2 position = _actor.tsTransform.TransformLocalPointToWorldSpace(shootOffsets_XZ.get_Item(0));
				FP positionY = shootOffsets_Y.get_Item(0);
				TSVector2 targetPosition = _actor.tsTransform.Position + _actor.tsTransform.Forward * defalultShootDistance;
				ILRuntimeAPI.Shoot(bullet_First, _actor, default, position, positionY, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
				position = _actor.tsTransform.TransformLocalPointToWorldSpace(shootOffsets_XZ.get_Item(1));
				positionY = shootOffsets_Y.get_Item(1);
				targetPosition = _actor.tsTransform.Position + _actor.tsTransform.Forward * defalultShootDistance;
				ILRuntimeAPI.Shoot(bullet_First, _actor, default, position, positionY, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
			}
			yield return _actor.WaitTime(delay_2);
		}
	}

	private long GenUid()
	{
		uidGen++;
		return uidGen;
	}
}
