using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14001;

public class SkillScript_Dodge_TransformMode_MainControl : SkillAdvancedBase
{
	private ComboInputBuffer.ActionKey[] _comboKeys_Dodge;

	private FP _duration_Dodge;

	private FP _distance_Dodge;

	private Dodge _dodge;

	private SpecialDodge _specialDodge_P6;

	private PlayFX _playFX_P6;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		InitParam();
	}

	private void InitParam()
	{
		if (Enum.TryParse<Config_MainControl.TransformMode>(_actor.logicVariable.GetLogicTagStringValue("TransformMode"), out var result))
		{
			switch (result)
			{
			case Config_MainControl.TransformMode.Tank:
				_comboKeys_Dodge = Config_MainControl.comboKeys_Dodge_Tank;
				_duration_Dodge = Config_MainControl.duration_Dodge_Tank;
				_distance_Dodge = Config_MainControl.distance_Dodge_Tank;
				return;
			case Config_MainControl.TransformMode.MiniGun:
			{
				_comboKeys_Dodge = Config_MainControl.comboKeys_Dodge_MiniGun;
				_duration_Dodge = Config_MainControl.duration_Dodge_MiniGun;
				_distance_Dodge = Config_MainControl.distance_Dodge_MiniGun;
				if (CommonUtils.HavePersonalPerk(_actor.dataID, 514006, out var _))
				{
					_comboKeys_Dodge = null;
					_duration_Dodge = Config_MainControl.duration_Dodge_MiniGun_P6;
					_distance_Dodge = Config_MainControl.distance_Dodge_MiniGun_P6;
				}
				return;
			}
			}
		}
		_skill.Clear();
	}

	public void OnStart()
	{
		TSVector2 tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		if (tSVector == TSVector2.zero)
		{
			tSVector = _actor.tsTransform.Forward.normalized;
		}
		if (_comboKeys_Dodge != null)
		{
			ComboInputBuffer.ActionKey[] comboKeys_Dodge = _comboKeys_Dodge;
			Action onActivationEnd = OnActivationEnd;
			Action onComboFinish = OnFinish;
			Action onInterrupt = OnInterrupt;
			BeginAttack(comboKeys_Dodge, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, onActivationEnd);
			if (_dodge == null)
			{
				_dodge = new Dodge();
			}
			_dodge.Begin(_actor, tSVector, _duration_Dodge, _distance_Dodge, null, comboWithAttack: true);
		}
		else
		{
			SetSkillPhaseConfig(SkillPhaseFeatureFlag.Normal, null, SkillPhaseFeatureFlag.None, null);
			if (_specialDodge_P6 == null)
			{
				_specialDodge_P6 = new SpecialDodge();
			}
			_specialDodge_P6.Begin(_actor, tSVector, _duration_Dodge, _distance_Dodge, null, OnFinish);
			if (_playFX_P6 == null)
			{
				_playFX_P6 = new PlayFX();
			}
			else
			{
				_playFX_P6.Clear();
			}
			_playFX_P6.Play(_actor, _skill, "fx_14001_base_Dodge_Type_Gun_Fly", 0, _actor.tsTransform.Position, -tSVector);
		}
	}

	private void OnActivationEnd()
	{
		if (((PlayerAdventureActor)_actor).dodgeButtonHold && !_actor.forbiddenRush)
		{
			int specialSkillId = ((PlayerAdventureActor)_actor).playerAIInfo.SpecialSkillId;
			if (specialSkillId != 0)
			{
				ILRuntimeAPI.CreateSkill(specialSkillId, _actor, SkillPhaseFeatureFlag.Skill2, SkillLauncherType.Character, isInterruptAttack: false);
				OnFinish();
			}
		}
	}

	private void OnFinish()
	{
		_skill?.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_dodge?.Interrupte();
		_specialDodge_P6?.Interrupte();
		_playFX_P6?.Stop();
		_playFX_P6?.Clear();
	}
}
