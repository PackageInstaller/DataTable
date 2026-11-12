using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._12601;

public class ParallelScript_Support : ParallelScript
{
	private readonly string evt_Attack = "126SupportAttack";

	private readonly int flameButterflyCount = 3;

	private readonly int ashButterflyCount = 3;

	private readonly FP searchRadius = 12;

	private readonly List<string> bullut_flameButter_Base = new List<string> { "Bullet_12601_Skill2_ButterflyFire_1", "Bullet_12601_Skill2_ButterflyFire_2", "Bullet_12601_Skill2_ButterflyFire_3", "Bullet_12601_Skill2_ButterflyFire_4", "Bullet_12601_Skill2_ButterflyFire_5" };

	private readonly TSVector shootOffset = new TSVector(0, 1.5, 0);

	private readonly string bullut_flameButter_Prek22 = "Bullet_12601_Skill2_ButterflyFire_Perk22";

	private readonly string bullut_flameButter_Prek22TargetSelf = "Bullet_12601_Skill2_ButterflyFire_Perk22_Self";

	private readonly List<string> bullut_flameButter_Prek24 = new List<string> { "Bullet_12601_Skill2_ButterflyFire_Perk24_1", "Bullet_12601_Skill2_ButterflyFire_Perk24_2" };

	private readonly TSVector shootOffset_24 = new TSVector(0, 1.5, -1);

	private readonly List<string> bullut_flameButter_Prek27 = new List<string> { "Bullet_12601_Skill2_ButterflyFire_Perk27_1", "Bullet_12601_Skill2_ButterflyFire_Perk27_2" };

	private readonly TSVector shootOffset_27 = new TSVector(0, 1.5, 0);

	private readonly List<string> bullut_flameButter_Prek30 = new List<string> { "Bullet_12601_Skill2_ButterflyFire_Perk30_2", "Bullet_12601_Skill2_ButterflyFire_Perk30_3", "Bullet_12601_Skill2_ButterflyFire_Perk30_1", "Bullet_12601_Skill2_ButterflyFire_Perk30_4", "Bullet_12601_Skill2_ButterflyFire_Perk30_5" };

	private readonly TSVector shootOffset_30 = new TSVector(0, 1.5, -0.7);

	private readonly int flameTotemBuffId = 12632001;

	private readonly int frBuffId = 12632012;

	private readonly int critBuffId = 12632003;

	private static readonly int fireButterflyTag = CommonHelper.StringToHash("126_FireButterfly");

	private static readonly int ashButterflyTag = CommonHelper.StringToHash("126_AshButterfly");

	private readonly FP radiusOffest = 0.3;

	private readonly FP posYOffest = 1;

	private readonly string fx_KillMonster_Name = "Actor/Character/12601/FX/fx_12601_bullet_B2_Skill_butterfly_fire";

	private readonly string bullut_flameButter_KillMonster = "Bullet_12601_Skill2_ButterflyFire";

	private readonly int buffId_Support = 12693015;

	private readonly int perkId_21 = 512621;

	private static readonly int fireButterIncDamage = CommonHelper.StringToHash("126_B2");

	private readonly int flameButterfly_P21_Count = 5;

	private static readonly int perk21_Tag = CommonHelper.StringToHash("126_FireButterfly");

	private readonly int buffId_21 = 12652111;

	private readonly int perkId_22 = 512622;

	private readonly int prob_22 = 35;

	private readonly FP cd_22 = 1;

	private readonly int perkId_23 = 512623;

	private readonly int ashButterfly_P23_Count = 5;

	private readonly int buffId_23 = 12652311;

	private readonly int perkId_24 = 512624;

	private readonly int prob_24 = 20;

	private readonly int damage_24 = 12652401;

	private readonly string FX_PrekId_24 = "Actor/Character/12601/FX/fx_12601_base_B2_Skill_Perk24_flash";

	private readonly FP cd_24 = 1;

	private readonly int perkId_25 = 512625;

	private readonly int damage_25 = 12652501;

	private readonly int perkId_26 = 512626;

	private readonly int buffId_26 = 12652611;

	private readonly int perkId_27 = 512627;

	private readonly FP cd_27 = 1;

	private readonly int buffId_27 = 12652711;

	private readonly int perkId_28 = 512628;

