using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.ThemePerk;

public class Theme_WhirlWind : BaseTheme
{
	private readonly string commonWindArea = "Misc/FateCard/Theme_WhirlWind";

	private readonly FP commonCenterDis = 1;

	private readonly string superWindArea = "Misc/FateCard/Theme_WhirlWind_15";

	private readonly FP superCenterDis = 1;

	private readonly string commonWindArea_Diffuse = "Misc/FateCard/Theme_WhirlWind_q1";

	private readonly FP commonCenterDis_Diffuse = 0.6;

	private readonly FP commonCenterDis_DiffuseMax = 0.9;

	private readonly FP commonCenterDis_DiffuseGrowth = 0.02;

	private readonly FP commonCenterDis_DiffuseInterval = 0.1;

	private readonly string superWindArea_Diffuse = "Misc/FateCard/Theme_WhirlWind_15q1";

	private readonly FP superCenterDis_Diffuse = 0.6;

	private readonly FP superCenterDis_DiffuseMax = 0.9;

	private readonly FP superCenterDis_DiffuseGrowth = 0.02;

	private readonly FP superCenterDis_DiffuseInterval = 0.1;

	private readonly string smallWindArea = "Misc/FateCard/Theme_WhirlWind_small";

	private readonly string smallWindArea_Arc = "Misc/FateCard/Theme_WhirlWind_small_q2";

	private static readonly int whirlWindTag = CommonHelper.StringToHash("WhirlWind");

	private static readonly int whirlWindTagSmall = CommonHelper.StringToHash("WhirlWindSmall");

	private readonly int perkId_1 = 501001;

	private readonly FP cd_1 = 5;

	private readonly int prob_1 = 100;

	private readonly int hitDamageId_1 = 501001;

	private readonly int perkId_2 = 501002;

	private readonly FP cd_2 = 5;

	private readonly int prob_2 = 100;

	private readonly int hitDamageId_2 = 501002;

	private readonly int perkId_3 = 501003;

	private readonly FP cd_3 = 5;

	private readonly int prob_3 = 100;

	private readonly int hitDamageId_3 = 501003;

	private readonly int perkId_4 = 501004;

	private readonly FP cd_4 = 5;

	private readonly int prob_4 = 100;

	private readonly int hitDamageId_4 = 501004;

	private readonly int perkId_8 = 501008;

	private readonly FP cd_8 = 0;

	private readonly Dictionary<int, int> dicEff_8 = new Dictionary<int, int>
	{
		[1] = 40,
		[2] = 80,
		[3] = 120,
		[4] = 25,
		[5] = 30
	};

	private readonly int perkId_9 = 501009;

	private readonly FP cd_9 = 0;

	private readonly Dictionary<int, FP> dicHitInterval_9 = new Dictionary<int, FP>
	{
		[1] = 0.4,
		[2] = 0.3,
		[3] = 0.2
	};

	private readonly int perkId_10 = 501010;

	private readonly FP cd_10 = 1;

	private readonly int turbulenceBuffTag_10 = CommonHelper.StringToHash("WindTag");

	private readonly Dictionary<int, int> dicBuff_10 = new Dictionary<int, int>
	{
		[1] = 101011,
		[2] = 101021,
		[3] = 101031,
		[4] = 101041,
		[5] = 101051
	};

	private readonly Dictionary<int, FP> dicPercent_10 = new Dictionary<int, FP>
	{
		[1] = 15,
		[2] = 20,
		[3] = 25,
		[4] = 50,
		[5] = 50
	};

	private readonly int perkId_11 = 501011;

	private readonly FP cd_11 = 0;

	private readonly Dictionary<int, FP> dicPullStrength_11 = new Dictionary<int, FP>
	{
		[1] = 3,
		[2] = 3,
		[3] = 3
	};

	private readonly Dictionary<int, int> dicEff_11 = new Dictionary<int, int>
	{
		[1] = 30,
		[2] = 60,
		[3] = 90,
		[4] = 25,
		[5] = 30
	};

	private readonly int perkId_12 = 501012;

	private readonly FP cd_12 = 0.3;

	private readonly Dictionary<int, int> dicWhirlCount_12 = new Dictionary<int, int>
	{
		[1] = 1,
		[2] = 2,
		[3] = 3
	};

	private readonly Dictionary<int, int> dicEff_12 = new Dictionary<int, int>
	{
		[1] = 20,
		[2] = 30,
		[3] = 40,
		[4] = 50,
		[5] = 60
	};

