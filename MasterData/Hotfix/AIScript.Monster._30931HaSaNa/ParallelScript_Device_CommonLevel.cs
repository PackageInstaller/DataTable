using System.Collections;
using AIScript.Monster.Template;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa;

public class ParallelScript_Device_CommonLevel : Parallel
{
	private readonly string eventName_TriggerOpListner_Active = "Active";

	private readonly string eventName_TriggerOpListner_DeActive = "Deactive";

	private readonly FP reduceHPInterval = 15;

	private readonly FP AreaLength = 12.5;

	private readonly FP AreaWidth = 12.5;

	private bool _isActive;

	private CoroutineNode _corNode_ActiveState;

	private FP _reduceHPInterval;

	private FP interval_ReduceHp;

	private bool IsActive
	{
		get
		{
			return _isActive;
		}
		set
		{
			if (_isActive != value)
			{
				_isActive = value;
				_actor.logicVariable.ToggleLogicTag("IsActive", _isActive);
				if (_isActive)
				{
					CommonUtils_MonsterAPI.TriggerOpLisener(eventName_TriggerOpListner_Active);
				}
				else
				{
					CommonUtils_MonsterAPI.TriggerOpLisener(eventName_TriggerOpListner_DeActive);
				}
			}
		}
	}

	public override void OnStart()
	{
		base.OnStart();
		_actor.StartLogicCoroutine(EffectLogic(), runImmediately: true);
		_reduceHPInterval = reduceHPInterval;
		_actor.logicVariable.SetLogicTagValue("ProgressFXSpeed", 10 / _reduceHPInterval);
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent && string.Equals(adventureActorCustomEvent.eventName, "ActiveCommon") && !IsActive)
		{
			if (_corNode_ActiveState != null)
			{
				_actor.StopLogicCoroutine(_corNode_ActiveState);
			}
			_corNode_ActiveState = _actor.StartLogicCoroutine(ActiveLogic(), runImmediately: true);
		}
	}

	private IEnumerator ActiveLogic()
	{
		MonsterAdventureActor monsterAdventureActor = _actor as MonsterAdventureActor;
		monsterAdventureActor.actorHealthInfo.hp = monsterAdventureActor.actorHealthInfo.hpMax;
		IsActive = true;
		interval_ReduceHp = _reduceHPInterval;
		_ = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		while (true)
		{
			if (CheckPlayInSelfQuadrant())
			{
				if (interval_ReduceHp > 0 && !_actor.logicVariable.GetLogicTagToggle("Locked"))
				{
					interval_ReduceHp -= _actor.LogicDeltaTime;
					_actor.logicVariable.ToggleLogicTag("LinkPlayer", value: true);
				}
				else if (interval_ReduceHp <= 0)
				{
					break;
				}
			}
			else
			{
				_actor.logicVariable.ToggleLogicTag("LinkPlayer", value: false);
			}
			yield return null;
		}
		_actor.logicVariable.ToggleLogicTag("LinkPlayer", value: false);
		IsActive = false;
		_corNode_ActiveState = null;
	}

	private bool CheckPlayInSelfQuadrant()
	{
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		DeterministicShape shape = new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Rectangle,
			length = AreaLength,
			width = AreaWidth,
			position = _actor.tsTransform.Position
		};
		if (CommonUtils_MonsterAPI.GetTargetsFromShape(_actor, shape, null, includeSelf: false, activedPlayerActor).Count > 0)
		{
			return true;
		}
		return false;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		_actor.StopLogicCoroutine(_corNode_ActiveState);
		_corNode_ActiveState = null;
		IsActive = false;
	}

	private IEnumerator EffectLogic()
	{
		_ = _actor;
		PlayFX ProgressBarFX = new PlayFX();
		PlayFX LinkPlayerFX = new PlayFX();
		PlayFX AreaFX = new PlayFX();
		bool LinkPlayerFXPlaying = false;
		bool AreaFXPlaying = false;
		LogicEntity player = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		while (true)
		{
			if (!LinkPlayerFXPlaying && _actor.logicVariable.GetLogicTagToggle("LinkPlayer") && !_actor.logicVariable.GetLogicTagToggle("Locked"))
			{
				LinkPlayerFXPlaying = true;
				LinkPlayerFX.PlayLinFx(_actor, "fx_30931JiGuanZhuangZhi_loop_charge_link_player", 1f, useCustSource: false, _actor.gameObject, default, 0, player.gameObject, default, 0);
				ProgressBarFX.Resume();
			}
			else if (!_actor.logicVariable.GetLogicTagToggle("LinkPlayer") || _actor.logicVariable.GetLogicTagToggle("Locked"))
			{
				LinkPlayerFXPlaying = false;
				LinkPlayerFX.Stop();
				ProgressBarFX.Pause();
			}
			if (!AreaFXPlaying && _actor.logicVariable.GetLogicTagToggle("IsActive"))
			{
				AreaFXPlaying = true;
				AreaFX.Play(_actor, null, "fx_m30931_loop_area_15x15", 0, _actor.tsTransform.Position, default);
				ProgressBarFX.Play(_actor, null, "fx_m30931_base_jiguan_pro", 0, _actor.tsTransform.Position, default, null, (float)(_actor.logicVariable.GetLogicTagValue("ProgressFXSpeed") - 0.01));
				yield return null;
			}
			else if (AreaFXPlaying && !_actor.logicVariable.GetLogicTagToggle("IsActive"))
			{
				AreaFXPlaying = false;
				AreaFX.Stop();
				ProgressBarFX.Stop();
			}
			if (_actor.logicVariable.GetLogicTagToggle("ProgressRestore"))
			{
				ProgressBarFX.Stop();
				ProgressBarFX.Play(_actor, null, "fx_m30931_base_jiguan_pro", 0, _actor.tsTransform.Position, default, null, (float)(_actor.logicVariable.GetLogicTagValue("ProgressFXSpeed") - 0.01));
				_actor.logicVariable.ToggleLogicTag("ProgressRestore", value: false);
				yield return null;
			}
			yield return null;
		}
	}
}
