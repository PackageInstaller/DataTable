using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11501;

public class ActionScript_MainControl : ActionScript
{
	private AimTarget _aimTarget;

	private LogicEntity _lockAttackTarget;

	private long _lockAttackTargetId;

	private bool _canUpdateTarget;

	private FP _normalAttackCD;

	private CoroutineNode _perkLogicCor_P6;

	private CoroutineNode _perkLogicCor_P9;

	private PlayFX _playFX_P9_1;

	private bool _funnelStrengthen_P9_1;

	private PlayFX _playFX_P9_2;

	private bool _funnelStrengthen_P9_2;

	private PlayFX _playFX_P9_3;

	private bool _funnelStrengthen_P9_3;

	private PlayFX _playFX_P9_4;

	private bool _funnelStrengthen_P9_4;

	private LogicEntity LockAttackTarget
	{
		get
		{
			return _lockAttackTarget;
		}
		set
		{
			_lockAttackTarget = value;
			_lockAttackTargetId = ((_lockAttackTarget != null) ? _lockAttackTarget.Id : 0);
		}
	}

	private long LockAttackTargetId => _lockAttackTargetId;

	private bool FunnelStrengthen_P9_1
	{
		set
		{
			if (value != _funnelStrengthen_P9_1)
			{
				_funnelStrengthen_P9_1 = value;
				UpdateFunnelStrengthenState_P9(AnimationSlotConfigComponent.SlotType.Extra_1, ref _playFX_P9_1, _funnelStrengthen_P9_1);
			}
		}
	}

	private bool FunnelStrengthen_P9_2
	{
		set
		{
			if (value != _funnelStrengthen_P9_2)
			{
				_funnelStrengthen_P9_2 = value;
				UpdateFunnelStrengthenState_P9(AnimationSlotConfigComponent.SlotType.Extra_2, ref _playFX_P9_2, _funnelStrengthen_P9_2);
			}
		}
	}

	private bool FunnelStrengthen_P9_3
	{
		set
		{
			if (value != _funnelStrengthen_P9_3)
			{
				_funnelStrengthen_P9_3 = value;
				UpdateFunnelStrengthenState_P9(AnimationSlotConfigComponent.SlotType.Extra_3, ref _playFX_P9_3, _funnelStrengthen_P9_3);
			}
		}
	}

	private bool FunnelStrengthen_P9_4
	{
		set
		{
			if (value != _funnelStrengthen_P9_4)
			{
				_funnelStrengthen_P9_4 = value;
				UpdateFunnelStrengthenState_P9(AnimationSlotConfigComponent.SlotType.Extra_4, ref _playFX_P9_4, _funnelStrengthen_P9_4);
			}
		}
	}