	private readonly int hitDamageId_12 = 501012;

	private readonly int perkId_13 = 501013;

	private readonly FP cd_13 = 0;

	private readonly Dictionary<int, int> dicSamllCount_13 = new Dictionary<int, int>
	{
		[1] = 1,
		[2] = 2,
		[3] = 3
	};

	private readonly int samllDamageId_13 = 501013;

	private readonly int perkId_14 = 501014;

	private readonly FP cd_14 = 0;

	private readonly Dictionary<int, List<FP>> dicLeftTime_14 = new Dictionary<int, List<FP>>
	{
		[1] = new List<FP> { 0.1, 1 },
		[2] = new List<FP> { 0.2, 2 },
		[3] = new List<FP> { 0.3, 3 }
	};

	private readonly int perkId_15 = 501015;

	private readonly FP cd_15 = 0;

	private readonly int count_15 = 3;

	private readonly Dictionary<int, List<FP>> dicSummonMsg_15 = new Dictionary<int, List<FP>>
	{
		[1] = new List<FP> { 0.5, 1 },
		[2] = new List<FP> { 0.4, 2 },
		[3] = new List<FP> { 0.3, 3 }
	};

	private readonly int samllDamageId_15 = 501015;

	private readonly Dictionary<int, int> dicAddBuff_15 = new Dictionary<int, int>
	{
		[1] = 101511,
		[2] = 101521,
		[3] = 101531,
		[4] = 101541,
		[5] = 101551
	};

	private readonly int maxBuffOverlayCount_15 = 10;

	private readonly int taskPerkId_1 = 501016;

	private readonly int taskPerkId_2 = 501017;

	private readonly int samllDamageId_PerkId_2 = 501017;

	private readonly int taskPerkId_3 = 501018;

	private readonly int turbulenceBuffId = 2011;

	private List<long> windLogic_12 = new List<long>();

	private List<long> whirlWindLogicIdList = new List<long>();

	private Dictionary<long, FP> whirlWindAddLeft = new Dictionary<long, FP>();

	private Dictionary<long, CoroutineNode> superWindSummonCor = new Dictionary<long, CoroutineNode>();

	private int whirlWindCount;

	private List<long> allWindLogicId = new List<long>();

	private Dictionary<long, FP> windCenterRadius = new Dictionary<long, FP>();

