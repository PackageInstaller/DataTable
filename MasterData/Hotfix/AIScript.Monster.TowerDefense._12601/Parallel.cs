using System.Collections.Generic;
using AIScript.DynamicLevel;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster.TowerDefense._12601;

public class Parallel : TowerCharacterParalletBase
{
	private readonly string evt_Attack = "126SupportAttack";

	private readonly int flameButterflyCount = 3;

	private readonly int ashButterflyCount = 3;

	private readonly FP searchRadius = 7.5;

	private readonly List<string> bullet_flameButterfly = new List<string> { "Bullet_12601_Skill2_ButterflyFire_1", "Bullet_12601_Skill2_ButterflyFire_2", "Bullet_12601_Skill2_ButterflyFire_3", "Bullet_12601_Skill2_ButterflyFire_4", "Bullet_12601_Skill2_ButterflyFire_5" };

	private readonly TSVector shootOffset = new TSVector(0, 1.5, 0);

	private readonly int ashButterflyBuffId = 801260010;

	private readonly int flameTotemBuffId = 801260020;

	private readonly FP radiusOffset = 0.3;

	private readonly FP posYOffset = 1;

	private const int perkId_1 = 1260101;

	private int energyRatio_1 = 7;

	private const int perkId_2 = 1260102;

	private readonly int prob_P02 = 35;

	private readonly FP cd_P02 = 1;

	private readonly string bullet_P02 = "Bullet_12601_Skill2_ButterflyFire_Perk22";

	private readonly string bullet_P02_TargetSelf = "Bullet_12601_Skill2_ButterflyFire_Perk22_Self";

	private const int perkId_3 = 1260103;

	private readonly int ashButterflyCount_P03 = 5;

	private const int perkId_4 = 1260104;

	private readonly int flameButterflyCount_P04 = 5;

	private Dictionary<int, int> _dicPerkCd = new Dictionary<int, int> { [1260107] = 25 };

	private FP passiveCD_P02;

	private List<LogicEntity> _searchEntities = new List<LogicEntity>();

	public override Dictionary<int, int> dicPerkCd => _dicPerkCd;

	public override void OnEnable()
	{
		base.OnEnable();
		passiveCD_P02 = 0;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_searchEntities.Clear();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
	}

	private void OnGetBuff(IEvent evt)
	{
		AdventureActorGetBuff adventureActorGetBuff = evt as AdventureActorGetBuff;
		if (!(adventureActorGetBuff.from != _actor) && adventureActorGetBuff.eventInfo.buffId == ashButterflyBuffId && GetPerk(1260101))
		{
			TowerDefenseCharacterActor towerDefenseCharacterActor = adventureActorGetBuff.sender as TowerDefenseCharacterActor;
			towerDefenseCharacterActor.skillMgr.AddRecoveryEnergyRatio(towerDefenseCharacterActor.mainSkillId, energyRatio_1);
		}
	}

	private void OnRemoveBuff(IEvent evt)
	{
		AdventureActorRemoveBuff adventureActorRemoveBuff = evt as AdventureActorRemoveBuff;
		if (adventureActorRemoveBuff.eventInfo.buffId == ashButterflyBuffId && adventureActorRemoveBuff.froms.Contains(_actor) && GetPerk(1260101))
		{
			TowerDefenseCharacterActor towerDefenseCharacterActor = adventureActorRemoveBuff.sender as TowerDefenseCharacterActor;
			towerDefenseCharacterActor.skillMgr.AddRecoveryEnergyRatio(towerDefenseCharacterActor.mainSkillId, -energyRatio_1);
		}
	}

