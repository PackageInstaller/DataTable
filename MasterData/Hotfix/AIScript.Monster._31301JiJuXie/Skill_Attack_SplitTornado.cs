using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_Attack_SplitTornado : SkillSimpleBase
{
	private static readonly string areaFx_Split = "Area_31301JiJuXie_SplitTornado";

	private static readonly string areaFx_SplitMini = "Area_31301JiJuXie_SplitTornado_Small";

	private static readonly string areaFx_IceSplit = "Area_31301JiJuXie_IceSplitTornado";

	private static readonly string areaFx_IceSplitMini = "Area_31301JiJuXie_IceSplitTornado_Small";

	private long TraceTornado_EndFX;

	private long WarningFX;

	private CoroutineNode corBounce;

	private readonly FP SplitTornado_DashSpeed = 6;

	private readonly FP SplitTornado_DashDistance = 25;

	private readonly FP SplitTornadoSmall_DashSpeed = 10;

	private readonly FP SplitTornadoSmall_DashDistance = 120;

	private readonly FP SplitTornado_Duration = 8;

	private readonly FP SplitSpawn_Interval = 0.3;

	private readonly FP SplitSpawn_FirstDelay = 0.3;

	private readonly int SplitSpawn_Count = 3;

	private readonly FP SplitSpawn_StartAngle = -70;

	private readonly FP SplitSpawn_IntervalAngle = 60;

	private static readonly TSVector2 Bounce_SceneCenter = new TSVector2(0, 0);

	private readonly FP Bounce_InnerRadius = 13.8;

	private long areaEffectId;

	private bool isAreaPlaying;

	private bool isIced;

	private bool isMini;

	private bool isBroken;

	private int summonMonsterID;

	private CoroutineNode corSpawn;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		isAreaPlaying = false;
		isIced = false;
		isBroken = true;
		isMini = GetLogicTagToggleValue(_actor, Config.LogicTag_IsMiniSplitTornado);
		summonMonsterID = GetTeammateIdByIndex(5);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_ENTER_EXIT", OnAreaEffectEnterExit);
	}

	protected override void OnSkillDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_ENTER_EXIT", OnAreaEffectEnterExit);
		StopCor(corSpawn);
		corSpawn = null;
		StopCor(corBounce);
		corBounce = null;
		StopAreaEffect_Safe();
		StopDash();
		StopEffect(WarningFX);
		_actor.DestroySelf();
	}

	private void OnAreaEffectEnterExit(IEvent evt)
	{
		if (!isIced && evt is AdventureAreaEnterExitEvent { iEnter: not false, sender: AreaEffectEntity sender } adventureAreaEnterExitEvent && sender.CheckTag(Config.areaTag_IceMist) && !(adventureAreaEnterExitEvent.triggerCollider == null) && !(adventureAreaEnterExitEvent.triggerCollider.Entity != _actor))
		{
			if (isAreaPlaying)
			{
				StopAreaEffect(areaEffectId);
				isAreaPlaying = false;
			}
			string fxAlias = (isMini ? areaFx_IceSplitMini : areaFx_IceSplit);
			areaEffectId = PlayAreaEffect(fxAlias, GetPosition(), GetRotation());
			isAreaPlaying = true;
			isIced = true;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		if (!isMini)
		{
			string fxAlias = areaFx_Split;
			areaEffectId = PlayAreaEffect(fxAlias, GetPosition(), GetRotation());
			isAreaPlaying = true;
			LogicEntity logicEntity = GetAttackTarget();
			if (logicEntity == null)
			{
				logicEntity = GetCurrentPlayer();
			}
			if (logicEntity != null)
			{
				BeginLookAt_NotWait(logicEntity, 0.8, 7200);
			}
			yield return WaitTime(0.8);
			Skill_Attack_SplitTornado skill_Attack_SplitTornado = this;
			Skill_Attack_SplitTornado skill_Attack_SplitTornado2 = this;
			TSVector2 position = GetPosition();
			FP rotation = GetRotation();
			skill_Attack_SplitTornado.WarningFX = skill_Attack_SplitTornado2.PlayEarlyWarningEffect("fx_warning_dash_2x20", 1.2f, default, position, rotation, 2f);
			yield return WaitTime(1.2);
			BeginDashActorForward(1, SplitTornado_DashSpeed, SplitTornado_DashDistance, 720, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
		}
		else
		{
			string fxAlias2 = areaFx_SplitMini;
			areaEffectId = PlayAreaEffect(fxAlias2, GetPosition(), GetRotation());
			isAreaPlaying = true;
			BeginDashActorForward(1, SplitTornadoSmall_DashSpeed, SplitTornadoSmall_DashDistance, 720, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
		}
		if (!isMini)
		{
			corSpawn = StartCor(LoopSpawnMini());
		}
		if (isMini)
		{
			corBounce = StartCor(LoopBounceCheck());
		}
		if (!isMini)
		{
			yield return WaitDashFinish();
			if (!isIced)
			{
				StopAreaEffect_Safe();
				TraceTornado_EndFX = PlayEffect("fx_m31301_base_skill1_Cyclones_water_end", 1f, 0, GetPosition(), 0);
			}
			else
			{
				StopAreaEffect_Safe();
				TraceTornado_EndFX = PlayEffect("fx_m31301_base_skill1_Cyclones_ice_end", 1f, 0, GetPosition(), 0);
			}
		}
		else
		{
			FP elapsed = 0;
			for (FP duration = SplitTornado_Duration; elapsed < duration; elapsed += _actor.LogicDeltaTime)
			{
				yield return null;
			}
			if (!isIced)
			{
				StopAreaEffect_Safe();
				TraceTornado_EndFX = PlayEffect("fx_m31301_base_skill1_Cyclones_water_small_end", 1f, 0, GetPosition(), 0);
			}
			else
			{
				StopAreaEffect_Safe();
				TraceTornado_EndFX = PlayEffect("fx_m31301_base_skill1_Cyclones_ice_small_end", 1f, 0, GetPosition(), 0);
			}
		}
		isBroken = false;
		StopCor(corSpawn);
		corSpawn = null;
		StopCor(corBounce);
		corBounce = null;
		yield return WaitTime(6);
	}

	private IEnumerator LoopBounceCheck()
	{
		FP remaining = SplitTornadoSmall_DashDistance;
		TSVector2 segmentStart = GetPosition();
		while (true)
		{
			yield return null;
			TSVector2 position = GetPosition();
			TSVector2 tSVector = position - Bounce_SceneCenter;
			if (tSVector.magnitude < Bounce_InnerRadius)
			{
				continue;
			}
			TSVector2 normalized = tSVector.normalized;
			TSVector2 normalized2 = _actor.tsTransform.Forward.normalized;
			FP fP = TSVector2.Dot(normalized2, normalized);
			if (!(fP <= 0))
			{
				remaining -= (position - segmentStart).magnitude;
				if (remaining <= 0)
				{
					break;
				}
				TSVector2 normalized3 = (normalized2 - 2 * fP * normalized).normalized;
				_actor.tsTransform.Forward = normalized3;
				StopDash();
				BeginDashActorForward(1, SplitTornadoSmall_DashSpeed, remaining, 720, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
				segmentStart = GetPosition();
			}
		}
		StopDash();
	}

	private IEnumerator LoopSpawnMini()
	{
		yield return WaitTime(SplitSpawn_FirstDelay);
		for (int i = 0; i < SplitSpawn_Count; i++)
		{
			FP degrees = SplitSpawn_StartAngle + SplitSpawn_IntervalAngle * i;
			TSVector2 spawnDir = TSVector2.Rotate(_actor.tsTransform.Forward, degrees);
			SpawnMiniTornado(spawnDir);
			yield return WaitTime(SplitSpawn_Interval);
		}
	}

	private void SpawnMiniTornado(TSVector2 spawnDir)
	{
		TSVector2 pos = GetPosition() + new TSVector2(1, 0);
		PlayEffect("fx_m31301_base_charge", 1f, 1, GetPosition(), 0, 2f);
		ILRuntimeAPI.SummonMonster(_actor, 0, summonMonsterID, pos, spawnDir, null, null, (MonsterAdventureActor entity) =>
		{
			if (entity != null)
			{
				SetLogicTagToggleValue(entity, Config.LogicTag_IsMiniSplitTornado, value: true);
			}
		});
	}

	private void StopAreaEffect_Safe()
	{
		if (isAreaPlaying)
		{
			StopAreaEffect(areaEffectId);
			isAreaPlaying = false;
			areaEffectId = 0L;
		}
		if (!isBroken)
		{
			return;
		}
		if (!isMini)
		{
			if (!isIced)
			{
				TraceTornado_EndFX = PlayEffect("fx_m31301_base_skill1_Cyclones_water_end", 1f, 0, GetPosition(), 0);
			}
			else
			{
				TraceTornado_EndFX = PlayEffect("fx_m31301_base_skill1_Cyclones_ice_end", 1f, 0, GetPosition(), 0);
			}
		}
		else if (!isIced)
		{
			TraceTornado_EndFX = PlayEffect("fx_m31301_base_skill1_Cyclones_water_small_end", 1f, 0, GetPosition(), 0);
		}
		else
		{
			TraceTornado_EndFX = PlayEffect("fx_m31301_base_skill1_Cyclones_ice_small_end", 1f, 0, GetPosition(), 0);
		}
	}
}
