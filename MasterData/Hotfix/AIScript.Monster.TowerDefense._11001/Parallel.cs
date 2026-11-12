using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using Nova.Hotfix;
using TrueSync;

namespace AIScript.Monster.TowerDefense._11001;

public class Parallel : TowerCharacterParalletBase
{
	private int summonId = 8011001;

	private int summonInherit = 100;

	private FP summonLeftTime = 12;

	private int summonCount = 1;

	private int summonEvt = CommonHelper.StringToHash("summonEvt");

	private FP radius = 2;

	private FP range = 1;

	private int perkId_1 = 1100101;

	private FP addTime_1 = 4;

	private int perkId_2 = 1100102;

	private FP addTime_2 = -3;

	private int buff_2 = 801100110;

	private int perkId_3 = 1100103;

	private FP interval_3 = 10;

	private FP range_3 = 7.5;

	private FP range_3_1 = 4.5;

	private List<int> perkList = new List<int> { 1100105, 1100106 };

	private Dictionary<int, int> _dicPerkCd = new Dictionary<int, int> { [1100107] = 33 };

	private SummonCfg summonCfg = new SummonCfg();

	private List<MonsterAdventureActor> monsters = new List<MonsterAdventureActor>();

	private List<LogicEntity> entities = new List<LogicEntity>();

	private CoroutineNode corSummon;

	private List<int> buffList = new List<int>();

	public override Dictionary<int, int> dicPerkCd => _dicPerkCd;

	public override void OnEnable()
	{
		base.OnEnable();
		summonCfg.summonFollowType = SummonFollowType.NotFollow;
		summonCfg.summonAttrType = SummonAttrType.Self;
		summonCfg.summonRelation = SummonRelation.Independent;
		summonCfg.attrPercent = summonInherit;
		summonCfg.leftTime = summonLeftTime;
		summonCfg.retainWhenCrossLevel = false;
		summonCfg.useSummonHit = true;
		summonCfg.summonType = SummonType.Minion;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		StopCoroutine(ref corSummon);
		buffList.Clear();
	}

	public override void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		if (evt.eventHashCode != summonEvt || !(actor.attackTarget != null))
		{
			return;
		}
		TSVector2 normalized = (actor.attackTarget.tsTransform.Position - actor.tsTransform.Position).normalized;
		TSVector2 position = actor.attackTarget.tsTransform.Position;
		bool flag = false;
		TSVector2 tSVector = position + normalized * radius;
		if (actor.QueryPositionWalkable(tSVector))
		{
			flag = CheckRange(tSVector);
		}
		if (!flag)
		{
			TSVector2 tSVector2 = TSVector2.Rotate(normalized, 90);
			TSVector2 tSVector3 = TSVector2.Rotate(normalized, -90);
			if (TSVector2.Dot(actor.attackTarget.tsTransform.Forward, tSVector2) > 0)
			{
				tSVector = position + tSVector2 * radius;
				flag = CheckRange(tSVector);
				if (!flag)
				{
					tSVector = position + tSVector3 * radius;
					flag = CheckRange(tSVector);
				}
			}
			else
			{
				tSVector = position + tSVector3 * radius;
				flag = CheckRange(tSVector);
				if (!flag)
				{
					tSVector = position + tSVector2 * radius;
					flag = CheckRange(tSVector);
				}
			}
		}
		if (!flag)
		{
			tSVector = CommonUtils.RandomReachablePointInsideRing(_actor, position, 0, radius);
		}
		CommonUtils.SummonMonster(_actor, 0, summonId, tSVector, _actor.tsTransform.Forward, summonCfg, null, (MonsterAdventureActor monster) =>
		{
			foreach (int buff in buffList)
			{
				monster.buffComponent.AddBuff(buff, monster);
			}
			if (GetPerk(perkId_2))
			{
				monster.buffComponent.AddBuff(buff_2, monster);
			}
		});
	}

	public override void OnPersonalPerkUpdate(AdventureActorPersonalPerkUpdateEvent evt)
	{
		base.OnPersonalPerkUpdate(evt);
		if (!evt.isNew || evt.actorDataId != _actor.dataID)
		{
			return;
		}
		if (evt.perkId == perkId_1)
		{
			summonCfg.leftTime += addTime_1;
		}
		else if (evt.perkId == perkId_2)
		{
			summonCfg.leftTime += addTime_2;
		}
		else if (evt.perkId == perkId_3)
		{
			StartCoroutine(ref corSummon, DoSummon());
		}
		if (perkList.Contains(evt.perkId))
		{
			TowerDefensePotential towerDefensePotential = Singleton<HotfixDataController>.Instance.GetTowerDefensePotential(evt.perkId);
			if (towerDefensePotential != null && towerDefensePotential.Effect1 != 0)
			{
				buffList.Add(towerDefensePotential.Effect1);
			}
		}
	}

	private bool CheckRange(TSVector2 pos)
	{
		CommonUtils.GetAllSummonsById(monsters, summonId);
		return monsters.FindAll((MonsterAdventureActor x) => TSVector2.Distance(pos, x.tsTransform.Position) < range).Count == 0;
	}

	private IEnumerator DoSummon()
	{
		Summon();
		FP curTime = interval_3;
		while (true)
		{
			if (curTime <= 0)
			{
				curTime = interval_3;
				Summon();
			}
			curTime -= _actor.LogicDeltaTime;
			yield return null;
		}
	}

	private void Summon()
	{
		TSVector2 zero = TSVector2.zero;
		CommonUtils.SearchNearTargetsByCircleInTD(_actor, _actor.tsTransform.Position, range_3, entities, isConfront: true);
		if (entities.Count != 0)
		{
			zero = entities.get_Item(0).tsTransform.Position;
		}
		else
		{
			CommonUtils.SearchNearTargetsByCircleInTD(_actor, _actor.tsTransform.Position, 1000, entities, isConfront: true);
			if (entities.Count != 0)
			{
				TSVector2 normalized = (entities.get_Item(0).tsTransform.Position - _actor.tsTransform.Position).normalized;
				zero = _actor.tsTransform.Position + normalized * range_3;
			}
			else
			{
				zero = CommonUtils.RandomWalkablePointInsideRing(_actor, _actor.tsTransform.Position, range_3_1, range_3_1);
			}
		}
		CommonUtils.SummonMonster(_actor, 0, summonId, zero, _actor.tsTransform.Forward, summonCfg, null, (MonsterAdventureActor monster) =>
		{
			if (GetPerk(perkId_2))
			{
				monster.buffComponent.AddBuff(buff_2, monster);
			}
			foreach (int buff in buffList)
			{
				monster.buffComponent.AddBuff(buff, monster);
			}
		});
	}
}
