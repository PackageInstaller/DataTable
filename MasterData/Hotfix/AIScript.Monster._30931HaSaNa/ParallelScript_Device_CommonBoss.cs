using System.Collections;
using System.Collections.Generic;
using AIScript.Monster.Template;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa;

public class ParallelScript_Device_CommonBoss : Parallel
{
	private readonly string eventName_TriggerOpListner_Active = "Active";

	private readonly string eventName_TriggerOpListner_DeActive = "Deactive";

	private readonly FP reduceHPInterval_Lv1 = 6;

	private readonly FP reduceHPInterval_Lv2 = 10;

	private readonly FP reduceHPInterval_SandStorm = 20;

	private readonly string bulletKey = "Bullet_30931HaSaNa_LiuShaZhu_Bullet";

	private readonly string bulletTag = "LiuShaZhuBullet";

	private readonly FP shootInterval = 0.25;

	private readonly FP shootPositionY = 1.612;

	private readonly FP recoverToughnessPercent_Lv1 = 1.0 / 800.0;

	private readonly FP recoverToughnessPercent_Lv2 = 0.0025;

	private readonly string fxKey_AreaHit = "fx_30931JiGuanZhuangZhi_base_attack";

	private readonly FP duration_AreaHit = 3.2;

	private readonly int hitDamageId_AreaHit = 30931182;

	private readonly string hittedFxKey_AreaHit = "fx_common_hit_earth_magic";

	private readonly FP hitInterval_AreaHit = 0.03;

	private readonly FP innerSideLength_AreaHit = 0;

	private readonly FP outerSideLength_AreaHit = 0.7;

	private readonly FP changeSideLength_AreaHit = 0.17;

	private readonly FP AreaPlaybackSpeed = 1.25f;

	private bool isFirstAction;

	private bool _isActive;

	private CoroutineNode _corNode_ActiveState;

	private FP _reduceHPInterval;

	private FP interval_ReduceHp;

	private List<CoroutineNode> _corNodeList_AreaHit;

	private List<PlayFX> _playFXList_AreaHit;

	private bool CanAreaAttack;

