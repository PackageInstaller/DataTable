using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using Nova.Hotfix;
using TrueSync;

namespace AIScript.Monster.TowerDefense._12301;

public class Parallel : TowerCharacterParalletBase
{
	private int hitTag_Normal = CommonHelper.StringToHash("FengTunAttack");

	private int hitTag_Normal_P3 = CommonHelper.StringToHash("XingZiAttack3");

	private int interval_Count = 5;

	private string areaEffect_Base = "AreaEffect_FengBoom";

	private FP _leftTime = 10;

	private int monsterId = 8012301;

	private TSVector2 offsetBorn = new TSVector2(1f, -1f);

	private int perkId_1 = 1230101;

	private string areaEffect_1 = "AreaEffect_FengBoom";

	private int perkId_2 = 1230102;

	private int buffId_2 = 801230220;

	private int perkId_3 = 1230103;

	private string areaEffect_3 = "AreaEffect_FengBoom_Plus";

	private int perkId_4 = 1230104;

	private List<int> perkList = new List<int> { 1230106, 1230107 };

	private Dictionary<int, int> _dicPerkCd = new Dictionary<int, int> { [1230105] = 25 };

	private bool triggerFirstHit;

	private int summonEvt = CommonHelper.StringToHash("summonEvt");

	private List<int> buffList = new List<int>();

	private List<MonsterAdventureActor> summmons = new List<MonsterAdventureActor>();

	private Dictionary<long, int> dicHitCount = new Dictionary<long, int>();

	public override Dictionary<int, int> dicPerkCd => _dicPerkCd;

	public override void OnEnable()
	{
		base.OnEnable();
		triggerFirstHit = false;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		summmons.Clear();
		dicHitCount.Clear();
		buffList.Clear();
	}

	public override void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		base.OnCastSkill(evt);
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.NORMAL)
		{
			triggerFirstHit = false;
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		int value;
		if (isSelf)
		{
			if (GetPerk(perkId_1) && !triggerFirstHit && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Normal_P3))
			{
				triggerFirstHit = true;
				string fxAlias = (GetPerk(perkId_3) ? areaEffect_3 : areaEffect_1);
				ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, monster.tsTransform.Position);
			}
		}
		else if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Normal) && dicHitCount.TryGetValue(evt.from.Id, out value))
		{
			value++;
			if (value >= interval_Count)
			{
				value = 0;
				string fxAlias2 = (GetPerk(perkId_3) ? areaEffect_3 : areaEffect_Base);
				ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias2, monster.tsTransform.Position);
			}
			dicHitCount.set_Item(evt.from.Id, value);
		}
	}

	public override void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		if (evt.eventHashCode != summonEvt)
		{
			return;
		}
		SummonCfg summonCfg = new SummonCfg();
		summonCfg.summonFollowType = SummonFollowType.NotFollow;
		summonCfg.summonAttrType = SummonAttrType.InheritByInitialSnapshot;
		summonCfg.summonRelation = SummonRelation.Coexisted;
		summonCfg.attrPercent = 100;
		summonCfg.leftTime = _leftTime;
		summonCfg.retainWhenCrossLevel = false;
		summonCfg.useSummonHit = true;
		TSVector2 pos = _actor.tsTransform.TransformLocalPointToWorldSpace(offsetBorn);
		ILRuntimeAPI.SummonMonster(_actor, 0, monsterId, pos, _actor.tsTransform.Forward, summonCfg, null, (MonsterAdventureActor monster) =>
		{
			foreach (int buff in buffList)
			{
				monster.buffComponent.AddBuff(buff, monster);
			}
			if (GetPerk(perkId_2))
			{
				monster.buffComponent.AddBuff(buffId_2, monster);
			}
			dicHitCount.Add(monster.Id, 0);
		});
	}

	public override void OnPersonalPerkUpdate(AdventureActorPersonalPerkUpdateEvent evt)
	{
		base.OnPersonalPerkUpdate(evt);
		if (!evt.isNew || evt.actorDataId != _actor.dataID)
		{
			return;
		}
		if (evt.perkId == perkId_2)
		{
			CommonUtils.GetAllSummonsById(summmons, monsterId);
			for (int i = 0; i < summmons.Count; i++)
			{
				summmons.get_Item(i).buffComponent.AddBuff(buffId_2, summmons.get_Item(i));
			}
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
}