	private readonly int buffId_28 = 12652811;

	private readonly int perkId_29 = 512629;

	private readonly int buffId_29 = 12652911;

	private readonly int perkId_30 = 512630;

	private readonly FP perkId_30_ShootInterval = 0.08;

	private readonly string FX_PrekId_30 = "Actor/Character/12601/FX/fx_12601_base_B2_Skill_Perk30_flash_2";

	private readonly int perkId_31 = 512631;

	private readonly int buffId_31 = 12653111;

	private readonly int perkId_32 = 512632;

	private readonly FP cd_32 = 6;

	private readonly int buffId_32 = 12653211;

	private readonly int perkId_33 = 512633;

	private readonly int buffId_33 = 12653311;

	private int ShootButtleCount;

	private CoroutineNode UpdateCheck;

	private FP passiveCD22;

	private FP passiveCD24;

	private FP passiveCD27;

	private FP passiveCD32;

	private CoroutineNode CorShootPrek30;

	private Dictionary<long, string> baseButtleAimMonsterTag = new Dictionary<long, string>();

	private List<long> baseButtleKillMonster = new List<long>();

	private List<CoroutineNode> corGetTargetList = new List<CoroutineNode>();

	private List<LogicEntity> _targets;

	private List<LogicEntity> _targets_Prek30;

	private int killedGetTargetMaxCount = 14;

	public override void OnEnable()
	{
		passiveCD22 = 0;
		passiveCD24 = 0;
		passiveCD27 = 0;
		passiveCD32 = 0;
		baseButtleAimMonsterTag.Clear();
		baseButtleKillMonster.Clear();
		corGetTargetList.Clear();
		base.OnEnable();
		if (GetPerkLv(perkId_26, out var _))
		{
			if (UpdateCheck != null)
			{
				_actor.StopLogicCoroutine(UpdateCheck);
				UpdateCheck = null;
			}
			UpdateCheck = _actor.StartLogicCoroutine(UpdateCheck_Prep26());
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		if (UpdateCheck != null)
		{
			_actor.StopLogicCoroutine(UpdateCheck);
			UpdateCheck = null;
		}
		for (int i = 0; i < corGetTargetList.Count; i++)
		{
			_actor.StopLogicCoroutine(corGetTargetList.get_Item(i));
		}
		corGetTargetList.Clear();
		if (CorShootPrek30 != null)
		{
			_actor.StopLogicCoroutine(CorShootPrek30);
			CorShootPrek30 = null;
		}
	}

	protected override void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		base.OnCustomEvent(evt);
		if (!(evt.eventName == evt_Attack))
		{
			return;
		}
		ShootButtleCount = flameButterflyCount;
		if (GetPerkLv(perkId_21, out var lv))
		{
			ShootButtleCount = flameButterfly_P21_Count;
		}
		ILRuntimeAPI.SearchByRangeAndPosition(_actor, _actor.tsTransform.Position, searchRadius, OnSearchTargetFinish, isConfront: true);
		AddAshButterfly();
		if (GetPerkLv(perkId_23, out lv) && mainCtrActor.actorElementInfo.elementType == HotfixEnum.elementType.FE)
		{
			mainCtrActor.buffComponent.AddBuff(buffId_23, _actor);
		}
		if (GetPerkLv(perkId_27, out lv))
		{
			mainCtrActor.buffComponent.AddBuff(buffId_27, _actor);
		}
		if (GetPerkLv(perkId_31, out lv))
		{
			for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
			{
				PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
				if (playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.FE)
				{
					playerAdventureActor.buffComponent.AddBuff(buffId_31, _actor);
				}
			}
		}
		mainCtrActor.buffComponent.AddBuff(buffId_Support, _actor);
	}

