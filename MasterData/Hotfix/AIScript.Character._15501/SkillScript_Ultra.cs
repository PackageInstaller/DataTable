using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._15501;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private const string actionKey1 = "155_Ultra_TL";

	private const string actionKey2 = "155_Ultra_NoTL";

	private string evt_hideIdle = "155_Ultra_Start";

	private string evt_showIdle = "155_Ultra_End";

	private string areaEffect = "AreaEffect_15501_Ultra";

	private const string starFxPath = "fx_15501_loop_Ultra_UI";

	private readonly FP shootInterval = 0.1;

	private readonly FP shootTime = 4;

	private readonly FP endTime = 4;

	private readonly FP speed = 8f;

	private readonly FP beginShoot = 0.2;

	private readonly FP srcInnerRadius = 0.7;

	private readonly FP srcOuterRadius = 0.9;

	private readonly FP desInnerRadius = 0;

	private readonly FP desOuterRadius = 4;

	private const float offsetNearClip = -2f;

	private const float offsetNearClip2 = 0.1f;

	private const float fxScale = 1f;

	private const int moveAare = 20;

	private readonly FP radius = 15;

	private int showOrHideIdleEvt = CommonHelper.StringToHash("showOrHideIdleEvt");

	private const int perkId_43 = 515543;

	private FP shootInterval_43 = 0.08;

	private CoroutineNode corMain;

	private CoroutineNode corShoot;

	private CoroutineNode corFollow;

	private TrueSyncTransform objActor;

	private PlayTimeline _playTimeline = new PlayTimeline();

	private TSVector2 center = new TSVector2(Screen.width / 2, Screen.height / 2);

	private PlayFX playFX = new PlayFX();

	private PlayFX playStartFX = new PlayFX();

	private PlayFX playEndFX = new PlayFX();

	private AdventureCustomCameraControlHandler adventureCustomCameraControlHandler;

	private List<AdventureFXPlayer> adventureFXPlayerList = new List<AdventureFXPlayer>();

	private string actionKey;

	private bool outControll;

	private bool isAssist;

	private TSVector2 lastTargetPos;

	private LogicEntity target;

	private long areaEffectId;

	private FP jumpDis = 3;

	private FP jumpHeight = 20;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		isAssist = (_actor as PlayerAdventureActor).isAssist;
		if (isAssist)
		{
			outControll = true;
		}
		else
		{
			outControll = false;
		}
		_actor.EnableInvincible();
		_actor.EnableCloseBlock();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Clear();
	}

	public void OnStart()
	{
		MonoSingleton<LuaManager>.Instance.FireEvent("UICloseEvent", a1: false);
		_playTimeline.Play(_actor, () =>
		{
			actionKey = "155_Ultra_TL";
			MonoSingleton<LuaManager>.Instance.FireEvent("UICloseEvent", a1: true);
			StartCoroutine(ref corMain, DoMainLogic(hasTimeline: true));
		}, () =>
		{
			actionKey = "155_Ultra_NoTL";
			MonoSingleton<LuaManager>.Instance.FireEvent("UICloseEvent", a1: true);
			StartCoroutine(ref corMain, DoMainLogic(hasTimeline: false));
		});
	}

	public void OnStop()
	{
		Debug.Log("OnStop");
		Clear();
	}

	public void OnUpdate()
	{
		DoUpdateLogic();
	}

	private void Clear()
	{
		StopCoroutine(ref corMain);
		StopCoroutine(ref corShoot);
		StopCoroutine(ref corFollow);
		ExitControl();
		_actor.DisableInvincible();
		_actor.DisableCloseBlock();
	}

	private IEnumerator DoMainLogic(bool hasTimeline)
	{
		SkillScript_Ultra skillScript_Ultra = this;
		string actionTag = actionKey;
		Action<string> action = onCustomEvent;
		System.Action onComboFinish = OnFinishOrInterrupt;
		System.Action onInterrupt = OnFinishOrInterrupt;
		RequestComboAttack req = skillScript_Ultra.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
		if (!hasTimeline)
		{
			while (!req.isAnticipationEnd)
			{
				yield return null;
			}
		}
		target = SeachTarget();
		if (!outControll)
		{
			EnterControl();
		}
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(beginShoot));
		_ = _actor.LogicTime;
		StartCoroutine(ref corShoot, Shoot());
		FP seconds = endTime;
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(seconds));
		playStartFX.Stop();
		_actor.CancelAttack();
	}

	private void EnterControl()
	{
		ModuleController<AdventureModuleController>.Instance.ActivePlayerCameraTrigger("UltraVmTiriggger_Gizmo");
		adventureCustomCameraControlHandler = ModuleController<AdventureModuleController>.Instance.CurCameraTriggerGizmo.CustomCameraControlHandlers[0];
		Transform vmPlayer = adventureCustomCameraControlHandler.vmPlayer;
		objActor = vmPlayer.GetComponent<TrueSyncTransform>();
		objActor.Init();
		objActor.transformSyncEnabled = true;
		bool raycastHit;
		if (target != null)
		{
			if (_actor.QueryPositionReachable(target.tsTransform.Position))
			{
				objActor.Position = target.tsTransform.Position;
				objActor.PositionY = CommonHelper.GetTerrainHeight(objActor.Position, objActor.PositionY, out raycastHit);
			}
			else
			{
				LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
				objActor.Position = activedPlayerActor.tsTransform.Position;
				objActor.PositionY = CommonHelper.GetTerrainHeight(objActor.Position, objActor.PositionY, out raycastHit);
			}
		}
		else
		{
			LogicEntity activedPlayerActor2 = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
			objActor.Position = activedPlayerActor2.tsTransform.Position;
			objActor.PositionY = CommonHelper.GetTerrainHeight(objActor.Position, objActor.PositionY, out raycastHit);
		}
		playStartFX.Play(_actor, _skill, "fx_15501_loop_Ultra_UI", 0, TSVector2.zero, _actor.tsTransform.Forward);
	}

	private void ExitControl()
	{
		if (outControll)
		{
			return;
		}
		foreach (AdventureFXPlayer adventureFXPlayer in adventureFXPlayerList)
		{
			if (adventureFXPlayer.isPlaying)
			{
				adventureFXPlayer.Stop();
			}
		}
		playStartFX.Stop();
		playEndFX.Stop();
		ILRuntimeAPI.StopAreaEffect(areaEffectId);
		ModuleController<AdventureModuleController>.Instance.DeactivePlayerCameraTrigger("UltraVmTiriggger_Gizmo");
	}

	private IEnumerator Shoot()
	{
		adventureFXPlayerList.Clear();
		FP escapeTime = 0;
		lastTargetPos = TSVector2.zero;
		FP totleShootTime = shootTime;
		FP _shootInterval = (GetPerk(515543) ? shootInterval_43 : shootInterval);
		_ = _actor.LogicTime;
		FP curInterval = 0;
		while (escapeTime < totleShootTime)
		{
			if (curInterval >= _shootInterval || curInterval <= 0)
			{
				if (curInterval >= _shootInterval)
				{
					curInterval -= _shootInterval;
				}
				_ = Vector3.zero;
				_ = TSVector2.zero;
				TSVector2 tSVector2;
				Vector3 position;
				if (!outControll)
				{
					TSVector2 tSVector = TrueSyncExtensions.RandomPointInsideRing(center, Screen.width / 2 * srcInnerRadius, Screen.width / 2 * srcOuterRadius);
					while (tSVector.y > Screen.height || tSVector.y < 0)
					{
						tSVector = TrueSyncExtensions.RandomPointInsideRing(center, Screen.width / 2 * srcInnerRadius, Screen.width / 2 * srcOuterRadius);
					}
					position = new Vector3((float)tSVector.x, (float)tSVector.y, MonoSingleton<GameCameraStackManager>.Instance.mainCamera.nearClipPlane + -2f);
					Vector3 position2 = new Vector3((float)tSVector.x, (float)tSVector.y, MonoSingleton<GameCameraStackManager>.Instance.mainCamera.nearClipPlane + 0.1f);
					position = MonoSingleton<GameCameraStackManager>.Instance.mainCamera.ScreenToWorldPoint(position);
					MonoSingleton<GameCameraStackManager>.Instance.mainCamera.ScreenToWorldPoint(position2);
					tSVector2 = TrueSyncExtensions.RandomPointInsideRing(objActor.Position, desInnerRadius, desOuterRadius);
					lastTargetPos = objActor.Position;
				}
				else
				{
					TSVector2 tSVector3 = TrueSyncExtensions.RandomPointInsideRing(center, Screen.width / 2 * srcInnerRadius, Screen.width / 2 * srcOuterRadius);
					while (tSVector3.y > Screen.height || tSVector3.y < 0)
					{
						tSVector3 = TrueSyncExtensions.RandomPointInsideRing(center, Screen.width / 2 * srcInnerRadius, Screen.width / 2 * srcOuterRadius);
					}
					position = new Vector3((float)tSVector3.x, (float)tSVector3.y, MonoSingleton<GameCameraStackManager>.Instance.mainCamera.nearClipPlane + -2f);
					position = MonoSingleton<GameCameraStackManager>.Instance.mainCamera.ScreenToWorldPoint(position);
					if (lastTargetPos == TSVector2.zero)
					{
						lastTargetPos = ((target != null) ? target.tsTransform.Position : _actor.tsTransform.Position);
					}
					tSVector2 = TrueSyncExtensions.RandomPointInsideRing(lastTargetPos, desInnerRadius, desOuterRadius);
				}
				new TSVector2(position.x, position.z);
				TSVector2 position3 = tSVector2;
				ILRuntimeAPI.PlayAreaEffect(_actor, areaEffect, position3);
			}
			yield return null;
			escapeTime += _actor.LogicDeltaTime;
			curInterval += _actor.LogicDeltaTime;
		}
	}

	private void DoUpdateLogic()
	{
		TSVector2 movementInputDirection = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		if (!(movementInputDirection != TSVector2.zero) || !objActor)
		{
			return;
		}
		FP logicDeltaTime = _actor.LogicDeltaTime;
		TSVector2 tSVector = new TSVector2(movementInputDirection.x * speed * logicDeltaTime, movementInputDirection.y * speed * logicDeltaTime);
		TSVector2 point = objActor.Position + tSVector;
		if (TSVector2.Distance(_actor.tsTransform.Position, point) > 20)
		{
			return;
		}
		bool raycastHit;
		if (_actor.QueryPositionReachable(point) || _actor.QueryPositionWalkable(point))
		{
			objActor.Position += tSVector;
			objActor.PositionY = CommonHelper.GetTerrainHeight(objActor.Position, objActor.PositionY, out raycastHit);
			return;
		}
		_ = objActor.Position;
		if ((bool)SceneSingleton<DeterministicCollisionManager>.Instance.CheckPointInterior(ref point, 4096))
		{
			if (Physics.Raycast(new Vector3(point.x.AsFloat(), 100f, point.y.AsFloat()), Vector3.down, out var hitInfo, 200f, 2048, QueryTriggerInteraction.Ignore) && hitInfo.point.y - objActor.Position.y < jumpHeight)
			{
				objActor.Position += tSVector;
				objActor.PositionY = CommonHelper.GetTerrainHeight(objActor.Position, objActor.PositionY, out raycastHit);
			}
			return;
		}
		TSVector2 point2 = objActor.Position + movementInputDirection * jumpDis;
		if (_actor.QueryPositionWalkable(point2) || (bool)SceneSingleton<DeterministicCollisionManager>.Instance.CheckPointInterior(ref point2, 4096))
		{
			objActor.Position += tSVector;
			objActor.PositionY = CommonHelper.GetTerrainHeight(objActor.Position, objActor.PositionY, out raycastHit);
		}
	}

	private void OnFinishOrInterrupt()
	{
		_skill?.Clear();
	}

	private LogicEntity SeachTarget()
	{
		if (_actor.attackTarget != null)
		{
			return _actor.attackTarget;
		}
		return CommonUtils.SearchNearTargetByCircle(_actor, radius);
	}

	private void onCustomEvent(string evt)
	{
		if (evt.Equals(evt_hideIdle))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.eventHashCode = showOrHideIdleEvt;
			adventureActorCustomEvent.boolParam = false;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
		else if (evt.Equals(evt_showIdle))
		{
			AdventureActorCustomEvent adventureActorCustomEvent2 = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent2.boolParam = true;
			adventureActorCustomEvent2.eventHashCode = showOrHideIdleEvt;
			_actor.DispatchEvent(adventureActorCustomEvent2);
		}
	}
}
