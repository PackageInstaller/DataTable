using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_NengLiangQiu_Self : SkillSimpleBase
{
	private FP _wanderMaxDuration = 10;

	private FP _wanderLeashRadius = 8;

	private FP _wanderStepMin = 2.4;

	private FP _wanderStepMax = 3.8;

	private FP _wanderTurnMaxDeg = 40;

	private FP _rushOffsetInner = 0;

	private FP _rushOffsetOuter = 2;

	private FP _absorbCheckRadius = 1.2;

	private const string orbExplosionAreaEffect = "AreaEffect_EnergyBall_Explode";

	private static readonly FP[] _juXingEnergyGain = new FP[6] { 10, 10, 10, 10, 10, 10 };

	private string fx_Spawn = "fx_m72011_base_Skill5_EnergyBall_down";

	private string fx_Self = "fx_m72011_bullet_Skill5_EnergyBall";

	private long playfx_Self;

	private bool rushing;

	private bool _isHeXinBaoFaP2Summon;

	private AdventureActor _summoner;

	private int _summonLevel;

	private FP _juXingEnergyGainResolved = 10;

	protected override void OnSkillEnable()
	{
		SetUnparalleledEnable();
		SetCloseBlockEnable();
		_summoner = _actor.GetLogicComponent<MonsterSummonInfo>()?.SummonActor;
		_summonLevel = (int)((_summoner != null) ? ((long)GetLogicTagFpValue(_summoner, Common_73001.SummonLevel_Tag)) : 0);
		int num = _summonLevel;
		if (num < 0)
		{
			num = 0;
		}
		if (num >= _juXingEnergyGain.Length)
		{
			num = _juXingEnergyGain.Length - 1;
		}
		_juXingEnergyGainResolved = _juXingEnergyGain[num];
		_isHeXinBaoFaP2Summon = _summoner != null && GetLogicTagToggleValue(_summoner, Config_JuXingMoXiang.HeXinBaoFa_Phase2_SummonActiveTag);
		rushing = false;
		if (ModuleController<AdventureModuleController>.Instance != null)
		{
			ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvt);
		}
	}

	protected override void OnSkillDisable()
	{
		if (ModuleController<AdventureModuleController>.Instance != null)
		{
			ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvt);
		}
		base.OnSkillDisable();
	}

	private void OnCustomEvt(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent { eventName: not null } adventureActorCustomEvent && adventureActorCustomEvent.eventName.Equals("StartPulling"))
		{
			rushing = true;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		TSVector2 initPos = GetPosition();
		rushing = false;
		PlayEffect(fx_Spawn, 1f, default, GetPosition());
		yield return WaitTime(0.1);
		playfx_Self = PlayEffect(fx_Self, 1f, default, GetPosition(), default, 0.6f);
		if (_isHeXinBaoFaP2Summon)
		{
			while (!TryPlayerAbsorb() && !TrySummonerCollide())
			{
				yield return null;
			}
			yield break;
		}
		FP value = TSRandom.Range(FP.Zero, 360) * TSMath.Deg2Rad;
		TSVector2 wanderDir = new TSVector2(TSMath.Cos(value), TSMath.Sin(value));
		FP leashRadiusSq = _wanderLeashRadius * _wanderLeashRadius;
		FP wanderElapsed = FP.Zero;
		while (!rushing)
		{
			if (_summoner != null && GetLogicTagToggleValue(_summoner, Config_XiaoMoXiang.NLQ_PullStartTag))
			{
				rushing = true;
				break;
			}
			if (wanderElapsed >= _wanderMaxDuration)
			{
				rushing = true;
				break;
			}
			if (TryPlayerAbsorb())
			{
				yield break;
			}
			FP value2 = TSRandom.Range(-_wanderTurnMaxDeg, _wanderTurnMaxDeg) * TSMath.Deg2Rad;
			FP fP = TSMath.Cos(value2);
			FP fP2 = TSMath.Sin(value2);
			wanderDir = new TSVector2(wanderDir.x * fP - wanderDir.y * fP2, wanderDir.x * fP2 + wanderDir.y * fP).normalized;
			FP fP3 = TSRandom.Range(_wanderStepMin, _wanderStepMax);
			TSVector2 position = GetPosition();
			TSVector2 tSVector = position + wanderDir * fP3;
			if (TSVector2.DistanceSquared(tSVector, initPos) > leashRadiusSq)
			{
				wanderDir = (initPos - position).normalized;
				tSVector = position + wanderDir * fP3;
			}
			Skill_NengLiangQiu_Self skill_NengLiangQiu_Self = this;
			TSVector2 position2 = tSVector;
			FP wanderStepMax = _wanderStepMax;
			DeterministicShape shapeData = skill_NengLiangQiu_Self.GetShapeData(DeterministicShape.ShapeType.Circle, position2, default, default, wanderStepMax);
			tSVector = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			bool moveFinished = false;
			_actor.MoveTo(tSVector, 0.1, enableNavigation: false, AdventureActor.MovementMode.Walk, () =>
			{
				moveFinished = true;
			});
			while (!moveFinished && !rushing)
			{
				if (_summoner != null && GetLogicTagToggleValue(_summoner, Config_XiaoMoXiang.NLQ_PullStartTag))
				{
					rushing = true;
					continue;
				}
				if (wanderElapsed >= _wanderMaxDuration)
				{
					rushing = true;
					continue;
				}
				if (TryPlayerAbsorb())
				{
					yield break;
				}
				yield return WaitTime(0.1);
				wanderElapsed += (FP)0.1;
			}
		}
		SetListenEvents();
		StopMove();
		TSVector2 rushOffset = TSVector2.zero;
		if (_summoner != null)
		{
			Skill_NengLiangQiu_Self skill_NengLiangQiu_Self2 = this;
			TSVector2 entityPosition = GetEntityPosition(_summoner);
			FP wanderStepMax = _rushOffsetOuter;
			FP rushOffsetInner = _rushOffsetInner;
			DeterministicShape shapeData2 = skill_NengLiangQiu_Self2.GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, wanderStepMax, rushOffsetInner);
			TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData2, _actor, isReachable: true);
			rushOffset = shapeRandomPoint - GetEntityPosition(_summoner);
		}
		while (true)
		{
			TSVector2 targetPosition = ((_summoner != null) ? (GetEntityPosition(_summoner) + rushOffset) : GetPosition());
			_actor.actorInfo.runSpeed = 6;
			_actor.actorInfo.walkSpeed = 6;
			_actor.MoveTo(targetPosition, 0.1, enableNavigation: true);
			if (TryPlayerAbsorb() || TrySummonerCollide())
			{
				break;
			}
			yield return null;
		}
	}

	private bool TryPlayerAbsorb()
	{
		if (!(GetCurrentPlayer() is AdventureActor { isDead: false } adventureActor))
		{
			return false;
		}
		FP fP = TSVector2.Distance(GetPosition(), GetEntityPosition(adventureActor));
		FP fP2 = _absorbCheckRadius + adventureActor.dtCollider.Radius;
		if (fP > fP2)
		{
			return false;
		}
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = adventureActor;
		adventureActorCustomEvent.actor = _summoner;
		adventureActorCustomEvent.eventHashCode = Config_XiaoMoXiang.evt_OrbAbsorbedByPlayer;
		if (_summoner != null)
		{
			_summoner.DispatchEvent(adventureActorCustomEvent);
		}
		StopEffect(playfx_Self);
		PlayEffect("fx_m72011_base_Skill5_player_charge");
		_actor.DestroySelf();
		return true;
	}

	private bool TrySummonerCollide()
	{
		if (_summoner == null || _summoner.isDead)
		{
			return false;
		}
		FP fP = TSVector2.Distance(GetPosition(), GetEntityPosition(_summoner));
		FP fP2 = _absorbCheckRadius + _summoner.dtCollider.Radius;
		if (fP > fP2)
		{
			return false;
		}
		FP logicTagFpValue = GetLogicTagFpValue(_summoner, Common_73001.EnergyTag);
		FP fP3 = logicTagFpValue + _juXingEnergyGainResolved;
		if (fP3 > 100)
		{
			fP3 = 100;
		}
		SetLogicTagFpValue(_summoner, Common_73001.EnergyTag, fP3);
		AdventureActor adventureActor = _summoner;
		int num = (int)(long)GetLogicTagFpValue(_summoner, Config_JuXingMoXiang.PhaseTag);
		if (num != 2 && _summoner != null)
		{
			int num2 = (int)(long)GetLogicTagFpValue(_summoner, Config_JuXingMoXiang.PartnerDataIdTag);
			if (num2 > 0)
			{
				List<LogicEntity> targetByDataID = GetTargetByDataID(num2);
				if (targetByDataID.Count > 0)
				{
					adventureActor = targetByDataID.get_Item(0) as AdventureActor;
				}
			}
		}
		BossEnergyValueChage((int)(long)fP3, adventureActor);
		if (adventureActor != null && GetLogicTagFpValue(adventureActor, Common_73001.EnergyToReductionEnabledTag) == 1)
		{
			int monsterIdByLevel = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.damageReductionBuffIds);
			int monsterIdByLevel2 = Common_73001.GetMonsterIdByLevel(_summonLevel, Config_XiaoMoXiang.vulnerableBuffIds);
			string fxAlias = ((num == 2) ? "fx_m72012_base_Shield" : "fx_m72011_base_Shield");
			if (Common_73001.TryAddDamageReductionByEnergyGain(adventureActor, fP3 - logicTagFpValue, monsterIdByLevel, monsterIdByLevel2, 8))
			{
				PlayFx(fxAlias, 1f, default, GetEntityPosition(adventureActor), default);
			}
		}
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _summoner;
		adventureActorCustomEvent.actor = _summoner;
		adventureActorCustomEvent.eventHashCode = Config_XiaoMoXiang.evt_OrbAbsorbedByJuXing;
		_summoner.DispatchEvent(adventureActorCustomEvent);
		StopEffect(playfx_Self);
		PlayAreaEffect("AreaEffect_EnergyBall_Explode", GetPosition());
		_actor.DestroySelf();
		return true;
	}
}