	private void SearchConfrontMonster(LogicEntity ShotEntity, int count, string buttleName, string buttleTargetSelfName)
	{
		DeterministicShape deterministicCircleShape = CommonUtils.GetDeterministicCircleShape(searchRadius, 0, ShotEntity.tsTransform.Position);
		List<LogicEntity> monstersFromShape = ILRuntimeAPI.GetMonstersFromShape(_actor, deterministicCircleShape);
		if (monstersFromShape.Count > 0)
		{
			for (int num = monstersFromShape.Count - 1; num >= 0; num--)
			{
				LogicEntity logicEntity = monstersFromShape.get_Item(num);
				AdventureActor component = logicEntity.GetComponent<AdventureActor>();
				if (logicEntity.Id == ShotEntity.Id || (component != null && (!component.actorHealthInfo.isAlive || component.state == ActorState.Spawn || component.state == ActorState.Death || logicEntity.IsSearchedImmunity())))
				{
					monstersFromShape.RemoveAt(num);
				}
			}
		}
		if (monstersFromShape.Count > 0)
		{
			monstersFromShape.Sort((LogicEntity x, LogicEntity y) => (!(TSVector2.Distance(x.tsTransform.Position, ShotEntity.tsTransform.Position) < TSVector2.Distance(y.tsTransform.Position, ShotEntity.tsTransform.Position))) ? 1 : (-1));
			for (int num2 = 0; num2 < count; num2++)
			{
				int index = num2 % monstersFromShape.Count;
				FP fP = 1;
				DeterministicCollider logicComponent = monstersFromShape.get_Item(index).GetLogicComponent<DeterministicCollider>();
				if (logicComponent != null)
				{
					fP = logicComponent.Radius + radiusOffest;
				}
				string text = "126_Split_" + monstersFromShape.get_Item(index).Id;
				if (!baseButtleAimMonsterTag.ContainsKey(monstersFromShape.get_Item(index).Id))
				{
					baseButtleAimMonsterTag.Add(monstersFromShape.get_Item(index).Id, text);
				}
				AdventureActor actor = _actor;
				FP range = 0;
				TSVector2 position = ShotEntity.tsTransform.Position + (monstersFromShape.get_Item(index).tsTransform.Position - ShotEntity.tsTransform.Position).normalized * fP;
				FP positionY = posYOffest;
				LogicEntity target = monstersFromShape.get_Item(index);
				ILRuntimeAPI.Shoot(buttleName, actor, range, position, positionY, default, target, AimType.Target, BulletDirectionType.BulletToTarget).bulletTag = text;
			}
		}
		else
		{
			FP fP2 = 1;
			DeterministicCollider logicComponent2 = ShotEntity.GetLogicComponent<DeterministicCollider>();
			if (logicComponent2 != null)
			{
				fP2 = logicComponent2.Radius + radiusOffest;
			}
			string text2 = "126_Split_" + ShotEntity.Id;
			if (!baseButtleAimMonsterTag.ContainsKey(ShotEntity.Id))
			{
				baseButtleAimMonsterTag.Add(ShotEntity.Id, text2);
			}
			GameObject bulletByAlias = ModuleController<AdventureModuleController>.Instance.GetBulletByAlias(_actor, buttleTargetSelfName);
			mainCtrActor.shootBehaviour.Shoot(bulletByAlias, ShotEntity.tsTransform.Position + (ShotEntity.tsTransform.Position - mainCtrActor.tsTransform.Position).normalized * fP2, posYOffest, mainCtrActor.tsTransform.Forward, null, ShotEntity, useShootDeviationCalcScatteringRadius: false, default, AimType.Forward).bulletTag = text2;
		}
	}

	private void ShotBullet(LogicEntity ShotEntity, LogicEntity entity, string tmpBullet, TSVector offest)
	{
		TSVector2 position = ShotEntity.tsTransform.Position + ShotEntity.tsTransform.Left * offest.x + ShotEntity.tsTransform.Forward * offest.z;
		ILRuntimeAPI.Shoot(tmpBullet, _actor, 0, position, offest.y, default, entity, AimType.Target, BulletDirectionType.BulletToTarget);
	}

