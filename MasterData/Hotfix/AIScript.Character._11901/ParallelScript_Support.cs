using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._11901;

public class ParallelScript_Support : ParallelScript
{
	private string scatteringDarts = "Bullet_11901_Skill2_FaShe";

	private string scatteringDarts_P23 = "Bullet_11901_Skill2_FaShe_T23";

	private int smallDartsCount = 12;

	private FP smallDartsShootInterval = 0.05f;

	private string aoe_flower = "AreaEffect_11901_Skill2_BigFlower";

	private FP angle = 0;

	private FP distance = 2.5;

	private const int perkId_21 = 511921;

	private int count_21 = 3;

	private const int perkId_22 = 511922;

	private int paramId_22_cdReduce = 11952212;

	private string areaEffect_22 = "AreaEffect_119_P22_AOE";

	private int paramId_22_count = 11952211;

	private const int perkId_23 = 511923;

	private int once_23 = 11923001;

	private const int perkId_24 = 511924;

	private int hitDmgId_24 = 119504001;

	private string hitEffect_24 = "FX/ActorCommon/fx_common_base_charge_actor";

	private int buffId_24 = 11952411;

	private int once_24 = 11924001;

	private const int perkId_25 = 511925;

	private int once_25 = 11952501;

	private const int parameterId_25 = 11952501;

	private const int perkId_26 = 511926;

	private readonly FP cd_26 = 0;

	private const int buff_26 = 11952611;

	private const int once_26 = 11952601;

	private const int perkId_27 = 511927;

	private const int perkId_28 = 511928;

	private const int once_28 = 11952801;

	private const int perkId_29 = 511929;

	private FP cd_29 = 0;

	private const int once_29 = 11952901;

	private const int perkId_30 = 511930;

	private const int perkId_32 = 511932;

	private const int once_32 = 11953201;

	private const int perkId_31 = 511931;

	private const int buff_31 = 11953111;

	private const int perkId_33 = 511933;

	private const int buff_33 = 11953311;

	private Dictionary<long, HashSet<long>> dicCount_21 = new Dictionary<long, HashSet<long>>();

	private Dictionary<long, int> dicCount_22 = new Dictionary<long, int>();

	private Dictionary<long, HashSet<AdventureActor>> dicMonster_24 = new Dictionary<long, HashSet<AdventureActor>>();

	private Dictionary<long, HashSet<AdventureActor>> dicMonster_26 = new Dictionary<long, HashSet<AdventureActor>>();

	private long tagUid;

	public override void OnEnable()
	{
		base.OnEnable();
		tagUid = 0L;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		dicCount_21.Clear();
		dicCount_22.Clear();
		dicMonster_24.Clear();
		dicMonster_26.Clear();
	}