	private Dictionary<long, CoroutineNode> windCneterDiffuse = new Dictionary<long, CoroutineNode>();

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		whirlWindLogicIdList.Clear();
		windLogic_12.Clear();
		whirlWindAddLeft.Clear();
		foreach (KeyValuePair<long, CoroutineNode> item in superWindSummonCor)
		{
			_actor.StopLogicCoroutine(item.Value);
		}
		superWindSummonCor.Clear();
		allWindLogicId.Clear();
		windCenterRadius.Clear();
		foreach (KeyValuePair<long, CoroutineNode> item2 in windCneterDiffuse)
		{
			_actor.StopLogicCoroutine(item2.Value);
		}
		windCneterDiffuse.Clear();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
	}

	protected override void OnPerk_NormalAtk()
	{
		base.OnPerk_NormalAtk();
		CheckPlayWind(perkId_1, 1, prob_1, cd_1, commonWindArea, hitDamageId_1, commonCenterDis);
	}

	protected override void OnPerk_Dodge()
	{
		base.OnPerk_Dodge();
		CheckPlayWind(perkId_2, 2, prob_2, cd_2, commonWindArea, hitDamageId_2, commonCenterDis);
	}

	protected override void OnPerk_CastSkill()
	{
		base.OnPerk_CastSkill();
		CheckPlayWind(perkId_3, 3, prob_3, cd_3, commonWindArea, hitDamageId_3, commonCenterDis);
	}

	protected override void OnPerk_CastAssistSkill()
	{
		base.OnPerk_CastAssistSkill();
		CheckPlayWind(perkId_4, 4, prob_4, cd_4, commonWindArea, hitDamageId_4, commonCenterDis);
	}

	private void CheckPlayWind(int perkId, int perkIndex, int prob, FP cd, string buttlePath, int dId, FP cenDis)
	{
		if (GetPerkLv(perkId, out var _) && ModuleController<AdventureModuleController>.Instance.CheckPerkCDTimeout(perkIndex, _actor.LogicTime, cd) && TSRandom.Range(0, 100) <= prob)
		{
			LogicEntity logicEntity = CommonUtils.SearchNearTargetByCircle(_actor, 99);
			if (!(logicEntity == null))
			{
				ChooseAreaEffect(buttlePath, logicEntity, isMove: true, dId, cenDis);
				ModuleController<AdventureModuleController>.Instance.TriggerPerk(perkIndex, _actor.LogicTime);
			}
		}
	}

	private void ChooseAreaEffect(string buttlePath, LogicEntity to, bool isMove = true, int damageId = 0, FP cDis = default(FP))
	{
		string areaEffect = buttlePath;
		FP cDis2 = cDis;
		bool flag = false;
		FP cDisMax = 0;
		FP cGrowth = 0;
		FP cInterval = 0;
		if (GetPerkLv(taskPerkId_1, out var lv))
		{
			flag = true;
			areaEffect = commonWindArea_Diffuse;
			cDis2 = commonCenterDis_Diffuse;
			cDisMax = commonCenterDis_DiffuseMax;
			cGrowth = commonCenterDis_DiffuseGrowth;
			cInterval = commonCenterDis_DiffuseInterval;
		}
		bool isSuper = false;
		if (GetPerkLv(perkId_15, out lv))
		{
			whirlWindCount++;
			if (whirlWindCount > count_15)
			{
				if (flag)
				{
					areaEffect = superWindArea_Diffuse;
					cDis2 = superCenterDis_Diffuse;
					cDisMax = superCenterDis_DiffuseMax;
					cGrowth = superCenterDis_DiffuseGrowth;
					cInterval = superCenterDis_DiffuseInterval;
				}
				else
				{
					areaEffect = superWindArea;
					cDis2 = superCenterDis;
				}
				isSuper = true;
				whirlWindCount = 0;
			}
		}
		PlayHit(areaEffect, to, isMove, isSuper, damageId, flag, cDis2, cDisMax, cGrowth, cInterval);
	}

	private void PlayHit(string areaEffect, LogicEntity to, bool isMove, bool isSuper, int damageId, bool isDiffuse, FP cDis, FP cDisMax, FP cGrowth, FP cInterval)
	{
		FP angle = (to.tsTransform.Position - _actor.tsTransform.Position).normalized.GetAngle();
		TSVector2 position = _actor.tsTransform.Position;
		if (!isMove)
		{
			DeterministicShape shape = new DeterministicShape
			{
				shapeType = DeterministicShape.ShapeType.Circle,
				angle = 360,
				radius = 2,
				position = to.tsTransform.Position
			};
			position = _actor.RandomActorReachablePointInsideShape(shape);
		}
		long num = ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect, position, angle, (AreaEffectEntity entity) =>
		{
			entity.duration = 3;
			AreaEffect_MoveComponent logicComponent = entity.GetLogicComponent<AreaEffect_MoveComponent>();
			if (logicComponent != null)
			{
				logicComponent.speed = 5;
			}
			AreaEffect_PullComponent logicComponent2 = entity.GetLogicComponent<AreaEffect_PullComponent>();
			if (logicComponent2 != null)
			{
				logicComponent2.strength = 0;
			}
			AreaEffect_AttackComponent logicComponent3 = entity.GetLogicComponent<AreaEffect_AttackComponent>();
			if (logicComponent3 != null)
			{
				logicComponent3.hitInterval = 0.5;
				if (damageId != 0)
				{
					logicComponent3.hitDamageId = damageId;
				}
			}
			if (GetPerkLv(perkId_9, out var lv) && logicComponent3 != null)
			{
				logicComponent3.hitInterval = dicHitInterval_9.get_Item(lv);
			}
			if (GetPerkLv(perkId_11, out var lv2) && logicComponent2 != null)
			{
				logicComponent2.strength = dicPullStrength_11.get_Item(lv2);
			}
			if (!isMove)
			{
				windLogic_12.Add(entity.Id);
				if (logicComponent != null)
				{
					logicComponent.speed = 0;
				}
			}
			if (GetPerkLv(perkId_13, out var lv3))
			{
				PlaySmallHit(dicSamllCount_13.get_Item(lv3), samllDamageId_13, isFlyRandom: false, 0L);
			}
			if (isSuper && GetPerkLv(perkId_15, out var lv4))
			{
				CoroutineNode value2 = _actor.StartLogicCoroutine(SummonWind_15(entity.Id, dicSummonMsg_15.get_Item(lv4).get_Item(0), dicSummonMsg_15.get_Item(lv4).get_Item(1), dicAddBuff_15.get_Item(lv4), samllDamageId_15));
				superWindSummonCor.Add(entity.Id, value2);
			}
		});
		if (num != 0L)
		{
			whirlWindLogicIdList.Add(num);
			allWindLogicId.Add(num);
			windCenterRadius.Add(num, cDis);
			if (isDiffuse)
			{
				CoroutineNode value = _actor.StartLogicCoroutine(WindDiffuse(num, cDisMax, cGrowth, cInterval));
				windCneterDiffuse.Add(num, value);
			}
		}
	}

	private IEnumerator WindDiffuse(long id, FP max, FP growth, FP interval)
	{
		do
		{
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(interval));
			windCenterRadius.get_Item(id) += growth;
		}
		while (!(windCenterRadius.get_Item(id) >= max));
	}

	private void PlaySmallHit(int Count, int damageId = 0, bool isFlyRandom = false, long superWindId = 0L)
	{
		FP fP = 0;
		TSVector2 position = _actor.tsTransform.Position;
		if (superWindId != 0L)
		{
			AreaEffectEntity areaEffect = ILRuntimeAPI.GetAreaEffect(superWindId);
			if (areaEffect != null)
			{
				position = areaEffect.tsTransform.Position;
			}
		}
		for (int i = 0; i < Count; i++)
		{
			ILRuntimeAPI.PlayAreaEffect(rotation: isFlyRandom ? ((FP)TSRandom.Range(0, 360)) : (i switch
			{
				0 => _actor.tsTransform.Forward.GetAngle() + 45 + TSRandom.Range(-30, 30), 
				1 => _actor.tsTransform.Forward.GetAngle() - 45 + TSRandom.Range(-30, 30), 
				_ => _actor.tsTransform.Back.GetAngle() + TSRandom.Range(-30, 30), 
			}), actor: _actor, fxAlias: smallWindArea, position: position, onBeforeSetup: (AreaEffectEntity entity) =>
			{
				if (damageId != 0)
				{
					entity.GetLogicComponent<AreaEffect_AttackComponent>().hitDamageId = damageId;
				}
			});
		}
	}

	private void PlaySmallHit(LogicEntity wind)
	{
		TSVector2 position = wind.tsTransform.Position;
		for (int i = 0; i < 4; i++)
		{
			FP fP = 0;
			fP = wind.tsTransform.Forward.GetAngle() + i * 90 + TSRandom.Range(-30, 30);
			ILRuntimeAPI.PlayAreaEffect(_actor, smallWindArea_Arc, position, fP, (AreaEffectEntity entity) =>
			{
				entity.GetLogicComponent<AreaEffect_AttackComponent>().hitDamageId = samllDamageId_PerkId_2;
			});
		}
	}

	private IEnumerator SummonWind_15(long superId, FP inteval, FP count, int buffId, int damageId)
	{
		while (true)
		{
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(inteval));
			PlaySmallHit((int)(long)count, damageId, isFlyRandom: true, superId);
			int buffNum = _actor.buffComponent.GetBuffNum(buffId, 0);
			if (buffNum < maxBuffOverlayCount_15)
			{
				int num = (int)(long)count;
				if ((int)(long)count + buffNum > maxBuffOverlayCount_15)
				{
					num = maxBuffOverlayCount_15 - buffNum;
				}
				for (int i = 0; i < num; i++)
				{
					Singleton<BuffManager>.Instance.AddBufftoGroup(buffId, _actor);
				}
			}
		}
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt)
	{
		base.OnBeforeHit(evt);
		MonsterAdventureActor monsterAdventureActor = evt.to as MonsterAdventureActor;
		AdventureActor adventureActor = evt.from as AdventureActor;
		if (!(monsterAdventureActor != null) || evt.hitDamageTag == null || !CommonUtils.CheckHitByTag(evt.hitDamageTag, whirlWindTag))
		{
			return;
		}
		if (GetPerkLv(perkId_8, out var lv) && monsterAdventureActor != null)
		{
			AdventureActor.AddFromAttr(dicEff_8.get_Item(lv), _actor);
		}
		if (GetPerkLv(perkId_10, out lv))
		{
			int buffID = dicBuff_10.get_Item(lv);
			if (monsterAdventureActor != null && monsterAdventureActor.buffComponent.CheckBuffByBuffTag(turbulenceBuffTag_10))
			{
				adventureActor.buffComponent.AddBuff(buffID, _actor);
			}
			else
			{
				FP fP = dicPercent_10.get_Item(lv);
				if (TSRandom.Range(FP.Zero, 100) <= fP)
				{
					adventureActor.buffComponent.AddBuff(buffID, _actor);
				}
			}
		}
		if (GetPerkLv(perkId_11, out lv) && windCenterRadius.ContainsKey(evt.areaEffectId))
		{
			FP fP2 = windCenterRadius.get_Item(evt.areaEffectId);
			AreaEffectEntity areaEffect = ILRuntimeAPI.GetAreaEffect(evt.areaEffectId);
			if (TSVector2.Distance(monsterAdventureActor.tsTransform.Position, areaEffect.tsTransform.Position) <= fP2)
			{
				AdventureActor.AddFromAttr(dicEff_11.get_Item(lv), _actor);
			}
		}
		if (GetPerkLv(perkId_12, out lv) && windLogic_12.Contains(evt.areaEffectId))
		{
			AdventureActor.AddFromAttr(dicEff_12.get_Item(lv), _actor);
		}
		if (!GetPerkLv(perkId_14, out lv) || !CheckPerkCDTimeout(perkId_14, cd_14))
		{
			return;
		}
		long areaEffectId = evt.areaEffectId;
		if (whirlWindLogicIdList.Contains(areaEffectId))
		{
			List<FP> list = dicLeftTime_14.get_Item(lv);
			FP fP3 = 0;
			if (whirlWindAddLeft.ContainsKey(evt.areaEffectId))
			{
				if (whirlWindAddLeft.get_Item(areaEffectId) != list.get_Item(1))
				{
					fP3 = ((!(whirlWindAddLeft.get_Item(areaEffectId) + list.get_Item(0) >= list.get_Item(1))) ? list.get_Item(0) : (list.get_Item(1) - whirlWindAddLeft.get_Item(areaEffectId)));
					whirlWindAddLeft.get_Item(areaEffectId) += fP3;
				}
			}
			else
			{
				fP3 = list.get_Item(0);
				whirlWindAddLeft.Add(areaEffectId, list.get_Item(0));
			}
			if (fP3 > 0)
			{
				ILRuntimeAPI.AddAreaEffectLeftTime(areaEffectId, fP3);
			}
		}
		TriggerPerk(perkId_14);
	}

	protected override void OnHitPost(AdventureActorReceiveDamageEvent evt)
	{
		base.OnHitPost(evt);
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, whirlWindTag) || CommonUtils.CheckHitByTag(evt.hitDamageTag, whirlWindTagSmall))
		{
			MonsterAdventureActor monsterAdventureActor = evt.to as MonsterAdventureActor;
			if (monsterAdventureActor != null && GetPerkLv(taskPerkId_3, out var _))
			{
				monsterAdventureActor.buffComponent.AddBuff(turbulenceBuffId, _actor);
			}
		}
	}

	protected override void OnMonsterKilled(AdventureActorReceiveDamageEvent evt)
	{
		MonsterAdventureActor monsterAdventureActor = evt.to as MonsterAdventureActor;
		if (monsterAdventureActor != null && (CommonUtils.CheckHitByTag(evt.hitDamageTag, whirlWindTag) || CommonUtils.CheckHitByTag(evt.hitDamageTag, whirlWindTagSmall)) && GetPerkLv(perkId_12, out var lv) && CheckPerkCDTimeout(perkId_12, cd_12))
		{
			int num = dicWhirlCount_12.get_Item(lv);
			for (int i = 0; i < num; i++)
			{
				ChooseAreaEffect(commonWindArea, monsterAdventureActor, isMove: false, hitDamageId_12, commonCenterDis);
			}
			TriggerPerk(perkId_12);
		}
	}

	protected void OnAreaEffectFinish(IEvent evt)
	{
		if (evt is AdventureAreaEffectFinishEvent { entityID: var entityID } adventureAreaEffectFinishEvent)
		{
			if (superWindSummonCor.ContainsKey(entityID))
			{
				_actor.StopLogicCoroutine(superWindSummonCor.get_Item(entityID));
				superWindSummonCor.Remove(entityID);
			}
			if (GetPerkLv(taskPerkId_2, out var _) && allWindLogicId.Contains(entityID))
			{
				PlaySmallHit(adventureAreaEffectFinishEvent.sender as LogicEntity);
			}
		}
	}
}
