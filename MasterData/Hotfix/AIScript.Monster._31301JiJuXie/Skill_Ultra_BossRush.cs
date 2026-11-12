using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_Ultra_BossRush : SkillSimpleBase
{
	private static readonly string combo_Burrow_Down = "Burrow_Down";

	private static readonly string combo_Ultra_Charge = "Ultra_Charge_BossRush";

	private static readonly string combo_Turn_Left = "Turn_Left";

	private static readonly string combo_Turn_Right = "Turn_Right";

	private static readonly string combo_Burrow_Up = "Burrow_Up";

	private static readonly string evt_Fx = "Event_Effet";

	private static readonly string evt_Camera = "Camera";

	private static readonly string evt_ClearBuff = "Event_ClearBuff";

	private static readonly string areaFx_FollowWave = "Area_31301JiJuXie_Ultra_IceTornado_BossRush";

	private static readonly string areaFx_Gravitational = "Area_31301JiJuXie_Ultra_IceTornadoGravitational_BossRush";

	private static readonly string areaFx_RingWave = "Area_31301JiJuXie_Ultra_RingWave";

	private static TSVector2 Ultra_BossCenterPos = new TSVector2(0, 0.1);

	private static TSVector2 Ultra_TornadoLeftPos = new TSVector2(-12, 0);

	private static TSVector2 Ultra_TornadoRightPos = new TSVector2(12, 0);

	private static FP Ultra_CollideThreshold_1 = 3;

	private static FP Ultra_CollideThreshold_2 = 1;

	private static FP Ultra_KnockShockSpeed = 10;

	private static FP Ultra_RetreatDistance = 3;

	private string tag1 = "Monster1";

	private long Area1;

	private long Area3;

	private bool isHidden;

	private int ultraTornadoMonsterID;

	private AdventureActor leftTornado;

	private AdventureActor rightTornado;

	private CoroutineNode corMove;

	private CoroutineNode Fxwaring;

	private Dash dash_left = new Dash();

	private Dash dash_right = new Dash();

	private List<long> areas = new List<long>();

	private long WarningFx;

	private long WarningFx1;

	private long GroundFx;

	private long SnowFX;

	private long AirBoomFX;

	private int phase;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		SetLockToughnessEnable();
		isHidden = false;
		dash_left.Clear();
		dash_right.Clear();
		areas.Clear();
		ultraTornadoMonsterID = GetTeammateIdByIndex(6);
		phase = GetLogicTagFpValue(_actor, "Phase").AsInt();
		SetLogicTagToggleValue(_actor, "CallActive", value: false);
	}

	protected override void OnSkillDisable()
	{
		if (isHidden)
		{
			ExitBurrow();
		}
		StopCor(corMove);
		corMove = null;
		StopCor(Fxwaring);
		Fxwaring = null;
		SetLockToughnessDisable();
		leftTornado = null;
		rightTornado = null;
		SetLogicTagToggleValue(_actor, Config.Skill_Ultra_Finish, value: true);
		CancelAim();
		dash_left.Clear();
		dash_right.Clear();
		StopEffect_Wave();
		StopEffect(WarningFx);
		StopEffect(WarningFx1);
		StopEffect(AirBoomFX);
		StopEffect(GroundFx);
		StopEffect(SnowFX);
		StopAreaEffect(Area1);
		StopAreaEffect(Area3);
	}

	protected override IEnumerator DoMainLogic()
	{
		if (Distance(GetPosition(), new TSVector2(0, 0.1)) <= 5.5)
		{
			MoveToPosition(TSVector2.zero, 0.1, AdventureActor.MovementMode.Run, 5);
			yield return WaitMoveStatus();
			TSVector2 forward = GetForward();
			TSVector2 value = new TSVector2(0, -5) - GetPosition();
			TSVector2 value2 = new TSVector2(forward.y, -forward.x);
			string actionKey = ((TSVector2.Dot(value, value2) > 0) ? combo_Turn_Left : combo_Turn_Right);
			BeginAttack(1, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
			BeginLookAtByPos(new TSVector2(0, -5), 0, (FP)90 / (FP)0.66);
			yield return WaitTime(1.3);
			StopWaitLookAt();
		}
		else
		{
			BeginAttack(2, combo_Burrow_Down, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitTime(1.15);
			EnterBurrow();
			yield return WaitTime(0.18);
			TSVector2 position = GetPosition();
			Vector3 startPosition = new Vector3((float)position.x, 0f, (float)position.y);
			Vector3 targetPosition = new Vector3((float)Ultra_BossCenterPos.x, 0f, (float)Ultra_BossCenterPos.y);
			float speed = (float)(Distance(position, Ultra_BossCenterPos) / 0.6);
			PlayMovableFx("fx_m31301_loop_skill4_loop_move_root", startPosition, targetPosition, speed, () =>
			{
				WarningFx = PlayEffect("fx_m31301_loop_skill4_loop_move_root", 1f, 0, Ultra_BossCenterPos, 0);
			});
			yield return WaitTime(0.6);
			Teleport(Ultra_BossCenterPos);
			BeginLookAtByPos_NotWait(new TSVector2(0, -5), 0.4, 400);
			yield return WaitTime(0.4);
			StopTrace();
			StopEffect(WarningFx);
			WarningFx1 = PlayEffect("fx_m31301_base_skill4_end_move_warning", 2f, 1, GetPosition(), 0);
			yield return WaitTime(0.3);
			BeginAttack(3, combo_Burrow_Up, flushInputedKeys: true, forceInterruptAttack: true);
			ExitBurrow();
			yield return WaitTime(1.4);
		}
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.actor = _actor;
		adventureActorCustomEvent.eventHashCode = Config.evt_SprayWaterBatteryUltra;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
		SetLogicTagToggleValue(_actor, "CallActive", value: true);
		BeginAttack(4, combo_Ultra_Charge, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(evt_Fx);
		GroundFx = PlayEffect("fx_m31301_loop_skill8_ground", 1f, 1, GetPosition(), 0);
		SnowFX = PlayEffect("fx_m31301_loop_skill8_snow", 1f, 1, GetPosition(), 0);
		yield return WaitCustomEvent(evt_ClearBuff);
		LogicEntity currentPlayer = GetCurrentPlayer();
		if (currentPlayer != null)
		{
			RemoveBuffFromTarget(currentPlayer, 0, 0, CommonHelper.StringToHash("Buff"));
		}
		yield return WaitTime(0.8);
		SpawnUltraTornadoes();
		yield return WaitUntil(() => leftTornado != null && rightTornado != null);
		PlayEffect_Wave();
		corMove = StartCor(MoveTornadoes());
		string monsterTag = GetMonsterTagValue(_actor, 1);
		if (monsterTag != tag1)
		{
			LogicEntity player = GetCurrentPlayer();
			if (player != null)
			{
				yield return WaitTime(0.1);
			}
			Area1 = PlayAreaEffect("Area_31301JiJuXie_BingCi_Trace_Ultra_BossRush", GetEntityPosition(player), GetRotation());
		}
		yield return WaitTime(1.5);
		SetLockToughnessDisable();
		yield return StartCor(WaitTornadoCollision(Ultra_CollideThreshold_1));
		yield return StartCor(WaitTornadoCollision(Ultra_CollideThreshold_2));
		if (monsterTag != tag1)
		{
			StopAreaEffect(Area1);
		}
		AddBuffToTarget(leftTornado, 313010060);
		AddBuffToTarget(rightTornado, 313010060);
		PlayEffect("fx_m31301_base_charge", 1f, 2, GetPosition(), 0, 3.5f);
		StopCor(corMove);
		corMove = null;
		bool dashFinished_left = false;
		bool dashFinished_right = false;
		dash_left.BeginDash(leftTornado, leftTornado.tsTransform.Back, Ultra_KnockShockSpeed, Ultra_RetreatDistance, default, () =>
		{
			dashFinished_left = true;
		}, null, null, comboWithAttack: false, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		dash_right.BeginDash(rightTornado, rightTornado.tsTransform.Back, Ultra_KnockShockSpeed, Ultra_RetreatDistance, default, () =>
		{
			dashFinished_right = true;
		}, null, null, comboWithAttack: false, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitUntil(() => dashFinished_left & dashFinished_right);
		corMove = StartCor(MoveTornadoes());
		Fxwaring = StartCor(Warning());
		yield return WaitTime(2);
		yield return StartCor(WaitTornadoCollision(Ultra_CollideThreshold_2));
		Area3 = PlayAreaEffect("Area_31301JiJuXie_Ultra_IceTornado_BossRush", GetPosition(), GetRotation());
		CancelAttack();
		PlayEffect("fx_m31301_base_charge", 1f, 2, GetPosition(), 0, 3.5f);
		yield return WaitFrame(3);
		StopCor(corMove);
		corMove = null;
		leftTornado.DestroySelf();
		rightTornado.DestroySelf();
		StopEffect_Wave();
		StopEffect(GroundFx);
		StopEffect(SnowFX);
		StopAreaEffect(Area3);
		yield return WaitCustomEvent(evt_Camera);
		PlayFeedbackEffect("CameraShake_Down");
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void EnterBurrow()
	{
		if (!isHidden)
		{
			CommonUtils_MonsterAPI.SetUnparalleledEnable(_actor);
			SetHideModelEnable();
			SetCloseBlockEnable();
			_actor.PauseMovementBlock();
			isHidden = true;
		}
	}

	private void ExitBurrow()
	{
		if (isHidden)
		{
			CommonUtils_MonsterAPI.SetUnparalleledDisable(_actor);
			SetHideModelDisable();
			SetCloseBlockDisable();
			_actor.ResumeMovementBlock();
			isHidden = false;
		}
	}

	private void PlayEffect_Wave()
	{
		long item = ILRuntimeAPI.PlayAreaEffect(_actor, areaFx_FollowWave, leftTornado.tsTransform.Position, default, (AreaEffectEntity entity) =>
		{
			AreaEffect_FollowComponent areaEffectComponent = entity.GetAreaEffectComponent<AreaEffect_FollowComponent>();
			if (areaEffectComponent != null)
			{
				areaEffectComponent.targetType = AreaEffect_FollowComponent.FollowTargetType.SpecifiedTarget;
				areaEffectComponent.FollowTarget = leftTornado;
			}
		});
		areas.Add(item);
		item = ILRuntimeAPI.PlayAreaEffect(_actor, areaFx_FollowWave, rightTornado.tsTransform.Position, default, (AreaEffectEntity entity) =>
		{
			AreaEffect_FollowComponent areaEffectComponent = entity.GetAreaEffectComponent<AreaEffect_FollowComponent>();
			if (areaEffectComponent != null)
			{
				areaEffectComponent.targetType = AreaEffect_FollowComponent.FollowTargetType.SpecifiedTarget;
				areaEffectComponent.FollowTarget = rightTornado;
			}
		});
		areas.Add(item);
		item = ILRuntimeAPI.PlayAreaEffect(_actor, areaFx_Gravitational, leftTornado.tsTransform.Position, default, (AreaEffectEntity entity) =>
		{
			AreaEffect_FollowComponent areaEffectComponent = entity.GetAreaEffectComponent<AreaEffect_FollowComponent>();
			if (areaEffectComponent != null)
			{
				areaEffectComponent.targetType = AreaEffect_FollowComponent.FollowTargetType.SpecifiedTarget;
				areaEffectComponent.FollowTarget = leftTornado;
			}
		});
		areas.Add(item);
		item = ILRuntimeAPI.PlayAreaEffect(_actor, areaFx_Gravitational, rightTornado.tsTransform.Position, default, (AreaEffectEntity entity) =>
		{
			AreaEffect_FollowComponent areaEffectComponent = entity.GetAreaEffectComponent<AreaEffect_FollowComponent>();
			if (areaEffectComponent != null)
			{
				areaEffectComponent.targetType = AreaEffect_FollowComponent.FollowTargetType.SpecifiedTarget;
				areaEffectComponent.FollowTarget = rightTornado;
			}
		});
		areas.Add(item);
	}

	private void StopEffect_Wave()
	{
		for (int i = 0; i < areas.Count; i++)
		{
			StopAreaEffect(areas.get_Item(i));
		}
		areas.Clear();
	}

	private void SpawnUltraTornadoes()
	{
		TSVector2 ultra_BossCenterPos = Ultra_BossCenterPos;
		SummonCfg cfg = new SummonCfg();
		ILRuntimeAPI.SummonMonster(dir: (ultra_BossCenterPos - Ultra_TornadoLeftPos).normalized, actor: _actor, groupId: 0, monsterId: ultraTornadoMonsterID, pos: Ultra_TornadoLeftPos, cfg: cfg, summonGroupSuffix: null, finishCallback: (MonsterAdventureActor entity) =>
		{
			leftTornado = entity;
		});
		TSVector2 normalized = (ultra_BossCenterPos - Ultra_TornadoRightPos).normalized;
		ILRuntimeAPI.SummonMonster(_actor, 0, ultraTornadoMonsterID, Ultra_TornadoRightPos, normalized, cfg, null, (MonsterAdventureActor entity) =>
		{
			rightTornado = entity;
		});
	}

	private IEnumerator MoveTornadoes()
	{
		TSVector2 center = Ultra_BossCenterPos;
		while (true)
		{
			MoveEntityToward(leftTornado, center);
			MoveEntityToward(rightTornado, center);
			yield return null;
		}
	}

	private void MoveEntityToward(AdventureActor entity, TSVector2 target)
	{
		if (!(entity == null))
		{
			entity.MoveTo(target, 0.1f);
		}
	}

	private IEnumerator WaitTornadoCollision(FP collideThreshold)
	{
		while (!(leftTornado == null) && !(rightTornado == null) && !(TSVector2.Distance(leftTornado.tsTransform.Position, rightTornado.tsTransform.Position) < collideThreshold))
		{
			yield return null;
		}
	}

	private IEnumerator Warning()
	{
		yield return WaitTime(0.2);
		PlayAreaEffect("Area_31301JiJuXie_Ultra_Damge", GetPosition(), GetRotation());
	}
}