	private void AddAshButterfly()
	{
		int num = ashButterflyCount;
		if (GetPerkLv(perkId_23, out var lv))
		{
			num = ashButterfly_P23_Count;
		}
		mainCtrActor.buffComponent.AddBuffNum(critBuffId, num, _actor);
		if (GetPerkLv(perkId_29, out lv) && mainCtrActor.actorElementInfo.elementType == HotfixEnum.elementType.FE)
		{
			mainCtrActor.buffComponent.AddBuffNum(buffId_29, num, _actor);
		}
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent _evt)
	{
		base.OnBeforeHit(_evt);
		PlayerAdventureActor playerAdventureActor = _evt.from as PlayerAdventureActor;
		if (!(playerAdventureActor != null) || playerAdventureActor.dataID != mainCtrActor.dataID || playerAdventureActor.actorElementInfo.elementType != HotfixEnum.elementType.FE)
		{
			return;
		}
		if (GetPerkLv(perkId_22, out var lv) && _evt.elementType == HotfixEnum.elementType.FE)
		{
			MonsterAdventureActor monsterAdventureActor = _evt.to as MonsterAdventureActor;
			if (monsterAdventureActor != null)
			{
				int num = monsterAdventureActor.buffComponent.GetBuffNumByID(flameTotemBuffId) * prob_22;
				if (TSRandom.Range(0, 100) < num && (_actor.LogicTime - passiveCD22 >= cd_22 || passiveCD22 == 0))
				{
					passiveCD22 = _actor.LogicTime;
					SearchConfrontMonster(monsterAdventureActor, 1, bullut_flameButter_Prek22, bullut_flameButter_Prek22TargetSelf);
				}
			}
		}
		if (GetPerkLv(perkId_24, out lv) && _evt.elementType == HotfixEnum.elementType.FE)
		{
			MonsterAdventureActor monsterAdventureActor2 = _evt.to as MonsterAdventureActor;
			if (monsterAdventureActor2 != null)
			{
				int num2 = mainCtrActor.buffComponent.GetBuffNumByID(critBuffId) * prob_24;
				if (TSRandom.Range(0, 100) < num2 && (_actor.LogicTime - passiveCD24 >= cd_24 || passiveCD24 == 0))
				{
					passiveCD24 = _actor.LogicTime;
					AdventureActor.AddFromAttr(damage_24, _actor);
					string tmpBullet = bullut_flameButter_Prek24.get_Item(TSRandom.Range(0, bullut_flameButter_Prek24.Count));
					ShotBullet(mainCtrActor, monsterAdventureActor2, tmpBullet, shootOffset_24);
					new PlayFX().Play(mainCtrActor, FX_PrekId_24, 1f, mainCtrActor.transform.position, mainCtrActor.transform.rotation);
				}
			}
		}
		if (GetPerkLv(perkId_25, out lv))
		{
			MonsterAdventureActor monsterAdventureActor3 = _evt.to as MonsterAdventureActor;
			if (monsterAdventureActor3 != null && monsterAdventureActor3.buffComponent.CheckBuffByBuffTag(fireButterflyTag))
			{
				AdventureActor.AddFromAttr(damage_25, _actor);
			}
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent _evt)
	{
		base.OnHitPost(_evt);
		MonsterAdventureActor monsterAdventureActor = _evt.to as MonsterAdventureActor;
		_ = _evt.from;
		if (GetPerkLv(perkId_21, out var lv) && monsterAdventureActor != null && _evt.hitDamageTag != null && CommonUtils.CheckHitByTag(_evt.hitDamageTag, perk21_Tag) && monsterAdventureActor.buffComponent != null)
		{
			monsterAdventureActor.buffComponent.AddBuff(buffId_21, _actor);
		}
		if (GetPerkLv(perkId_33, out lv) && monsterAdventureActor != null && _evt.hitDamageTag != null && CommonUtils.CheckHitByTag(_evt.hitDamageTag, fireButterIncDamage))
		{
			monsterAdventureActor.buffComponent.AddBuff(buffId_33, _actor);
		}
	}

	protected override void OnCrit(AdventureActorReceiveCritDamageEvent _evt)
	{
		base.OnCrit(_evt);
		if (GetPerkLv(perkId_27, out var lv) && ((_actor != null && _actor.Id == _evt.from.Id) || (mainCtrActor != null && mainCtrActor.Id == _evt.from.Id)) && (_actor.LogicTime - passiveCD27 >= cd_27 || passiveCD27 == 0))
		{
			MonsterAdventureActor entity = _evt.to as MonsterAdventureActor;
			passiveCD27 = _actor.LogicTime;
			string tmpBullet = bullut_flameButter_Prek27.get_Item(TSRandom.Range(0, bullut_flameButter_Prek27.Count));
			ShotBullet(mainCtrActor, entity, tmpBullet, shootOffset_27);
		}
		if (GetPerkLv(perkId_28, out lv) && _evt.from.Id == mainCtrActor.Id)
		{
			mainCtrActor.buffComponent.AddBuff(buffId_28, _actor);
		}
		if (GetPerkLv(perkId_32, out lv) && (_actor.LogicTime - passiveCD32 >= cd_32 || passiveCD32 == 0))
		{
			passiveCD32 = _actor.LogicTime;
			mainCtrActor.buffComponent.AddBuff(buffId_32, _actor);
		}
	}

	protected override void OnRemoveBuff(AdventureActorRemoveBuff evt)
	{
		base.OnRemoveBuff(evt);
		if (GetPerkLv(perkId_30, out var _) && evt.eventInfo.buffTags.Contains(ashButterflyTag))
		{
			new PlayFX().Play(mainCtrActor, FX_PrekId_30, 1f, mainCtrActor.transform.position, mainCtrActor.transform.rotation);
			ILRuntimeAPI.SearchByRangeAndPosition(_actor, mainCtrActor.tsTransform.Position, searchRadius, OnSearchTargetFinish_Prek30, isConfront: true);
		}
	}

	private IEnumerator UpdateCheck_Prep26()
	{
		while (true)
		{
			foreach (LogicEntity monsterActor in ModuleController<AdventureModuleController>.Instance.monsterActors)
			{
				if ((monsterActor as AdventureActor).buffComponent.CheckBuffByBuffTag(fireButterflyTag))
				{
					mainCtrActor.buffComponent.AddBuff(buffId_26, _actor);
				}
			}
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(1));
		}
	}

