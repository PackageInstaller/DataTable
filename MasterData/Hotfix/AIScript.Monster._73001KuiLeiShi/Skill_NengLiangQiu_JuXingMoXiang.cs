using System.Collections;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_NengLiangQiu_JuXingMoXiang : Skill_NengLiangQiuBase
{
	private const string combo_NLQPhase2 = "NLQPhase2";

	private FP pullDelay = 10;

	private FP pullDuration = 5;

	private TSVector2 fieldCenter = new TSVector2(0, 0);

	private FP mineSpawnInterval = 2;

	private FP mineSpawnRadius = 8;

	private const string mineAreaEffectAlias = "";

	private string fx_pull = "fx_m72012_loop_skill05_gravitational_field_30x30";

	private long playfx_pull;

	private long pullarea;

	private bool finished;

	private CoroutineNode orbCor;

	private CoroutineNode phantomCor;

	protected override AdventureActor GetBossActor()
	{
		return _actor;
	}

	protected override AdventureActor GetEnergyTarget()
	{
		return _actor;
	}

	protected override void PlayDamageReductionAddedFx(AdventureActor boss)
	{
		if (!(boss == null))
		{
			PlayFx("fx_m72012_base_Shield", 1f, default, GetEntityPosition(boss), default);
		}
	}

	protected override void PlayDamageReductionRemovedFx(AdventureActor boss, AdventureActor player)
	{
		if (!(boss == null))
		{
			GameObject gameObject = player?.gameObject;
			if (gameObject != null)
			{
				TSVector2 entityPosition = GetEntityPosition(player);
				TSVector sourcePosition = new TSVector(entityPosition.x, 0, entityPosition.y);
				PlayLinkFX("fx_m72012_base_shootline_1", useCustomSource: true, gameObject, sourcePosition, FP.Zero, boss.gameObject, TSVector.zero, FP.Zero, breakWhenLostSourceOrTarget: false);
			}
			PlayFx("fx_m72012_base_Shield_down", 1f, default, GetEntityPosition(boss), default);
		}
	}

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		finished = false;
	}

	protected override IEnumerator DoMainLogic()
	{
		InitNLQState();
		BeginLookAtByPos_NotWait(fieldCenter, 0.3, 2000);
		yield return WaitTime(0.3);
		BeginAttack(1, "NLQPhase2", flushInputedKeys: true);
		yield return WaitTime(0.5f);
		orbCor = StartCoroutine(OrbSpawnLoop());
		phantomCor = StartCoroutine(PhantomSpawnLoop());
		yield return WaitTime(pullDelay);
		SetLogicTagToggleValue(_actor, Config_XiaoMoXiang.NLQ_PullStartTag, value: true);
		playfx_pull = PlayEffect(fx_pull, 1f, default, new TSVector2(0, 0), 180 + GetRotation());
		pullarea = PlayAreaEffect("AreaEffect_72012_Skill5_QianYin", GetPosition(), GetEntityAngle(_actor));
		DispatchCustomEvent("StartPulling", isSelfEvent: false);
		FP pullElapsed = FP.Zero;
		while (GetMonsterSummonNum(_actor, _orbId) != 0)
		{
			yield return WaitTime(0.1);
			pullElapsed += (FP)0.1;
			if (!(pullElapsed >= pullDuration))
			{
				continue;
			}
			foreach (LogicEntity item in GetTargetByDataID(_orbId))
			{
				if (item is AdventureActor adventureActor)
				{
					adventureActor.DestroySelf();
				}
			}
			break;
		}
		yield return WaitTime(0.8f);
		StopEffect(playfx_pull);
		StopAreaEffect(pullarea);
		StopSpawnCoroutines();
		CancelAttack();
		InitNLQState();
		finished = true;
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator MineSpawnLoop()
	{
		while (true)
		{
			yield return WaitTime(mineSpawnInterval);
			Skill_NengLiangQiu_JuXingMoXiang skill_NengLiangQiu_JuXingMoXiang = this;
			TSVector2 position = fieldCenter;
			FP radius = mineSpawnRadius;
			DeterministicShape shapeData = skill_NengLiangQiu_JuXingMoXiang.GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius);
			TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			PlayAreaEffect("", shapeRandomPoint);
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (playfx_pull >= 0)
		{
			StopEffect(playfx_pull);
		}
		playfx_pull = -1L;
		StopSpawnCoroutines();
		if (!finished)
		{
			StopAreaEffect(pullarea);
			ClearOwnerBullet();
			ClearActors(GetTargetByDataID(_orbId));
			ClearActors(GetTargetByDataID(_phantomId));
		}
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		if (playfx_pull >= 0)
		{
			StopEffect(playfx_pull);
		}
		playfx_pull = -1L;
		StopAreaEffect(pullarea);
		StopSpawnCoroutines();
		ClearOwnerBullet();
		ClearActors(GetTargetByDataID(_orbId));
		ClearActors(GetTargetByDataID(_phantomId));
	}

	private void StopSpawnCoroutines()
	{
		if (orbCor != null)
		{
			StopCoroutine(orbCor);
			orbCor = null;
		}
		if (phantomCor != null)
		{
			StopCoroutine(phantomCor);
			phantomCor = null;
		}
	}
}
