using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._16101;

public class ParallelScript_MainControl : ParallelScript
{
	private FP dropProb_base = 10;

	private FP dropCd = 1;

	private FP summonForwardDist = 2;

	private int dropCount = 1;

	private FP dropRingRadiusMin = 3;

	private FP dropRingRadiusMax = 5;

	private const int summonId_JuDian = 16100011;

	private const string dropTag_Res = "16101_Res";

	private const int consumeRes_Summon = 10;

	private const int needRes_Summon = 10;

	private static readonly FP juDianLeftTime = 11.5;

	private const int juDianMaxCount = 1;

	private static readonly int damageTag_TriggerLandMark = CommonHelper.StringToHash("16101_LandTag_Trigger");

	private const int perkId_1 = 516101;

	private const int dropProb_1 = 100;

	private int once_1 = 16101011;

	private const int perkId_2 = 516102;

	private const int dropCount_2 = 2;

	private int once_2 = 16102011;

	private const int perkId_3 = 516103;

	private FP leftTime_3 = 30f;

	private FP cdReduce_3 = 10f;

	private FP cd_3 = 20f;

	private const int perkId_4 = 516104;

	private int once_JuDian_P04 = 16104011;

	private const int perkId_5 = 516105;

	private int buff_5 = 16105011;

	private const int perkId_6 = 516106;

	private int buff_6 = 16106011;

	private const int perkId_7 = 516107;

	private int once_7 = 16107001;

	private const int perkId_10 = 516110;

	private int add_10_1 = 1;

	private int add_10_2 = 2;

	private int level_10 = 4;

	private int once_10 = 16110001;

	private const int perkId_11 = 516111;

	private int buff_11 = 16111011;

	private const int perkId_12 = 516112;

	private int buff_12 = 16112011;

	private const int perkId_13 = 516113;

	private int once_13 = 16113001;

	private const int perkId_9 = 516109;

	private int buff_9 = 16109011;

	private int once_9 = 16109001;

	private readonly List<MonsterAdventureActor> juDianList = new List<MonsterAdventureActor>();

	private SummonCfg summonCfg_JuDian;

	private int seFriendCount;

	private FP _lastDropTime = -1;

	public override void OnEnable()
	{
		base.OnEnable();
		summonCfg_JuDian = new SummonCfg
		{
			summonFollowType = SummonFollowType.NotFollow,
			summonAttrType = SummonAttrType.InheritByInitialSnapshot,
			summonRelation = SummonRelation.Independent,
			summonType = SummonType.None,
			useSummonHit = true
		};
		summonCfg_JuDian.leftTime = (GetPerk(516103) ? leftTime_3 : juDianLeftTime);
		juDianList.Clear();
		_lastDropTime = -1;
		UpdateJuDianCountTag();
		if (GetPerk(516111))
		{
			SkillInfo skillCD = skillMgr.GetSkillCD(ActionKey.A);
			skillMgr.SetSkillTotalSection(ActionKey.A, skillCD.originalTotalSectionAmount + 1, forceMaxSection: true);
		}
		if (GetPerk(516103))
		{
			SkillInfo skillCD2 = skillMgr.GetSkillCD(ActionKey.B);
			skillMgr.ModifyOriginalSectionResumeTime(ActionKey.B, skillCD2.originalSectionResumeTime - cdReduce_3);
		}
		seFriendCount = 0;
		List<PlayerAdventureActor> actorLs = SceneSingleton<AdventurePlayerController>.Instance.ActorLs;
		for (int i = 0; i < actorLs.Count; i++)
		{
			if (actorLs.get_Item(i).actorElementInfo.elementType == HotfixEnum.elementType.SE)
			{
				seFriendCount++;
			}
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		for (int i = 0; i < juDianList.Count; i++)
		{
			if (juDianList.get_Item(i) != null && juDianList.get_Item(i).actorHealthInfo.isAlive)
			{
				juDianList.get_Item(i).DestroySelf();
			}
		}
		juDianList.Clear();
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		base.OnBeforeHit(evt, monster);
		if (GetPerk(516101) && CommonUtils.CheckHitByTag(evt.hitDamageTag, Config.hitTag_NormalSpecial))
		{
			AdventureActor.AddFromAttr(once_1, _actor);
		}
		if (GetPerk(516102) && CommonUtils.CheckHitByTag(evt.hitDamageTag, Config.hitTag_Normal))
		{
			AdventureActor.AddFromAttr(once_2, _actor);
		}
		if (GetPerk(516107) && CommonUtils.CheckHitByTag(evt.hitDamageTag, Config.hitTag_Normal))
		{
			AdventureActor.AddFromAttr(once_7, _actor);
		}
		if (GetPerk(516113) && seFriendCount > 0)
		{
			AdventureActor.AddFromAttr(once_13, _actor, seFriendCount);
		}
		if (!CommonUtils.CheckHitByTag(evt.hitDamageTag, Config.hitTag_JuDian))
		{
			return;
		}
		if (GetPerk(516109))
		{
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(buff_9);
			if (buffNumByID > 0)
			{
				AdventureActor.AddFromAttr(once_9, _actor, buffNumByID);
			}
		}
		if (GetPerk(516110))
		{
			int num = (int)(long)_actor.logicVariable.GetLogicTagValue("161_JuDianCount");
			if (num > 0)
			{
				AdventureActor.AddFromAttr(once_10, _actor, num);
			}
		}
		if (GetPerk(516104))
		{
			int buffNumByID2 = _actor.buffComponent.GetBuffNumByID(16104011);
			if (buffNumByID2 > 0)
			{
				AdventureActor.AddFromAttr(once_JuDian_P04, _actor, buffNumByID2);
			}
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster)
	{
		base.OnHitPost(evt, monster);
		IList<int> hitDamageTag = evt.hitDamageTag;
		bool flag = CommonUtils.CheckHitByTag(hitDamageTag, Config.hitTag_Ultra);
		if (CommonUtils.CheckHitByTag(hitDamageTag, Config.hitTag_Normal_Res) && !GetPerk(516103))
		{
			FP fP = (GetPerk(516101) ? ((FP)100) : dropProb_base);
			if (TSRandom.Range(0, 100) < fP && (_lastDropTime < 0 || _actor.LogicTime - _lastDropTime > dropCd))
			{
				_lastDropTime = _actor.LogicTime;
				int num = (GetPerk(516102) ? 2 : dropCount);
				string fxAlias = (GetPerk(516102) ? "Drop_16101_Res_P02" : "Drop_16101_Res");
				for (int i = 0; i < num; i++)
				{
					ILRuntimeAPI.PlayDrop(_actor, fxAlias, GetRingDropPos(monster.tsTransform.Position));
				}
			}
		}
		if ((CommonUtils.CheckHitByTag(hitDamageTag, damageTag_TriggerLandMark) || (flag && GetPerk(516112)) || (CommonUtils.CheckHitByTag(hitDamageTag, Config.hitTag_NormalSpecial) && GetPerk(516101))) && EarthMarkUtil.TryTrigger(_actor, monster) && GetPerk(516106))
		{
			_actor.buffComponent.AddBuff(buff_6, _actor);
		}
		if (GetPerk(516105) && CommonUtils.CheckHitByTag(hitDamageTag, Config.hitTag_NormalSpecial))
		{
			monster.buffComponent.AddBuff(buff_5, _actor);
		}
		if (CommonUtils.CheckHitByTag(hitDamageTag, Config.hitTag_JuDian))
		{
			EarthMarkUtil.TryTrigger(_actor, monster);
			if (GetPerk(516109))
			{
				_actor.buffComponent.AddBuff(buff_9, _actor);
			}
		}
	}

	public override void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		if (GetPerk(516111) && evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.A)
		{
			_actor.buffComponent.AddBuff(buff_11, _actor);
		}
	}

	public override void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
		if (GetPerk(516112) && evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D)
		{
			_actor.buffComponent.AddBuff(buff_12, _actor);
		}
	}