	private void OnSearchTargetFinish(List<LogicEntity> targets)
	{
		if (targets == null || targets.Count <= 0)
		{
			for (int i = 0; i < ShootButtleCount; i++)
			{
				ILRuntimeAPI.Shoot(bullut_flameButter_Base.get_Item(i), position: _actor.tsTransform.Position + _actor.tsTransform.Left * shootOffset.x + _actor.tsTransform.Forward * shootOffset.z, targetPosition: _actor.tsTransform.Position + _actor.tsTransform.Forward * searchRadius, actor: _actor, range: default, positionY: shootOffset.y, target: null, aimType: AimType.Position, bulletDirectionType: BulletDirectionType.BulletToTarget);
			}
		}
		else
		{
			if (bullut_flameButter_Base.Count <= 0)
			{
				return;
			}
			if (_targets == null)
			{
				_targets = new List<LogicEntity>(10);
			}
			else
			{
				_targets.Clear();
			}
			targets.Sort((LogicEntity x, LogicEntity y) => (!(TSVector2.Distance(x.tsTransform.Position, _actor.tsTransform.Position) < TSVector2.Distance(y.tsTransform.Position, _actor.tsTransform.Position))) ? 1 : (-1));
			bool flag = false;
			if (_actor.attackTarget != null)
			{
				for (int num = 0; num < targets.Count; num++)
				{
					if (targets.get_Item(num).Id == _actor.attackTarget.Id)
					{
						_targets.Add(targets.get_Item(num));
						flag = true;
						break;
					}
				}
				for (int num2 = 0; num2 < targets.Count; num2++)
				{
					if (targets.get_Item(num2).Id != _actor.attackTarget.Id)
					{
						_targets.Add(targets.get_Item(num2));
					}
				}
			}
			else
			{
				_targets.AddRange(targets);
			}
			int num3 = 0;
			int num4 = 0;
			bool flag2 = false;
			while (_targets.Count > 0)
			{
				LogicEntity logicEntity = _targets.get_Item(num4) ?? _targets.get_Item(0);
				string bulletAlias = bullut_flameButter_Base.get_Item(num3);
				string text = "126_Split_" + logicEntity.Id;
				if (!baseButtleAimMonsterTag.ContainsKey(logicEntity.Id))
				{
					baseButtleAimMonsterTag.Add(logicEntity.Id, text);
				}
				ILRuntimeAPI.Shoot(position: _actor.tsTransform.Position + _actor.tsTransform.Left * shootOffset.x + _actor.tsTransform.Forward * shootOffset.z, bulletAlias: bulletAlias, actor: _actor, range: default, positionY: shootOffset.y, targetPosition: logicEntity.tsTransform.Position, target: logicEntity, aimType: AimType.Target, bulletDirectionType: BulletDirectionType.BulletToTarget).bulletTag = text;
				num3++;
				if (num3 >= ShootButtleCount)
				{
					break;
				}
				if (flag2)
				{
					if (flag)
					{
						num4 = 0;
						continue;
					}
					num4++;
					num4 = ((num4 < _targets.Count) ? num4 : 0);
					continue;
				}
				num4++;
				if (num4 >= _targets.Count)
				{
					flag2 = true;
					num4 = 0;
				}
			}
		}
	}