	public override void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		if (!(evt.eventName == evt_Attack))
		{
			return;
		}
		CommonUtils.SearchNearTargetsByCircleInTD(_actor, _actor.tsTransform.Position, searchRadius, _searchEntities, isConfront: true);
		if (_searchEntities.Count > 0)
		{
			int count = flameButterflyCount;
			if (GetPerk(1260104))
			{
				count = flameButterflyCount_P04;
			}
			ShootFlameButterflies(count);
		}
		int num = ashButterflyCount;
		if (GetPerk(1260103))
		{
			num = ashButterflyCount_P03;
		}
		TowerDefenseCharacterActor towerDefenseCharacterActor = FindNearestAlly();
		if (towerDefenseCharacterActor != null)
		{
			towerDefenseCharacterActor.buffComponent.AddBuffNum(ashButterflyBuffId, num, _actor);
		}
	}

	private TowerDefenseCharacterActor FindNearestAlly()
	{
		List<LogicEntity> dynamicActors = ModuleController<AdventureModuleController>.Instance.levelInstance.dynamicActors;
		TowerDefenseCharacterActor result = null;
		FP fP = FP.MaxValue;
		for (int i = 0; i < dynamicActors.Count; i++)
		{
			if (dynamicActors.get_Item(i) is TowerDefenseCharacterActor towerDefenseCharacterActor && towerDefenseCharacterActor.Id != _actor.Id && towerDefenseCharacterActor.IsActive)
			{
				FP fP2 = TSVector2.Distance(_actor.tsTransform.Position, towerDefenseCharacterActor.tsTransform.Position);
				if (fP2 < fP)
				{
					fP = fP2;
					result = towerDefenseCharacterActor;
				}
			}
		}
		return result;
	}

	private void ShootFlameButterflies(int count)
	{
		List<LogicEntity> list = new List<LogicEntity>(_searchEntities.Count);
		bool flag = false;
		if (_actor.attackTarget != null)
		{
			for (int i = 0; i < _searchEntities.Count; i++)
			{
				if (_searchEntities.get_Item(i).Id == _actor.attackTarget.Id)
				{
					list.Add(_searchEntities.get_Item(i));
					flag = true;
					break;
				}
			}
			for (int j = 0; j < _searchEntities.Count; j++)
			{
				if (_actor.attackTarget == null || _searchEntities.get_Item(j).Id != _actor.attackTarget.Id)
				{
					list.Add(_searchEntities.get_Item(j));
				}
			}
		}
		else
		{
			list.AddRange(_searchEntities);
		}
		int num = 0;
		int num2 = 0;
		bool flag2 = false;
		while (num < count)
		{
			LogicEntity logicEntity = list.get_Item(num2) ?? list.get_Item(0);
			ILRuntimeAPI.Shoot(bullet_flameButterfly.get_Item(num % bullet_flameButterfly.Count), position: _actor.tsTransform.Position + _actor.tsTransform.Left * shootOffset.x + _actor.tsTransform.Forward * shootOffset.z, actor: _actor, range: default, positionY: shootOffset.y, targetPosition: logicEntity.tsTransform.Position, target: logicEntity, aimType: AimType.Target, bulletDirectionType: BulletDirectionType.BulletToTarget);
			num++;
			if (flag2)
			{
				if (flag)
				{
					num2 = 0;
					continue;
				}
				num2++;
				num2 = ((num2 < list.Count) ? num2 : 0);
				continue;
			}
			num2++;
			if (num2 >= list.Count)
			{
				flag2 = true;
				num2 = 0;
			}
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPost(evt, monster, isSelf);
		if (isSelf && GetPerk(1260102) && monster != null && monster.buffComponent.CheckBuffByBuffID(flameTotemBuffId))
		{
			int num = monster.buffComponent.GetBuffNumByID(flameTotemBuffId) * prob_P02;
			if (TSRandom.Range(0, 100) < num && (_actor.LogicTime - passiveCD_P02 >= cd_P02 || passiveCD_P02 == 0))
			{
				passiveCD_P02 = _actor.LogicTime;
				ShootSplitButterfly(monster);
			}
		}
	}

	private void ShootSplitButterfly(MonsterAdventureActor sourceMonster)
	{
		DeterministicShape deterministicCircleShape = CommonUtils.GetDeterministicCircleShape(searchRadius, 0, sourceMonster.tsTransform.Position);
		List<LogicEntity> monstersFromShape = ILRuntimeAPI.GetMonstersFromShape(_actor, deterministicCircleShape);
		for (int num = monstersFromShape.Count - 1; num >= 0; num--)
		{
			LogicEntity logicEntity = monstersFromShape.get_Item(num);
			AdventureActor component = logicEntity.GetComponent<AdventureActor>();
			if (logicEntity.Id == sourceMonster.Id || (component != null && (!component.actorHealthInfo.isAlive || component.state == ActorState.Spawn || component.state == ActorState.Death || logicEntity.IsSearchedImmunity())))
			{
				monstersFromShape.RemoveAt(num);
			}
		}
		if (monstersFromShape.Count > 0)
		{
			int index = TSRandom.Range(0, monstersFromShape.Count);
			LogicEntity logicEntity2 = monstersFromShape.get_Item(index);
			FP fP = 1;
			DeterministicCollider logicComponent = logicEntity2.GetLogicComponent<DeterministicCollider>();
			if (logicComponent != null)
			{
				fP = logicComponent.Radius + radiusOffset;
			}
			string bulletAlias = bullet_P02;
			AdventureActor adventureActor = _actor;
			FP range = 0;
			TSVector2 position = sourceMonster.tsTransform.Position + (logicEntity2.tsTransform.Position - sourceMonster.tsTransform.Position).normalized * fP;
			FP positionY = posYOffset;
			LogicEntity target = logicEntity2;
			ILRuntimeAPI.Shoot(bulletAlias, adventureActor, range, position, positionY, default, target, AimType.Target, BulletDirectionType.BulletToTarget);
		}
		else
		{
			GameObject bulletByAlias = ModuleController<AdventureModuleController>.Instance.GetBulletByAlias(_actor, bullet_P02_TargetSelf);
			_actor.shootBehaviour.Shoot(bulletByAlias, sourceMonster.tsTransform.Position, posYOffset, _actor.tsTransform.Forward, null, sourceMonster, useShootDeviationCalcScatteringRadius: false, default, AimType.Forward);
		}
	}
}
