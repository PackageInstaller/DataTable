using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14001;

public class ActionScript_MainControl : ActionScript
{
	private AimTarget _aimTarget;

	private PlayFX _playFX_Perform;

	private bool _playPerformFx;

	private Config_MainControl.TransformMode _transformMode;

	private FP _transfromDuration;

	private bool _buttonAPress;

	private bool _buttonCPress;

	private bool _disableCastSkill;

	private bool _forbiddenRush;

	private bool _holdButtonAorButtonC;

	private CoroutineNode _perkLogic_P4;

	private List<PlayFX> _playFXList_P6;

	private CoroutineNode _perkLogic_P10;

	private FP _lastTriggerTime_P12;

	private bool PlayPerformFx
	{
		get
		{
			return _playPerformFx;
		}
		set
		{
			if (value != _playPerformFx)
			{
				_playPerformFx = value;
				if (_playFX_Perform == null)
				{
					_playFX_Perform = new PlayFX();
				}
				if (_playPerformFx)
				{
					_playFX_Perform.Play(_actor, null, "fx_14001_loop_Run", default, _actor.tsTransform.Position, default);
					return;
				}
				_playFX_Perform.Stop();
				_playFX_Perform.Clear();
			}
		}
	}

	private Config_MainControl.TransformMode TransformMode
	{
		get
		{
			return _transformMode;
		}
		set
		{
			if (_transformMode != value)
			{
				_transformMode = value;
				_actor.logicVariable.SetLogicTagStringValue("TransformMode", _transformMode.ToString());
			}
		}
	}