	private void OnSearchTargetFinish_Prek30(List<LogicEntity> targets)
	{
		if (targets == null || targets.Count <= 0 || bullut_flameButter_Prek30.Count <= 0)
		{
			return;
		}
		if (CorShootPrek30 != null)
		{
			_actor.StopLogicCoroutine(CorShootPrek30);
			CorShootPrek30 = null;
		}
		if (_targets_Prek30 == null)
		{
			_targets_Prek30 = new List<LogicEntity>(10);
		}
		else
		{
			_targets_Prek30.Clear();
		}
		targets.Sort((LogicEntity x, LogicEntity y) => (!(TSVector2.Distance(x.tsTransform.Position, _actor.tsTransform.Position) < TSVector2.Distance(y.tsTransform.Position, _actor.tsTransform.Position))) ? 1 : (-1));
		bool lockAttackTarget = false;
		if (mainCtrActor.attackTarget != null)
		{
			for (int num = 0; num < targets.Count; num++)
			{
				if (targets.get_Item(num).Id == mainCtrActor.attackTarget.Id)
				{
					_targets_Prek30.Add(targets.get_Item(num));
					lockAttackTarget = true;
					break;
				}
			}
			for (int num2 = 0; num2 < targets.Count; num2++)
			{
				if (targets.get_Item(num2).Id != mainCtrActor.attackTarget.Id)
				{
					_targets_Prek30.Add(targets.get_Item(num2));
				}
			}
		}
		else
		{
			_targets_Prek30.AddRange(targets);
		}
		int shootCount = ashButterflyCount;
		if (GetPerkLv(perkId_23, out var _))
		{
			shootCount = ashButterfly_P23_Count;
		}
		CorShootPrek30 = _actor.StartLogicCoroutine(Shoot_Prep30(shootCount, lockAttackTarget));
	}

