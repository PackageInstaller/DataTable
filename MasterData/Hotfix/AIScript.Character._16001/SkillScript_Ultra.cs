using System;
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._16001;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private PlayTimeline _playTimeline;

	private AdventureCustomCameraControlHandler _adventureCustomCameraControlHandler;

	private TrueSyncTransform _cameraTsTrans;

	private CoroutineNode _cameraMoveCor;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
		_actor.EnableSuperArmor();
		_actor.EnableImmuneControl();
		_actor.EnableCloseBlock();
		DefaultLookAt();
	}

	public void OnStart()
	{
		if (_playTimeline == null)
		{
			_playTimeline = new PlayTimeline();
		}
		_playTimeline.Play(_actor, OnPlayTimeLineFinish, OnNotPlayTimeLine);
	}

	private void OnPlayTimeLineFinish()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("160_Ultra_TL", flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		OnComboBegin();
	}

	private void OnNotPlayTimeLine()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("160_Ultra_NoTL", flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		OnComboBegin();
	}

	private void OnComboBegin()
	{
		_actor.ResumeAnimationGroup();
		if (((PlayerAdventureActor)_actor).isAssist)
		{
			return;
		}
		ModuleController<AdventureModuleController>.Instance.ActivePlayerCameraTrigger("UltraVmTiriggger_Gizmo");
		_adventureCustomCameraControlHandler = ModuleController<AdventureModuleController>.Instance.CurCameraTriggerGizmo.CustomCameraControlHandlers[0];
		Transform vmPlayer = _adventureCustomCameraControlHandler.vmPlayer;
		if (vmPlayer != null && vmPlayer.TryGetComponent<TrueSyncTransform>(out _cameraTsTrans))
		{
			_cameraTsTrans.Init();
			_cameraTsTrans.transformSyncEnabled = true;
			Vector3 mainCameraFollowPosition = SceneSingleton<AdventurePlayerController>.Instance.GetMainCameraFollowPosition();
			_cameraTsTrans.Position = new TSVector2(mainCameraFollowPosition.x, mainCameraFollowPosition.z);
			_cameraTsTrans.PositionY = mainCameraFollowPosition.y;
			if (_cameraMoveCor != null)
			{
				_actor.StopLogicCoroutine(_cameraMoveCor);
			}
			_cameraMoveCor = _actor.StartLogicCoroutine(CameraMoveLogic(), runImmediately: true);
		}
	}

	private IEnumerator CameraMoveLogic()
	{
		TSVector2 linecastHitPoint = _actor.tsTransform.Position + _actor.tsTransform.Forward * Config.offset_CameraPosition_UltraSkill;
		if (!_actor.QueryPositionWalkable(linecastHitPoint))
		{
			_actor.LinecastNavmeshGraph(_actor.tsTransform.Position, linecastHitPoint, out linecastHitPoint, offset: false, _actor.tsTransform.PositionY, _actor.tsTransform.PositionY);
		}
		TSVector2 moveDirection = (linecastHitPoint - _cameraTsTrans.Position).normalized;
		FP moveTime = Config.duration_CameraMove_UltraSkill;
		FP moveSpeed = TSVector2.Distance(linecastHitPoint, _cameraTsTrans.Position) / moveTime;
		while (moveTime > 0)
		{
			_cameraTsTrans.Position += moveDirection * moveSpeed * _actor.LogicDeltaTime;
			moveTime -= _actor.LogicDeltaTime;
			yield return null;
		}
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "160_Ultra_HideModel"))
		{
			_actor.Hide(performanceMode: true);
			SceneSingleton<AdventureIndicatorController>.Instance.ShowHighlightBlob(show: false);
		}
		else if (string.Equals(eventName, "160_Ultra_ShowModel"))
		{
			_actor.Visible();
			SceneSingleton<AdventureIndicatorController>.Instance.ShowHighlightBlob(show: true);
		}
		else
		{
			if (!string.Equals(eventName, "160_Ultra_Buff") || !CommonUtils.HavePersonalPerk(_actor.dataID, 516042, out var _))
			{
				return;
			}
			foreach (AdventureActor allPlayerActor in ILRuntimeAPI.GetAllPlayerActors(_actor))
			{
				allPlayerActor.buffComponent.AddBuff(16042011, _actor);
			}
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (_cameraMoveCor != null)
		{
			_actor.StopLogicCoroutine(_cameraMoveCor);
		}
		_cameraMoveCor = null;
		ModuleController<AdventureModuleController>.Instance.DeactivePlayerCameraTrigger("UltraVmTiriggger_Gizmo");
		_cameraTsTrans = null;
		_actor.DisableInvincible();
		_actor.DisableSuperArmor();
		_actor.DisableImmuneControl();
		_actor.DisableCloseBlock();
		if (_actor.isHide)
		{
			_actor.Visible();
			SceneSingleton<AdventureIndicatorController>.Instance.ShowHighlightBlob(show: true);
		}
	}
}