	private void UpdateFunnelStrengthenState_P9(AnimationSlotConfigComponent.SlotType slot, ref PlayFX playFX, bool isStrength)
	{
		string tag = $"{slot}_{511509}";
		_actor.logicVariable.ToggleLogicTag(tag, isStrength);
		if (playFX == null)
		{
			playFX = new PlayFX();
		}
		if (isStrength)
		{
			playFX.Play(_actor, null, Config_MainControl.fxKeyDic_P9.get_Item(slot), default, _actor.tsTransform.Position, default);
			return;
		}
		playFX.Stop();
		playFX.Clear();
	}

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		InitState();
		if (_aimTarget == null)
		{
			_aimTarget = new AimTarget();
		}
		else
		{
			_aimTarget.Clear();
		}
		if (InTransformState)
		{
			_actor.ReplaceAnimationGroup(1);
			EnterTransformState(((PlayerAdventureActor)_actor).specialStatusTime);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511509, out var perkLevel))
		{
			if (_perkLogicCor_P9 != null)
			{
				_actor.StopLogicCoroutine(_perkLogicCor_P9);
			}
			_perkLogicCor_P9 = _actor.StartLogicCoroutine(PerkLogic_P9());
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511513, out perkLevel))
		{
			_playerSkillCd.SetSkillTotalSection(ActionKey.A, _playerSkillCd.GetSkillCD(ActionKey.A).originalTotalSectionAmount + 1, forceMaxSection: true);
		}
		else
		{
			_playerSkillCd.ResetSkillTotalSection(ActionKey.A);
		}
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
	}

	private void InitState()
	{
		((PlayerAdventureActor)_actor).searchType = PlayerActorSearchType.Range;
		((PlayerAdventureActor)_actor).moveControlType = PlayerActorMoveType.Range;
	}

	protected override void OnButtonAPress()
	{
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.A), _actor, SkillPhaseFeatureFlag.Dodge, SkillLauncherType.Character, !InTransformState, isBreakable: false);
	}

	protected override void OnButtonBPress()
	{
		if (ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false))
		{
			EnterTransformState(Config_MainControl.durationTime_TransformState);
		}
	}

	protected override void OnButtonDPress()
	{
		if (ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.D), _actor, SkillPhaseFeatureFlag.Ultimate, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false))
		{
			ExitTransformState();
		}
	}

	protected override bool CastIndependentRushSkill()
	{
		return ILRuntimeAPI.CreateSkill(InTransformState ? 11571000 : _playerSkillCd.GetCurrentBindSkillId(ActionKey.C), _actor, SkillPhaseFeatureFlag.Skill2, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: true, SkillCountdownTiming.Start, null, null, ingoreCDAndEnergy: false, isRushJoinDodge: false);
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		if (InTransformState || _actor.actorSkillManage.HaveSkill(SkillPhaseFeatureFlag.Ultimate))
		{
			return;
		}
		_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: true);
		if (_actor.attackTarget == null || _actor.actorSkillManage.HaveSkill(SkillPhaseFeatureFlag.Skill2 | SkillPhaseFeatureFlag.Dodge) || IsObstacleBetweenActorAndTargetAndPreventNormalAttack)
		{
			if (_actor.aimMode != AdventureActor.AimMode.Forward)
			{
				_aimTarget.Cancel();
			}
			return;
		}
		FP fP = _actor.DistanceWithRadius(_actor.attackTarget);
		if (fP < CommonUtils.GetAimRange(_actor))
		{
			if (_actor.aimMode != AdventureActor.AimMode.AimAtAttackTarget)
			{
				_aimTarget.Aim(_actor, (AdventureActor)_actor.attackTarget, default, playStartAnim: true);
			}
			if (fP <= CommonUtils.GetAttackRange(_actor) && _actor.aimMode == AdventureActor.AimMode.AimAtAttackTarget)
			{
				int currentBindSkillId = _playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal);
				if (currentBindSkillId == 11510000)
				{
					ILRuntimeAPI.CreateSkill(currentBindSkillId, _actor, SkillPhaseFeatureFlag.Normal, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
				}
			}
		}
		else if (_actor.aimMode != AdventureActor.AimMode.Forward)
		{
			_aimTarget.Cancel();
		}
	}

	protected override void OnEnterTransformState()
	{
		base.OnEnterTransformState();
		_canUpdateTarget = true;
		_normalAttackCD = 0;
		int skillId = 11511000;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511501, out var perkLevel))
		{
			skillId = 11511010;
		}
		_playerSkillCd.BindSkillIdToButton(ActionKey.Normal, skillId);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511506, out perkLevel))
		{
			if (_perkLogicCor_P6 != null)
			{
				_actor.StopLogicCoroutine(_perkLogicCor_P6);
			}
			_perkLogicCor_P6 = _actor.StartLogicCoroutine(PerkLogic_P6(), runImmediately: true);
		}
		MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintEnd", _playerSkillCd.GetCurrentBindSkillId(ActionKey.B));
		MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintStart", _playerSkillCd.GetCurrentBindSkillId(ActionKey.B), Config_MainControl.durationTime_TransformState.AsFloat(), a3: true, ((PlayerAdventureActor)_actor).specialStatusTime.AsFloat());
	}

	protected override void OnTransformLogicUpdate()
	{
		base.OnTransformLogicUpdate();
		int perkLevel;
		if (_canUpdateTarget)
		{
			if (_actor.attackTarget != null && CommonUtils.HavePersonalPerk(_actor.dataID, 511501, out perkLevel) && _actor.actorSkillManage.HaveSkill(SkillPhaseFeatureFlag.Normal))
			{
				UpdateAttackTarget(forceUpdate: true);
				_canUpdateTarget = false;
			}
			else
			{
				UpdateAttackTarget();
			}
		}
		if (AimTarget() && _actor.DistanceWithRadius(_actor.attackTarget) <= CommonUtils.GetAttackRange(_actor))
		{
			if (!CommonUtils.HavePersonalPerk(_actor.dataID, 511501, out perkLevel) && CommonUtils.HavePersonalPerk(_actor.dataID, 511506, out perkLevel) && _actor.logicVariable.GetLogicTagToggle("TriggerPerk_P6"))
			{
				if (ILRuntimeAPI.CreateSkill(11511030, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false))
				{
					_actor.logicVariable.ToggleLogicTag("TriggerPerk_P6", value: false);
				}
			}
			else if (_normalAttackCD <= 0)
			{
				UpdateNormalAttackCD();
				ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal), _actor, SkillPhaseFeatureFlag.Normal, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool success) =>
				{
					if (success && InTransformState)
					{
						_canUpdateTarget = true;
					}
				});
			}
		}
		if (_normalAttackCD > 0)
		{
			_normalAttackCD -= _actor.LogicDeltaTime;
		}
	}

	protected override void OnExitTransformState(bool force = false)
	{
		base.OnExitTransformState(force);
		MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintEnd", _playerSkillCd.GetCurrentBindSkillId(ActionKey.B));
		_playerSkillCd.BindSkillIdToButton(ActionKey.Normal, 11510000);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511502, out var _))
		{
			_actor.buffComponent.RemoveBuffByBuffId(11502011);
			_actor.buffComponent.RemoveBuffByBuffId(11502012);
			_actor.logicVariable.ToggleLogicTag("TriggerPerk_P2", value: false);
		}
		if (_perkLogicCor_P6 != null)
		{
			_actor.StopLogicCoroutine(_perkLogicCor_P6);
		}
		_perkLogicCor_P6 = null;
		LockAttackTarget = null;
	}

	protected override bool CastExitTransformStateSkill()
	{
		return ILRuntimeAPI.CreateSkill(11531002, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		if (!(evt is AdventureActorCustomEvent adventureActorCustomEvent))
		{
			return;
		}
		if (adventureActorCustomEvent.eventHashCode == Config_MainControl.eventHashCode_Irradiation_UpdateTarget)
		{
			_canUpdateTarget = true;
		}
		else if (adventureActorCustomEvent.eventHashCode == Config_MainControl.eventHashCode_AfterFunnelFireHit && adventureActorCustomEvent.intParamList != null && adventureActorCustomEvent.intParamList.Count > 0)
		{
			switch ((AnimationSlotConfigComponent.SlotType)adventureActorCustomEvent.intParamList.get_Item(0))
			{
			case AnimationSlotConfigComponent.SlotType.Extra_1:
				FunnelStrengthen_P9_1 = false;
				break;
			case AnimationSlotConfigComponent.SlotType.Extra_2:
				FunnelStrengthen_P9_2 = false;
				break;
			case AnimationSlotConfigComponent.SlotType.Extra_3:
				FunnelStrengthen_P9_3 = false;
				break;
			case AnimationSlotConfigComponent.SlotType.Extra_4:
				FunnelStrengthen_P9_4 = false;
				break;
			}
		}
	}

	private IEnumerator PerkLogic_P6()
	{
		_actor.logicVariable.ToggleLogicTag("TriggerPerk_P6", value: true);
		FP interval = Config_MainControl.triggerInterval_P6;
		while (true)
		{
			if (interval > 0)
			{
				if (!_actor.logicVariable.GetLogicTagToggle("TriggerPerk_P6"))
				{
					interval -= _actor.LogicDeltaTime;
				}
			}
			else
			{
				_actor.logicVariable.ToggleLogicTag("TriggerPerk_P6", value: true);
				interval += Config_MainControl.triggerInterval_P6;
			}
			yield return null;
		}
	}

	private IEnumerator PerkLogic_P9()
	{
		FP interval = Config_MainControl.triggerInterval_P9;
		while (true)
		{
			if (interval > 0)
			{
				interval -= _actor.LogicDeltaTime;
			}
			else
			{
				FunnelStrengthen_P9_1 = true;
				FunnelStrengthen_P9_2 = true;
				FunnelStrengthen_P9_3 = true;
				FunnelStrengthen_P9_4 = true;
				interval += Config_MainControl.triggerInterval_P9;
			}
			yield return null;
		}
	}

	private void UpdateAttackTarget(bool forceUpdate = false)
	{
		if (forceUpdate)
		{
			_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: true);
		}
		else if (LockAttackTarget != null)
		{
			if (CommonUtils.CheckTargetIsValid(LockAttackTarget, LockAttackTargetId))
			{
				_actor.attackTarget = LockAttackTarget;
			}
			else
			{
				_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: true);
				LockAttackTarget = null;
			}
		}
		else
		{
			_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: true);
		}
		bool num = InTransformState && _actor.actorSkillManage.HaveSkill(SkillPhaseFeatureFlag.Normal);
		bool flag = CommonUtils.HavePersonalPerk(_actor.dataID, 511508, out var _) && _actor.actorSkillManage.HaveSkill(SkillPhaseFeatureFlag.Skill1);
		if (num | flag)
		{
			LockAttackTarget = _actor.attackTarget;
		}
		else
		{
			LockAttackTarget = null;
		}
	}

	private bool AimTarget()
	{
		bool flag = CommonUtils.HavePersonalPerk(_actor.dataID, 511508, out var _) && _actor.actorSkillManage.HaveSkill(SkillPhaseFeatureFlag.Skill1);
		if (_actor.attackTarget == null || _actor.actorSkillManage.HaveSkill(SkillPhaseFeatureFlag.Skill2))
		{
			if (flag)
			{
				_aimTarget.Aim(_actor, null, _actor.tsTransform.Forward);
			}
			else if (_actor.aimMode != AdventureActor.AimMode.Forward)
			{
				_aimTarget.Cancel();
			}
			return false;
		}
		if (_actor.actorSkillManage.HaveSkill(SkillPhaseFeatureFlag.Dodge))
		{
			TSVector2 forward = _actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position;
			if (_actor.specialDodgeMode)
			{
				_aimTarget.Aim(_actor, null, forward.normalized, playStartAnim: true, null, null, 1);
				_actor.tsTransform.Forward = forward;
				return true;
			}
			if (flag)
			{
				_aimTarget.Aim(_actor, null, _actor.tsTransform.Forward);
				_actor.tsTransform.Forward = forward;
			}
			else if (_actor.aimMode != AdventureActor.AimMode.Forward)
			{
				_aimTarget.Cancel();
			}
			return false;
		}
		TSVector2 forward2 = _actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position;
		_aimTarget.Aim(_actor, null, forward2.normalized, playStartAnim: true, null, null, 1);
		_actor.tsTransform.Forward = forward2;
		return true;
	}

	private void UpdateNormalAttackCD()
	{
		_normalAttackCD = 0;
		int key = _actor.logicVariable.GetLogicTagValue("NormalAttackStage").AsInt();
		if (Config_MainControl.normalAttackCDDic_TransformState.TryGetValue(key, out var value))
		{
			_normalAttackCD = value;
		}
	}

	private void Clear()
	{
		_aimTarget?.Cancel();
		_aimTarget?.Clear();
		if (_perkLogicCor_P6 != null)
		{
			_actor.StopLogicCoroutine(_perkLogicCor_P6);
		}
		_perkLogicCor_P6 = null;
		if (_perkLogicCor_P9 != null)
		{
			_actor.StopLogicCoroutine(_perkLogicCor_P9);
		}
		_perkLogicCor_P9 = null;
		FunnelStrengthen_P9_1 = false;
		FunnelStrengthen_P9_2 = false;
		FunnelStrengthen_P9_3 = false;
		FunnelStrengthen_P9_4 = false;
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintEnd", _playerSkillCd.GetCurrentBindSkillId(ActionKey.B));
		Clear();
	}
}