	private IEnumerator Shoot_Prep30(int shootCount, bool lockAttackTarget)
	{
		int bulletIndex = 0;
		int targetIndex = 0;
		bool firstRoundFinish = false;
		while (_targets_Prek30.Count > 0)
		{
			LogicEntity logicEntity = _targets_Prek30.get_Item(targetIndex) ?? _targets_Prek30.get_Item(0);
			ILRuntimeAPI.Shoot(bullut_flameButter_Prek30.get_Item(bulletIndex), position: mainCtrActor.tsTransform.Position + mainCtrActor.tsTransform.Left * shootOffset_30.x + mainCtrActor.tsTransform.Forward * shootOffset_30.z, actor: _actor, range: default, positionY: shootOffset_30.y, targetPosition: logicEntity.tsTransform.Position, target: logicEntity, aimType: AimType.Target, bulletDirectionType: BulletDirectionType.BulletToTarget);
			bulletIndex++;
			if (bulletIndex >= shootCount)
			{
				break;
			}
			if (firstRoundFinish)
			{
				if (lockAttackTarget)
				{
					targetIndex = 0;
				}
				else
				{
					targetIndex++;
					targetIndex = ((targetIndex < _targets_Prek30.Count) ? targetIndex : 0);
				}
			}
			else
			{
				targetIndex++;
				if (targetIndex >= _targets_Prek30.Count)
				{
					firstRoundFinish = true;
					targetIndex = 0;
				}
			}
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(perkId_30_ShootInterval));
		}
	}

	protected override void OnBulletFinish(AdventureBulletFinishEvent _evt)
	{
		base.OnBulletFinish(_evt);
		if (!(_evt.owner is PlayerAdventureActor))
		{
			return;
		}
		string tag = _evt.tag;
		if (!tag.Contains("126_Split_"))
		{
			return;
		}
		long num = 0L;
		foreach (KeyValuePair<long, string> item in baseButtleAimMonsterTag)
		{
			if (item.Value == tag)
			{
				num = item.Key;
				break;
			}
		}
		if (num != 0L)
		{
			baseButtleAimMonsterTag.Remove(num);
		}
	}

	protected override void OnMonsterDeath(MonsterAdventureActor monster)
	{
		base.OnMonsterDeath(monster);
		if (baseButtleKillMonster.Contains(monster.Id) || ((!monster.buffComponent || !monster.buffComponent.CheckBuffByBuffID(flameTotemBuffId)) && !baseButtleAimMonsterTag.ContainsKey(monster.Id)))
		{
			return;
		}
		if (baseButtleAimMonsterTag.ContainsKey(monster.Id))
		{
			baseButtleAimMonsterTag.Remove(monster.Id);
		}
		baseButtleKillMonster.Add(monster.Id);
		List<LogicEntity> list = MonsterDeathGetTarget(monster.tsTransform.Position, monster.Id);
		if (list.Count > 0)
		{
			string text = "126_Split_" + list.get_Item(0).Id;
			if (!baseButtleAimMonsterTag.ContainsKey(list.get_Item(0).Id))
			{
				baseButtleAimMonsterTag.Add(list.get_Item(0).Id, text);
			}
			ILRuntimeAPI.Shoot(bullut_flameButter_KillMonster, _actor, default, monster.tsTransform.Position, 1.5, list.get_Item(0).tsTransform.Position, list.get_Item(0), AimType.Target, BulletDirectionType.BulletToTarget).bulletTag = text;
		}
		else
		{
			CoroutineNode item = _actor.StartLogicCoroutine(MonsterKilledGetTarget(monster.transform.position, monster.tsTransform.Position, monster.Id));
			corGetTargetList.Add(item);
		}
	}

	private IEnumerator MonsterKilledGetTarget(Vector3 fxPos, TSVector2 pos, long id)
	{
		PlayFX _playFX = new PlayFX();
		_playFX.Play(spawnPosition: new Vector3(fxPos.x, 0.5f, fxPos.z), actor: _actor, fxAlias: fx_KillMonster_Name, playbackSpeed: 1f, spawnRotation: Quaternion.identity);
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(0.2));
		for (int getCount = 0; getCount < killedGetTargetMaxCount; getCount++)
		{
			List<LogicEntity> list = MonsterDeathGetTarget(pos, id);
			if (list.Count > 0)
			{
				_playFX.Stop();
				string text = "126_Split_" + list.get_Item(0).Id;
				if (!baseButtleAimMonsterTag.ContainsKey(list.get_Item(0).Id))
				{
					baseButtleAimMonsterTag.Add(list.get_Item(0).Id, text);
				}
				ILRuntimeAPI.Shoot(bullut_flameButter_KillMonster, _actor, default, pos, 1.5, list.get_Item(0).tsTransform.Position, list.get_Item(0), AimType.Target, BulletDirectionType.BulletToTarget).bulletTag = text;
				yield break;
			}
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(0.2));
		}
		_playFX.Stop();
	}

	public List<LogicEntity> MonsterDeathGetTarget(TSVector2 pos, long id)
	{
		DeterministicShape deterministicCircleShape = CommonUtils.GetDeterministicCircleShape(searchRadius, 0, pos);
		List<LogicEntity> monstersFromShape = ILRuntimeAPI.GetMonstersFromShape(_actor, deterministicCircleShape);
		if (monstersFromShape.Count > 0)
		{
			for (int num = monstersFromShape.Count - 1; num >= 0; num--)
			{
				LogicEntity logicEntity = monstersFromShape.get_Item(num);
				AdventureActor component = logicEntity.GetComponent<AdventureActor>();
				if (logicEntity.Id == id || (component != null && (!component.actorHealthInfo.isAlive || component.state == ActorState.Spawn || component.state == ActorState.Death || logicEntity.IsSearchedImmunity())))
				{
					monstersFromShape.RemoveAt(num);
				}
			}
			if (monstersFromShape.Count > 0)
			{
				monstersFromShape.Sort((LogicEntity x, LogicEntity y) => (!(TSVector2.Distance(x.tsTransform.Position, pos) < TSVector2.Distance(y.tsTransform.Position, pos))) ? 1 : (-1));
			}
		}
		return monstersFromShape;
	}
}