	public override void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		if (evt.eventHashCode == Config.summonEvt && !GetPerk(516101))
		{
			bool flag = false;
			if (GetPerk(516103) && CheckPerkCd(516103L, cd_3))
			{
				flag = true;
			}
			else if (_actor.buffComponent.GetBuffNumByID(16100011) > 10)
			{
				_actor.buffComponent.RemoveBuffByBuffId(16100011, 10);
				flag = true;
			}
			if (flag)
			{
				DoSummonJuDian();
			}
		}
	}

	public override void OnBattleReady(AdventureBattleReadyEvent evt)
	{
		for (int i = 0; i < juDianList.Count; i++)
		{
			if (juDianList.get_Item(i) != null && juDianList.get_Item(i).actorHealthInfo.isAlive)
			{
				juDianList.get_Item(i).DestroySelf();
			}
		}
		juDianList.Clear();
		UpdateJuDianCountTag();
	}

	public override void OnDropFinish(AdventureDropFinishEvent evt)
	{
		if (GetPerk(516104) && evt.isPickUp && evt.target == _actor && evt.dropTag == "16101_Res")
		{
			_actor.buffComponent.AddBuff(16104011, _actor);
		}
	}

	private void DoSummonJuDian()
	{
		CleanDeadJuDian();
		int num = GetJuDianMaxCount();
		while (juDianList.Count >= num && juDianList.Count > 0)
		{
			MonsterAdventureActor monsterAdventureActor = juDianList.get_Item(0);
			juDianList.RemoveAt(0);
			if (monsterAdventureActor != null && monsterAdventureActor.actorHealthInfo.isAlive)
			{
				monsterAdventureActor.DestroySelf();
			}
		}
		TSVector2 linecastHitPoint = _actor.tsTransform.Position + _actor.tsTransform.Forward.normalized * summonForwardDist;
		if (!_actor.QueryPositionReachable(linecastHitPoint))
		{
			_actor.LinecastNavmeshGraph(_actor.tsTransform.Position, linecastHitPoint, out linecastHitPoint, offset: false, _actor.tsTransform.PositionY, _actor.tsTransform.PositionY);
		}
		ILRuntimeAPI.SummonMonster(_actor, 0, 16100011, linecastHitPoint, _actor.tsTransform.Forward, summonCfg_JuDian, null, (MonsterAdventureActor m) =>
		{
			if (m != null)
			{
				juDianList.Add(m);
				UpdateJuDianCountTag();
			}
		}, useTerrainHeight: true);
		UpdateJuDianCountTag();
	}

	private int GetJuDianMaxCount()
	{
		int num = 1;
		if (GetPerkLv(516110, out var lv))
		{
			num += ((lv >= level_10) ? add_10_2 : add_10_1);
		}
		return num;
	}

	private void CleanDeadJuDian()
	{
		for (int num = juDianList.Count - 1; num >= 0; num--)
		{
			if (juDianList.get_Item(num) == null || !juDianList.get_Item(num).actorHealthInfo.isAlive)
			{
				juDianList.RemoveAt(num);
			}
		}
	}

	private void UpdateJuDianCountTag()
	{
		_actor.logicVariable.SetLogicTagValue("161_JuDianCount", juDianList.Count);
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}

	private TSVector2 GetRingDropPos(TSVector2 center)
	{
		return ILRuntimeAPI.GetRandomPointInShape(_actor, new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Circle,
			position = center,
			innerRadius = dropRingRadiusMin,
			radius = dropRingRadiusMax
		});
	}
}