	private bool HoldButtonAorButtonC
	{
		get
		{
			return _holdButtonAorButtonC;
		}
		set
		{
			if (_holdButtonAorButtonC == value)
			{
				return;
			}
			_holdButtonAorButtonC = value;
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 514006, out var _) && TransformMode == Config_MainControl.TransformMode.MiniGun)
			{
				if (_holdButtonAorButtonC)
				{
					_actor.buffComponent.AddBuff(14006012, _actor);
				}
				else
				{
					_actor.buffComponent.RemoveBuffByBuffId(14006012);
				}
			}
		}
	}

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		if (_aimTarget == null)
		{
			_aimTarget = new AimTarget();
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514012, out var perkLevel))
		{
			_playerSkillCd.SetSkillTotalSection(ActionKey.A, _playerSkillCd.GetSkillCD(ActionKey.A).originalTotalSectionAmount + 1, forceMaxSection: true);
		}
		else
		{
			_playerSkillCd.ResetSkillTotalSection(ActionKey.A);
		}
		TransformMode = Config_MainControl.TransformMode.None;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514001, out perkLevel) || CommonUtils.HavePersonalPerk(_actor.dataID, 514002, out perkLevel))
		{
			((PlayerAdventureActor)_actor).SetActionCondition(ActionKey.B, Config_MainControl.holdSkillKeyTime_P1_P2);
		}
		else
		{
			((PlayerAdventureActor)_actor).SetActionCondition(ActionKey.B, 0);
		}
	}

	protected override void OnButtonAPress()
	{
		if (ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.A), _actor, SkillPhaseFeatureFlag.Dodge, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false) && CommonUtils.HavePersonalPerk(_actor.dataID, 514012, out var _) && (_lastTriggerTime_P12 <= 0 || _actor.LogicTime - _lastTriggerTime_P12 > CommonUtils.GetScriptValue(_actor, 14012011)))
		{
			_actor.buffComponent.AddBuff(14012011, _actor);
			_lastTriggerTime_P12 = _actor.LogicTime;
		}
		_buttonAPress = true;
	}

	protected override void OnButtonAClickOrCancel()
	{
		base.OnButtonAClickOrCancel();
		_buttonAPress = false;
	}

	protected override void OnButtonCPress()
	{
		base.OnButtonCPress();
		_buttonCPress = true;
	}

	protected override void OnButtonCCancel()
	{
		base.OnButtonCCancel();
		_buttonCPress = false;
	}

	protected override void OnButtonBPress()
	{
		if (ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.End, OnSkillFinish) && CommonUtils.HavePersonalPerk(_actor.dataID, 514007, out var _))
		{
			_actor.buffComponent.AddBuff(14007011, _actor);
		}
		_actor.logicVariable.ToggleLogicTag("HoldingKeyB", value: true);
	}

	protected override void OnButtonBCancel()
	{
		_actor.logicVariable.ToggleLogicTag("HoldingKeyB", value: false);
	}

	protected override void OnButtonDPress()
	{
		if (ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.D), _actor, SkillPhaseFeatureFlag.Ultimate, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false))
		{
			TransformFinish(forceFinish: true);
		}
	}

	private void OnSkillFinish(bool success)
	{
		if (!success)
		{
			return;
		}
		switch (_playerSkillCd.GetCurrentBindSkillId(ActionKey.B))
		{
		case 14031000:
			if (_actor.logicVariable.GetLogicTagToggle("IsTransformToTank"))
			{
				TransformToTank();
			}
			else if (_actor.logicVariable.GetLogicTagToggle("IsTransformToMiniGun"))
			{
				TransformToMiniGun();
			}
			else
			{
				TransformFailed();
			}
			break;
		case 14031012:
			DisableCastSkill();
			break;
		}
	}

	private void TransformToTank()
	{
		TransformMode = Config_MainControl.TransformMode.Tank;
		_transfromDuration = Config_MainControl.durationTime_Tank;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514003, out var perkLevel))
		{
			TransformSuccess(Config_MainControl.defaultSkillCD_Tank, 14031011, 14031012);
		}
		else
		{
			TransformSuccess(Config_MainControl.defaultSkillCD_Tank, 14031011);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514004, out perkLevel))
		{
			if (_perkLogic_P4 != null)
			{
				_actor.StopLogicCoroutine(_perkLogic_P4);
			}
			_perkLogic_P4 = _actor.StartLogicCoroutine(PerkLogic_P4(), runImmediately: true);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514009, out perkLevel))
		{
			_actor.buffComponent.AddBuff(14009011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514010, out perkLevel))
		{
			_actor.actorShield.AddShield(14010001, _actor);
			if (_perkLogic_P10 != null)
			{
				_actor.StopLogicCoroutine(_perkLogic_P10);
			}
			_perkLogic_P10 = _actor.StartLogicCoroutine(PerkLogic_P10(), runImmediately: true);
		}
	}

	private IEnumerator PerkLogic_P4()
	{
		FP interval = 0;
		while (true)
		{
			if (interval > 0)
			{
				interval -= _actor.LogicDeltaTime;
			}
			else
			{
				interval = Config_MainControl.addBuffInterval_P4;
				_actor.buffComponent.AddBuff(14004011, _actor);
			}
			yield return null;
		}
	}

	private IEnumerator PerkLogic_P10()
	{
		FP addInterval = CommonUtils.GetScriptValue(_actor, 14010011);
		FP interval = addInterval;
		ActorState movementState = _actor.movementState;
		while (true)
		{
			if (interval > 0)
			{
				interval -= _actor.LogicDeltaTime;
				if (movementState != _actor.movementState)
				{
					interval = addInterval;
					movementState = _actor.movementState;
				}
			}
			else
			{
				interval = addInterval;
				if (movementState == ActorState.StandBy)
				{
					_actor.buffComponent.AddBuff(14010012, _actor);
				}
			}
			yield return null;
		}
	}

	private void TransformToMiniGun()
	{
		TransformMode = Config_MainControl.TransformMode.MiniGun;
		_transfromDuration = Config_MainControl.durationTime_MiniGun;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514001, out var perkLevel))
		{
			TransformSuccess(Config_MainControl.defaultSkillCD_MiniGun, 14031021, 14031022);
		}
		else
		{
			TransformSuccess(Config_MainControl.defaultSkillCD_MiniGun, 14031021);
		}
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 514006, out perkLevel))
		{
			return;
		}
		for (int i = 0; i < Config_MainControl.transfromStateFxList_P6.Count; i++)
		{
			string fxAlias = Config_MainControl.transfromStateFxList_P6.get_Item(i);
			if (_playFXList_P6 == null)
			{
				_playFXList_P6 = new List<PlayFX>();
			}
			if (_playFXList_P6.Count <= i)
			{
				PlayFX playFX = new PlayFX();
				playFX.Play(_actor, null, fxAlias, default, _actor.tsTransform.Position, default);
				_playFXList_P6.Add(playFX);
			}
			else
			{
				_playFXList_P6.get_Item(i).Play(_actor, null, fxAlias, default, _actor.tsTransform.Position, default);
			}
		}
		_actor.buffComponent.AddBuff(14006011, _actor);
		EnableForbiddenRush();
	}

	private void TransformSuccess(FP defaultSkillCD, int replaceNormalAttackId, int replaceSkillId = 0)
	{
		_playerSkillCd.BindSkillIdToButton(ActionKey.A, 14031001);
		((PlayerAdventureActor)_actor).playerAIInfo.SpecialSkillId = 14031002;
		_playerSkillCd.BindSkillIdToButton(ActionKey.C, 14031002);
		_playerSkillCd.BindSkillIdToButton(ActionKey.Normal, replaceNormalAttackId);
		if (replaceSkillId > 0)
		{
			_playerSkillCd.BindSkillIdToButton(ActionKey.B, replaceSkillId);
		}
		else
		{
			_playerSkillCd.BindSkillIdToButton(ActionKey.B, 14031004);
			DisableCastSkill();
		}
		if (defaultSkillCD >= 0)
		{
			SkillInfo skillCD = _playerSkillCd.GetSkillCD(14031000);
			if (skillCD != null)
			{
				skillCD.originalSectionResumeTime = defaultSkillCD;
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514011, out var perkLevel))
		{
			_actor.buffComponent.AddBuff(14011011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514012, out perkLevel))
		{
			_playerSkillCd.SetSkillTotalSection(ActionKey.A, _playerSkillCd.GetSkillCD(ActionKey.A).originalTotalSectionAmount + 1, forceMaxSection: true);
		}
		else
		{
			_playerSkillCd.ResetSkillTotalSection(ActionKey.A);
		}
		MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintEnd", _playerSkillCd.GetCurrentBindSkillId(ActionKey.B));
		MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintStart", _playerSkillCd.GetCurrentBindSkillId(ActionKey.B), _transfromDuration.AsFloat(), a3: true, _transfromDuration.AsFloat());
	}

	private void TransformFailed()
	{
		TransformMode = Config_MainControl.TransformMode.None;
		_transfromDuration = 0;
		_playerSkillCd.ModifyOriginalSectionResumeTime(ActionKey.B, Config_MainControl.defaultSkillCD_MiniGun);
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: true);
		UpdatePerformFx();
		HoldButtonAorButtonC = _buttonAPress || _buttonCPress;
		if (_actor.actorSkillManage.HaveSkill(SkillPhaseFeatureFlag.Ultimate))
		{
			return;
		}
		if (_actor.attackTarget == null || (_actor.actorSkillManage.HaveSkill(SkillPhaseFeatureFlag.Dodge) && !_actor.specialDodgeMode) || _actor.actorSkillManage.HaveSkill(SkillPhaseFeatureFlag.Skill2) || IsObstacleBetweenActorAndTargetAndPreventNormalAttack)
		{
			if (_actor.aimMode != AdventureActor.AimMode.Forward)
			{
				_aimTarget.Cancel();
			}
		}
		else
		{
			FP fP = _actor.DistanceWithRadius(_actor.attackTarget);
			if (fP < CommonUtils.GetAimRange(_actor))
			{
				if (_actor.aimMode != AdventureActor.AimMode.AimAtAttackTarget)
				{
					_aimTarget.Aim(_actor, (AdventureActor)_actor.attackTarget);
				}
				if (fP <= CommonUtils.GetAttackRange(_actor))
				{
					ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal), _actor, SkillPhaseFeatureFlag.Normal, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
				}
			}
			else if (_actor.aimMode != AdventureActor.AimMode.Forward)
			{
				_aimTarget.Cancel();
			}
		}
		if (TransformMode != Config_MainControl.TransformMode.None)
		{
			if (_transfromDuration > 0)
			{
				_transfromDuration -= _actor.LogicDeltaTime;
			}
			else
			{
				TransformFinish();
			}
		}
	}

	private void UpdatePerformFx()
	{
		if (_actor.actorSkillManage.HaveSkill(SkillPhaseFeatureFlag.Skill2 | SkillPhaseFeatureFlag.Dodge))
		{
			PlayPerformFx = false;
		}
		else if (TransformMode == Config_MainControl.TransformMode.MiniGun)
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 514006, out var _))
			{
				PlayPerformFx = false;
			}
			else
			{
				PlayPerformFx = true;
			}
		}
		else
		{
			PlayPerformFx = true;
		}
	}

	private void TransformFinish(bool forceFinish = false)
	{
		MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintEnd", _playerSkillCd.GetCurrentBindSkillId(ActionKey.B));
		if (forceFinish)
		{
			RetrunDefaultState();
		}
		else if (ILRuntimeAPI.CreateSkill(14031003, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false))
		{
			RetrunDefaultState();
		}
	}

	private void RetrunDefaultState()
	{
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514004, out var perkLevel))
		{
			if (_perkLogic_P4 != null)
			{
				_actor.StopLogicCoroutine(_perkLogic_P4);
			}
			_perkLogic_P4 = null;
			_actor.buffComponent.RemoveBuffByBuffId(14004011);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514006, out perkLevel))
		{
			List<PlayFX> playFXList_P = _playFXList_P6;
			if (playFXList_P != null && playFXList_P.Count > 0)
			{
				foreach (PlayFX item in _playFXList_P6)
				{
					item.Stop();
					item.Clear();
				}
			}
			_actor.buffComponent.RemoveBuffByBuffId(14006011);
			_actor.buffComponent.RemoveBuffByBuffId(14006012);
			DisableForbiddenRush();
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514009, out perkLevel))
		{
			_actor.buffComponent.RemoveBuffByBuffId(14009011);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514010, out perkLevel))
		{
			if (_perkLogic_P10 != null)
			{
				_actor.StopLogicCoroutine(_perkLogic_P10);
			}
			_perkLogic_P10 = null;
		}
		TransformMode = Config_MainControl.TransformMode.None;
		_transfromDuration = 0;
		_playerSkillCd.BindSkillIdToButton(ActionKey.Normal, 14010000);
		_playerSkillCd.BindSkillIdToButton(ActionKey.A, 14020000);
		((PlayerAdventureActor)_actor).playerAIInfo.SpecialSkillId = 14070000;
		_playerSkillCd.BindSkillIdToButton(ActionKey.C, 14070000);
		_playerSkillCd.BindSkillIdToButton(ActionKey.B, 14031000, resetSection: true);
		EnableCastSkill();
	}

	private void EnableCastSkill()
	{
		if (_disableCastSkill)
		{
			_actor.EnableCastSkill();
			_actor.RefreshSkillUseable();
			_disableCastSkill = false;
		}
	}

	private void DisableCastSkill()
	{
		if (!_disableCastSkill)
		{
			_actor.DisableCastSkill();
			_actor.RefreshSkillUseable();
			_disableCastSkill = true;
		}
	}

	private void EnableForbiddenRush()
	{
		if (!_forbiddenRush)
		{
			_actor.EnableForbiddenRush();
			_forbiddenRush = true;
		}
	}

	private void DisableForbiddenRush()
	{
		if (_forbiddenRush)
		{
			_actor.DisableForbiddenRush();
			_forbiddenRush = false;
		}
	}

	private void Clear()
	{
		MonoSingleton<LuaManager>.Instance?.FireEvent("SkillHintEnd", _playerSkillCd.GetCurrentBindSkillId(ActionKey.B));
		_actor.ResumeAnimationGroup();
		PlayPerformFx = false;
		_aimTarget.Cancel();
		_aimTarget.Clear();
		RetrunDefaultState();
		_lastTriggerTime_P12 = 0;
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		Clear();
	}
}
