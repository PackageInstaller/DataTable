using System;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._11501;

public class SkillScript_NormalAttack_Irradiation_MainControl : SkillScript_FunnelFire_MainControl
{
	private long _attackTargetId;

	private FP _checkDistanceInterval;

	private bool _canSalvoShoot;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (_actor.attackTarget != null)
		{
			_attackTargetId = _actor.attackTarget.Id;
		}
		_checkDistanceInterval = Config_MainControl.checkDistanceInterval_Irradiation;
		_canSalvoShoot = false;
	}

	public void OnStart()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Main_Cannon_P01_Sustain", flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	protected override void OnBeginSalvoShoot()
	{
		_canSalvoShoot = CommonUtils.HavePersonalPerk(_actor.dataID, 511506, out var _);
	}

	public void OnUpdate()
	{
		bool flag = false;
		if ((_actor as PlayerAdventureActor).status == ActorStatus.Special)
		{
			if (_actor.attackTarget == null)
			{
				flag = true;
			}
			else if (_actor.attackTarget.Id != _attackTargetId)
			{
				_checkDistanceInterval = Config_MainControl.checkDistanceInterval_Irradiation;
				ChangeIrradiationTarget();
				flag = false;
			}
			else if (_checkDistanceInterval > 0)
			{
				_checkDistanceInterval -= _actor.LogicDeltaTime;
			}
			else
			{
				_checkDistanceInterval = Config_MainControl.checkDistanceInterval_Irradiation;
				flag = _actor.DistanceWithRadius(_actor.attackTarget) > Config_MainControl.interruptDistance_Irradiation;
			}
		}
		else
		{
			flag = true;
		}
		if (_canSalvoShoot && !flag && _actor.logicVariable.GetLogicTagToggle("TriggerPerk_P6"))
		{
			_actor.logicVariable.ToggleLogicTag("TriggerPerk_P6", value: false);
			SalvoShoot();
		}
		if (flag)
		{
			InterruptIrradiation();
			comboAttack.CancelAttack();
		}
	}

	private void ChangeIrradiationTarget()
	{
		StopSalvoShoot();
		_attackTargetId = _actor.attackTarget.Id;
		OnCustomEvent("115_Main_Sustain_Shoot");
	}

	private void InterruptIrradiation()
	{
		StopSalvoShoot();
		StopIrradiation();
		MonoSingleton<WwiseAudioManager>.Instance?.PlaySound("char_11501_skill_branch2_all_laser_stop");
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
		MonoSingleton<WwiseAudioManager>.Instance?.PlaySound("char_11501_skill_branch2_all_laser_stop");
		_attackTargetId = 0L;
		_checkDistanceInterval = 0;
		_canSalvoShoot = false;
	}
}
