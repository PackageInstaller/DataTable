using System.Collections;
using System.Collections.Generic;
using AIScript.Monster.Template;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa;

public class ParallelScript_Device_MiniBoss : Parallel
{
	private readonly int teammateIndex_Boss;

	private readonly string eventName_TriggerOpListner_Active = "Active";

	private readonly string eventName_TriggerOpListner_DeActive = "Deactive";

	private readonly FP reduceHPInterval = 15;

	private readonly string bulletKey = "Bullet_30931HaSaNa_LiuShaZhu_Bullet";

	private readonly string bulletTag = "LiuShaZhuBullet";

	private readonly FP shootInterval = 0.25;

	private readonly FP shootPositionY = 1.612;

	private readonly FP recoverToughnessPercent = 0.03;

	private readonly FP AreaLength = 15;

	private readonly FP AreaWidth = 6;

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
				FP logicTagValue = _actor.logicVariable.GetLogicTagValue("TeammateID");
				if (_isActive)
				{
					string text = eventName_TriggerOpListner_Active;
					FP fP = logicTagValue;
					CommonUtils_MonsterAPI.TriggerOpLisener(text + fP.ToString());
				}
				else
				{
					string text2 = eventName_TriggerOpListner_DeActive;
					FP fP = logicTagValue;
					CommonUtils_MonsterAPI.TriggerOpLisener(text2 + fP.ToString());
				}
			}
		}
	}

	public override void OnStart()
	{
		base.OnStart();
		_reduceHPInterval = reduceHPInterval;
		_actor.StartLogicCoroutine(EffectLogic(), runImmediately: true);
		_actor.logicVariable.SetLogicTagValue("ProgressFXSpeed", 10 / _reduceHPInterval);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		if (!(evt is AdventureActorCustomEvent adventureActorCustomEvent))
		{
			return;
		}
		if (string.Equals(adventureActorCustomEvent.eventName, "HaSaNaActiveDevice"))
		{
			if (!IsActive)
			{
				if (_corNode_ActiveState != null)
				{
					_actor.StopLogicCoroutine(_corNode_ActiveState);
				}
				_corNode_ActiveState = _actor.StartLogicCoroutine(ActiveLogic(), runImmediately: true);
			}
		}
		else if (string.Equals(adventureActorCustomEvent.eventName, "HaSaNaRestoreDevice") && IsActive)
		{
			interval_ReduceHp = _reduceHPInterval;
			_actor.logicVariable.ToggleLogicTag("ProgressRestore", value: true);
		}
	}

	private IEnumerator ActiveLogic()
	{
		MonsterAdventureActor monsterAdventureActor = _actor as MonsterAdventureActor;
		monsterAdventureActor.actorHealthInfo.hp = monsterAdventureActor.actorHealthInfo.hpMax;
		IsActive = true;
		FP interval_Shoot = shootInterval;
		interval_ReduceHp = _reduceHPInterval;
		while (true)
		{
			if (interval_Shoot > 0)
			{
				interval_Shoot -= _actor.LogicDeltaTime;
			}
			else
			{
				MonsterAdventureActor boss = GetBoss();
				if (boss != null && !boss.monsterToughnessInfo.isToughnessBroken && _actor.logicVariable.GetLogicTagToggle("Locked"))
				{
					ILRuntimeAPI.Shoot(bulletKey, _actor, default, _actor.tsTransform.Position, shootPositionY, boss.tsTransform.Position, boss, AimType.Target, BulletDirectionType.BulletToTarget);
				}
				interval_Shoot = shootInterval;
			}
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

	private void OnBulletFinish(IEvent evt)
	{
		if (!(evt is AdventureBulletFinishEvent adventureBulletFinishEvent))
		{
			return;
		}
		AdventureBulletBase adventureBulletBase = adventureBulletFinishEvent.sender as AdventureBulletBase;
		if (adventureBulletBase.owner == _actor && adventureBulletBase.CheckBulletTag(bulletTag))
		{
			MonsterAdventureActor boss = GetBoss();
			if (boss != null && !boss.monsterToughnessInfo.isToughnessBroken)
			{
				boss.monsterToughnessInfo.toughness += (boss.monsterToughnessInfo.toughnessMax * recoverToughnessPercent).AsInt();
			}
		}
	}

	private MonsterAdventureActor GetBoss()
	{
		int teammateIdByIndex = CommonUtils_MonsterAPI.GetTeammateIdByIndex(_actor as MonsterAdventureActor, teammateIndex_Boss);
		List<LogicEntity> list = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntitiesByDataID(teammateIdByIndex);
		if (list != null && list.Count > 0)
		{
			return list.get_Item(0) as MonsterAdventureActor;
		}
		return null;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
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
				AreaFX.Play(_actor, null, "fx_m30931_loop_area_15x6", 0, _actor.tsTransform.Position, default);
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