	private FP recoverToughnessPercent;

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
		_actor.StartLogicCoroutine(EffectLogic(), runImmediately: true);
		isFirstAction = false;
		CanAreaAttack = true;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_STATE_SWITCH", OnStateSwitch);
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
		else if (string.Equals(adventureActorCustomEvent.eventName, "HaSaNaRestoreDevice"))
		{
			if (IsActive)
			{
				interval_ReduceHp = _reduceHPInterval;
				_actor.logicVariable.ToggleLogicTag("ProgressRestore", value: true);
			}
		}
		else if (string.Equals(adventureActorCustomEvent.eventName, "HaSaNaTriggerSandStorm"))
		{
			_reduceHPInterval = reduceHPInterval_SandStorm;
			_actor.logicVariable.SetLogicTagValue("ProgressFXSpeed", 10 / _reduceHPInterval);
		}
		else
		{
			if (!string.Equals(adventureActorCustomEvent.eventName, "HaSaNaTriggerDevice") || !(_actor.logicVariable.GetLogicTagValue("Difficulty") > 1))
			{
				return;
			}
			List<TSVector2> tsVector2ParamList = adventureActorCustomEvent.tsVector2ParamList;
			if (tsVector2ParamList == null || tsVector2ParamList.Count <= 0)
			{
				return;
			}
			foreach (TSVector2 tsVector2Param in adventureActorCustomEvent.tsVector2ParamList)
			{
				if (CheckPointInSelfQuadrant(tsVector2Param) && IsActive && CanAreaAttack)
				{
					if (_corNodeList_AreaHit == null)
					{
						_corNodeList_AreaHit = new List<CoroutineNode>(5);
					}
					_corNodeList_AreaHit.Add(_actor.StartLogicCoroutine(AreaHitLogic(), runImmediately: true));
					break;
				}
			}
		}
	}

	private IEnumerator AreaHitLogic()
	{
		CanAreaAttack = false;
		new PlayFX().Play(_actor, null, "ZhuangZhiYuJing", 0, _actor.tsTransform.Position, default, null, 0.75f);
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(0.3));
		if (_playFXList_AreaHit == null)
		{
			_playFXList_AreaHit = new List<PlayFX>(5);
		}
		PlayFX playFX = new PlayFX();
		playFX.Play(_actor, null, fxKey_AreaHit, default, _actor.tsTransform.Position, default, null, (float)AreaPlaybackSpeed);
		_playFXList_AreaHit.Add(playFX);
		FP duration = duration_AreaHit;
		FP hitInterval = hitInterval_AreaHit;
		DeterministicShape innerShape = new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Rectangle,
			length = innerSideLength_AreaHit,
			width = innerSideLength_AreaHit,
			position = _actor.tsTransform.Position
		};
		DeterministicShape outerShape = new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Rectangle,
			length = outerSideLength_AreaHit,
			width = outerSideLength_AreaHit,
			position = _actor.tsTransform.Position
		};
		RectangleRingHit(innerShape, outerShape);
		while (duration > 0)
		{
			if (hitInterval > 0)
			{
				hitInterval -= _actor.LogicDeltaTime;
			}
			else
			{
				innerShape.length += changeSideLength_AreaHit * AreaPlaybackSpeed;
				innerShape.width += changeSideLength_AreaHit * AreaPlaybackSpeed;
				outerShape.length += changeSideLength_AreaHit * AreaPlaybackSpeed;
				outerShape.width += changeSideLength_AreaHit * AreaPlaybackSpeed;
				RectangleRingHit(innerShape, outerShape);
				hitInterval = hitInterval_AreaHit;
			}
			duration -= _actor.LogicDeltaTime;
			yield return null;
		}
		CanAreaAttack = true;
	}

	private void RectangleRingHit(DeterministicShape innerShape, DeterministicShape outerShape)
	{
		if (outerShape.shapeType != DeterministicShape.ShapeType.Rectangle || !(outerShape.length > 0) || !(outerShape.width > 0))
		{
			return;
		}
		List<LogicEntity> targetsFromShape = ILRuntimeAPI.GetTargetsFromShape(outerShape);
		ILRuntimeAPI.SearchActorConfront(_actor, targetsFromShape);
		if (targetsFromShape != null && targetsFromShape.Count > 0 && innerShape.shapeType == DeterministicShape.ShapeType.Rectangle && innerShape.length > 0 && innerShape.width > 0)
		{
			List<DeterministicCollider> list = new List<DeterministicCollider>();
			SceneSingleton<DeterministicCollisionManager>.Instance.GetTargetByShapeForPoint(list, innerShape, 256);
			if (list.Count > 0)
			{
				List<LogicEntity> list2 = new List<LogicEntity>();
				foreach (DeterministicCollider item in list)
				{
					list2.Add(item.Entity);
				}
				ILRuntimeAPI.SearchActorConfront(_actor, list2);
				if (list2 != null && list2.Count > 0)
				{
					foreach (LogicEntity item2 in list2)
					{
						targetsFromShape.Remove(item2);
					}
				}
			}
		}
		if (targetsFromShape == null || targetsFromShape.Count <= 0)
		{
			return;
		}
		foreach (LogicEntity item3 in targetsFromShape)
		{
			if (item3 is AdventureActor target)
			{
				ILRuntimeAPI.HitActor(_actor, target, hitDamageId_AreaHit, hittedFxKey_AreaHit);
			}
		}
	}

	private void ClearAreaHitLogic()
	{
		List<CoroutineNode> corNodeList_AreaHit = _corNodeList_AreaHit;
		if (corNodeList_AreaHit != null && corNodeList_AreaHit.Count > 0)
		{
			foreach (CoroutineNode item in _corNodeList_AreaHit)
			{
				_actor.StopLogicCoroutine(item);
			}
			_corNodeList_AreaHit.Clear();
		}
		List<PlayFX> playFXList_AreaHit = _playFXList_AreaHit;
		if (playFXList_AreaHit == null || playFXList_AreaHit.Count <= 0)
		{
			return;
		}
		foreach (PlayFX item2 in _playFXList_AreaHit)
		{
			item2.Stop();
		}
		_playFXList_AreaHit.Clear();
	}

	private IEnumerator ActiveLogic()
	{
		MonsterAdventureActor monsterAdventureActor = _actor as MonsterAdventureActor;
		monsterAdventureActor.actorHealthInfo.hp = monsterAdventureActor.actorHealthInfo.hpMax;
		IsActive = true;
		FP interval_Shoot = shootInterval;
		interval_ReduceHp = _reduceHPInterval;
		_ = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
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
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = this;
		adventureActorCustomEvent.actor = _actor;
		adventureActorCustomEvent.eventHashCode = 3093101;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
	}

	private bool CheckPlayInSelfQuadrant()
	{
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		if (activedPlayerActor != null && TSMath.Abs(TSVector2.SignedAngle(TSVector2.zero - _actor.tsTransform.Position, TSVector2.zero - activedPlayerActor.tsTransform.Position)) <= 45)
		{
			return true;
		}
		return false;
	}

	private bool CheckPointInSelfQuadrant(TSVector2 CheckPosition)
	{
		if (TSMath.Abs(TSVector2.SignedAngle(TSVector2.zero - _actor.tsTransform.Position, TSVector2.zero - CheckPosition)) <= 45)
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
		int teammateIdByIndex = CommonUtils_MonsterAPI.GetTeammateIdByIndex(_actor as MonsterAdventureActor, (int)(long)_actor.logicVariable.GetLogicTagValue("BossTeammateID"));
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
		ClearAreaHitLogic();
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

	private void OnStateSwitch(IEvent evt)
	{
		if (evt is AdventureActorStateSwitchEvent adventureActorStateSwitchEvent && adventureActorStateSwitchEvent.Id == _actor.Id && adventureActorStateSwitchEvent._acState == ActorState.Action && !isFirstAction)
		{
			isFirstAction = true;
			if (_actor.logicVariable.GetLogicTagValue("Difficulty") == 1)
			{
				_reduceHPInterval = reduceHPInterval_Lv1;
				recoverToughnessPercent = recoverToughnessPercent_Lv1;
				_actor.logicVariable.SetLogicTagValue("ProgressFXSpeed", 10 / _reduceHPInterval);
			}
			else
			{
				_reduceHPInterval = reduceHPInterval_Lv2;
				recoverToughnessPercent = recoverToughnessPercent_Lv2;
				_actor.logicVariable.SetLogicTagValue("ProgressFXSpeed", 10 / _reduceHPInterval);
			}
		}
	}
}
