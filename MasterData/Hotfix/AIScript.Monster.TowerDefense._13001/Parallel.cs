using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using Nova.Hotfix;
using TrueSync;

namespace AIScript.Monster.TowerDefense._13001;

public class Parallel : TowerCharacterParalletBase
{
	private int summonId = 8013001;

	private int summonInherit = 100;

	private FP summonLeftTime = 9;

	private FP randomRadius_SummonPosition_Skill = 5;

	private int perkId_1 = 1300101;

	private int buffId_1 = 801300010;

	private int perkId_2 = 1300102;

	private int buff_2_hurt = 801300030;

	private int perkId_3 = 1300103;

	private int buffId_3 = 801300020;

	private List<int> perkList = new List<int>();

	private Dictionary<int, int> _dicPerkCd = new Dictionary<int, int> { [1300107] = 15 };

	private SummonCfg summonCfg = new SummonCfg();

	private int summonEvt = CommonHelper.StringToHash("summonEvt");

	private int cdModifyEvt = CommonHelper.StringToHash("cdModifyEvt");

	private List<int> buffList = new List<int>();

	private DeterministicShape _randomPositionShape;

	private int curSummonCount;

	private bool isAdd;

	private List<MonsterAdventureActor> summmons = new List<MonsterAdventureActor>();

	public override Dictionary<int, int> dicPerkCd => _dicPerkCd;

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnSummonSpawned);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDied);
		summonCfg.summonFollowType = SummonFollowType.NotFollow;
		summonCfg.summonAttrType = SummonAttrType.Self;
		summonCfg.summonRelation = SummonRelation.Independent;
		summonCfg.attrPercent = summonInherit;
		summonCfg.leftTime = summonLeftTime;
		summonCfg.retainWhenCrossLevel = false;
		summonCfg.summonType = SummonType.Minion;
		_randomPositionShape.shapeType = DeterministicShape.ShapeType.Circle;
		curSummonCount = 0;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnSummonSpawned);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", OnMonsterDied);
		buffList.Clear();
		summmons.Clear();
	}

	public override void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			if (GetPerk(perkId_1))
			{
				_actor.buffComponent.AddBuff(buffId_1, _actor);
			}
			if (GetPerk(perkId_3))
			{
				_actor.buffComponent.AddBuff(buffId_3, _actor);
			}
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
	}

	public override void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		if (evt.eventHashCode != summonEvt)
		{
			return;
		}
		TSVector2 position = _actor.tsTransform.Position;
		TSVector2 dir = _actor.tsTransform.Forward;
		if (_actor.attackTarget != null)
		{
			position = _actor.attackTarget.tsTransform.Position;
			dir = _actor.attackTarget.tsTransform.Position - position;
			dir.Normalize();
		}
		else
		{
			position = GetSummonPosition(_actor, out var _);
		}
		CommonUtils.SummonMonster(_actor, 0, summonId, position, dir, summonCfg, null, (MonsterAdventureActor monster) =>
		{
			foreach (int buff in buffList)
			{
				monster.buffComponent.AddBuff(buff, monster);
			}
		});
	}

	private TSVector2 GetSummonPosition(LogicEntity target, out bool searchSuccess)
	{
		FP radius = target.GetRadius();
		_randomPositionShape.innerRadius = radius;
		_randomPositionShape.radius = radius + randomRadius_SummonPosition_Skill;
		_randomPositionShape.position = target.tsTransform.Position;
		TSVector2 randomPointInShape = ILRuntimeAPI.GetRandomPointInShape(_actor, _randomPositionShape);
		searchSuccess = randomPointInShape != _randomPositionShape.position;
		return randomPointInShape;
	}

	public override void OnPersonalPerkUpdate(AdventureActorPersonalPerkUpdateEvent evt)
	{
		base.OnPersonalPerkUpdate(evt);
		if (!evt.isNew || evt.actorDataId != _actor.dataID)
		{
			return;
		}
		if (perkList.Contains(evt.perkId))
		{
			TowerDefensePotential towerDefensePotential = Singleton<HotfixDataController>.Instance.GetTowerDefensePotential(evt.perkId);
			if (towerDefensePotential != null && towerDefensePotential.Effect1 != 0)
			{
				buffList.Add(towerDefensePotential.Effect1);
			}
		}
		if (evt.perkId == perkId_2)
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.eventHashCode = cdModifyEvt;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
	}

	private void OnSummonSpawned(IEvent evt)
	{
		if (evt is AdventureMonsterSummonerSpawnedEvent adventureMonsterSummonerSpawnedEvent && GetPerk(perkId_2) && adventureMonsterSummonerSpawnedEvent.summonerId == _actor.Id && adventureMonsterSummonerSpawnedEvent.dataId == summonId)
		{
			curSummonCount++;
			if (curSummonCount > 0 && !_actor.buffComponent.CheckBuffByBuffID(buff_2_hurt))
			{
				_actor.buffComponent.AddBuff(buff_2_hurt, _actor);
			}
		}
	}

	private void OnMonsterDied(IEvent evt)
	{
		if (!(evt is AdventureMonsterDiedEvent adventureMonsterDiedEvent) || !GetPerk(perkId_2) || adventureMonsterDiedEvent.monsterID != summonId)
		{
			return;
		}
		curSummonCount--;
		if (curSummonCount <= 0)
		{
			curSummonCount = 0;
			if (_actor.buffComponent.CheckBuffByBuffID(buff_2_hurt))
			{
				_actor.buffComponent.RemoveBuffByBuffId(buff_2_hurt);
			}
		}
	}
}