	protected override void OnMainControlCastSkill(AdventureActorCastSkillEvent evt)
	{
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && GetPerkLv(511931, out var _))
		{
			_actor.buffComponent.AddBuff(11953111, _actor);
		}
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		base.OnBeforeHit(evt, monster);
		int lv;
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SupportSkill))
		{
			if (GetPerkLv(511923, out lv))
			{
				AdventureActor.AddFromAttr(once_23, _actor);
			}
			if (GetPerkLv(511925, out lv) && monster.actorHealthInfo.hpPercentage * 100 > CommonUtils.GetScriptValue(_actor, 11952501))
			{
				AdventureActor.AddFromAttr(once_25, _actor);
			}
			if (GetPerkLv(511926, out lv))
			{
				int buffNumByID = _actor.buffComponent.GetBuffNumByID(11952611);
				if (buffNumByID > 0)
				{
					AdventureActor.AddFromAttr(11952601, _actor, buffNumByID);
				}
			}
			if (GetPerkLv(511928, out lv) && monster.monsterInfo.epicType < HotfixEnum.monsterEpicType.NORMAL)
			{
				AdventureActor.AddFromAttr(11952801, _actor);
			}
			if (GetPerkLv(511929, out lv))
			{
				AdventureActor.AddFromAttr(11952901, _actor);
			}
			if (GetPerkLv(511932, out lv))
			{
				for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
				{
					PlayerSkillCd logicComponent = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).GetLogicComponent<PlayerSkillCd>();
					if ((FP)logicComponent.GetEnergy() >= logicComponent.GetTotalEnergy())
					{
						AdventureActor.AddFromAttr(11953201, _actor);
						break;
					}
				}
			}
		}
		if (GetPerkLv(511924, out lv) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Boom))
		{
			int buffNumByID2 = monster.buffComponent.GetBuffNumByID(buffId_24);
			if (buffNumByID2 > 0)
			{
				AdventureActor.AddFromAttr(once_24, _actor, buffNumByID2);
			}
			monster.buffComponent.RemoveBuffByBuffId(buffId_24);
		}
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster)
	{
		long num = (evt.weapon as AdventureBulletBase)?.tagUid ?? 0;
		int lv;
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_SupportSkill))
		{
			if (GetPerkLv(511921, out lv) && num != 0L)
			{
				if (dicCount_21.TryGetValue(num, out var value))
				{
					if (!value.Contains(monster.Id))
					{
						value.Add(monster.Id);
					}
				}
				else
				{
					dicCount_21.Add(num, new HashSet<long> { monster.Id });
				}
			}
			if (GetPerkLv(511924, out lv) && num != 0L && CheckAreaAlive(num))
			{
				monster.buffComponent.AddBuff(buffId_24, _actor);
				if (dicMonster_24.TryGetValue(num, out var value2))
				{
					if (!value2.Contains(monster))
					{
						value2.Add(monster);
					}
				}
				else
				{
					dicMonster_24.Add(num, new HashSet<AdventureActor> { monster });
				}
			}
			if (GetPerkLv(511926, out lv) && num != 0L && CheckAreaAlive(num))
			{
				if (dicMonster_26.TryGetValue(num, out var value3))
				{
					if (!value3.Contains(monster))
					{
						value3.Add(monster);
						_actor.buffComponent.AddBuff(11952611, _actor);
					}
				}
				else
				{
					dicMonster_26.Add(num, new HashSet<AdventureActor> { monster });
					_actor.buffComponent.AddBuff(11952611, _actor);
				}
			}
			if (GetPerkLv(511933, out lv) && CommonUtils.CheckElementMark(CommonDefine.Wind, monster))
			{
				Singleton<BuffManager>.Instance.AddBufftoGroup(11953311, _actor);
			}
		}
		if (CommonUtils.CheckHitByTag(evt.hitDamageTag, windHitTag) && GetPerkLv(511922, out lv) && CommonUtils.CheckElementMark(CommonDefine.Wind, monster) && num != 0L && CommonUtils.CheckTriggerElementMarkCD(_actor, monster) && CheckAreaAlive(num))
		{
			if (dicCount_22.TryGetValue(num, out var value4))
			{
				dicCount_22.set_Item(num, ++value4);
			}
			else
			{
				dicCount_22.Add(num, value4);
			}
			int num2 = CommonUtils.GetScriptValue(_actor, paramId_22_count).AsInt();
			if (value4 < num2)
			{
				FP scriptValue = CommonUtils.GetScriptValue(_actor, paramId_22_cdReduce);
				skillMgr.ModifyResumeTimeAbs(-scriptValue, ActionKey.B);
				AreaEffectEntity areaEffect = ILRuntimeAPI.GetAreaEffect(num);
				ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect_22, areaEffect.tsTransform.Position);
			}
		}
		base.OnHitPost(evt, monster);
	}

	public override void OnSkillShoot(IEvent evt)
	{
		evt = evt as HanaharaSkillShootEvent;
		if (evt == null || !(evt.sender as AdventureActor == _actor))
		{
			return;
		}
		TSVector2 tSVector = TSVector2.Rotate(_actor.tsTransform.Forward, angle);
		TSVector2 tSVector2 = _actor.tsTransform.Position + tSVector * distance;
		FP terrainHeight = CommonHelper.GetTerrainHeight(tSVector2, _actor.tsTransform.PositionY);
		long areaId = ILRuntimeAPI.PlayAreaEffect(_actor, aoe_flower, tSVector2);
		AreaEffectEntity areaEntity = ILRuntimeAPI.GetAreaEffect(areaId);
		int lv;
		if (areaEntity != null)
		{
			if (GetPerkLv(511927, out lv))
			{
				AdventureSummonCaskSkillEvent adventureSummonCaskSkillEvent = AdventureSummonCaskSkillEvent.Generate();
				adventureSummonCaskSkillEvent.sender = _actor;
				adventureSummonCaskSkillEvent.skillId = skillId_KnifeFan;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureSummonCaskSkillEvent);
			}
			areaEntity.OnBeforeEnd = () =>
			{
				if (GetPerkLv(511924, out var lv2) && dicMonster_24.TryGetValue(areaId, out var value))
				{
					foreach (AdventureActor item in value)
					{
						ILRuntimeAPI.HitActor(_actor, item, hitDmgId_24, hitEffect_24);
					}
				}
				if (GetPerkLv(511930, out lv2))
				{
					AdventureSummonCaskSkillEvent adventureSummonCaskSkillEvent2 = AdventureSummonCaskSkillEvent.Generate();
					adventureSummonCaskSkillEvent2.sender = _actor;
					adventureSummonCaskSkillEvent2.skillId = skillId_Flower;
					ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureSummonCaskSkillEvent2);
				}
				dicCount_21.Remove(areaId);
				dicCount_22.Remove(areaId);
				dicMonster_24.Remove(areaId);
				dicMonster_26.Remove(areaId);
			};
		}
		Vector3 pos = new Vector3((float)tSVector2.x, (float)terrainHeight, (float)tSVector2.y);
		ScatteringDartsEntity scatteringDarts = ShootScatterDart(pos);
		if (!(scatteringDarts != null))
		{
			return;
		}
		if (GetPerkLv(511924, out lv) || GetPerkLv(511922, out lv) || GetPerkLv(511926, out lv))
		{
			scatteringDarts.tagUid = areaId;
		}
		else
		{
			scatteringDarts.tagUid = NewTagUid();
		}
		scatteringDarts.OnBeforeEnd = () =>
		{
			if (GetPerkLv(511921, out var _) && dicCount_21.TryGetValue(scatteringDarts.tagUid, out var value) && value.Count >= count_21)
			{
				scatteringDarts.shootRoundCount++;
				areaEntity?.AddLeftTime(areaEntity.duration);
			}
		};
	}

	private ScatteringDartsEntity ShootScatterDart(Vector3 pos)
	{
		string alias = scatteringDarts;
		if (GetPerkLv(511923, out var _))
		{
			alias = scatteringDarts_P23;
		}
		GameObject gameObject = _actor.comboGroup.relatedResourceConfig?.GetFXByAlias(alias);
		if (gameObject != null)
		{
			ScatteringDartsEntity scatteringDartsEntity = SceneSingleton<SpecialEntityManager>.Instance.GenerateSpecialEntity(gameObject, pos, Quaternion.identity) as ScatteringDartsEntity;
			if (scatteringDartsEntity != null)
			{
				scatteringDartsEntity.dartsCount = smallDartsCount;
				scatteringDartsEntity.shootInterval = smallDartsShootInterval;
				scatteringDartsEntity.shootRoundCount = 1;
				scatteringDartsEntity.Setup(_actor);
			}
			return scatteringDartsEntity;
		}
		return null;
	}

	private long NewTagUid()
	{
		tagUid++;
		return tagUid;
	}

	private bool CheckAreaAlive(long id)
	{
		AreaEffectEntity areaEffect = ILRuntimeAPI.GetAreaEffect(id);
		if (areaEffect != null)
		{
			return areaEffect.ActiveSelf;
		}
		return false;
	}
}
