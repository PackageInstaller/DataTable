using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15001;

public class SkillScript_Skill_MainControl : SkillAdvancedBase
{
	private Queue<string> _sweepComboTagQueue;

	private AimTarget _aimTarget;

	private FP _maxRotateSpeed;

	private FP _maxRotateTime;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (_sweepComboTagQueue == null)
		{
			_sweepComboTagQueue = new Queue<string>();
		}
		else
		{
			_sweepComboTagQueue.Clear();
		}
		DefaultLookAt();
		if (_aimTarget == null)
		{
			_aimTarget = new AimTarget();
		}
		else
		{
			_aimTarget.Cancel();
		}
		_aimTarget.Aim(_actor, null, _actor.tsTransform.Forward);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515003, out var perkLevel))
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 515006, out perkLevel))
			{
				for (int i = 0; i < Config_MainControl.comboTagList_Skill_Sweep_P3_P6.Count; i++)
				{
					_sweepComboTagQueue.Enqueue(Config_MainControl.comboTagList_Skill_Sweep_P3_P6.get_Item(i));
				}
			}
			else
			{
				for (int j = 0; j < Config_MainControl.comboTagList_Skill_Sweep_P3.Count; j++)
				{
					_sweepComboTagQueue.Enqueue(Config_MainControl.comboTagList_Skill_Sweep_P3.get_Item(j));
				}
			}
		}
		else if (CommonUtils.HavePersonalPerk(_actor.dataID, 515006, out perkLevel))
		{
			_sweepComboTagQueue.Enqueue("150_Main_Skill_P06_A1");
		}
		else
		{
			_sweepComboTagQueue.Enqueue("150_Main_Skill_A1");
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515008, out perkLevel))
		{
			_actor.logicVariable.SetLogicTagValue("AdditionalAttrCount_P8", _actor.buffComponent.GetBuffNumByID(15008011));
			_actor.buffComponent.RemoveBuffByBuffId(15008011);
		}
		_maxRotateSpeed = 0;
		_maxRotateTime = 0;
	}

	public void OnStart()
	{
		SweepAttack();
	}

	private void SweepAttack()
	{
		if (_sweepComboTagQueue.Count > 0)
		{
			if (_actor.attackTarget != null)
			{
				_actor.tsTransform.Forward = (_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
			}
			string actionTag = _sweepComboTagQueue.Dequeue();
			Action onActivationEnd = OnSweepActivationEnd;
			Action onComboFinish = OnFinish;
			Action onInterrupt = OnInterrupt;
			BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, onActivationEnd);
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 515004, out var _))
			{
				_actor.buffComponent.AddBuff(15004011, _actor);
			}
		}
		else
		{
			OnFinish();
		}
	}

	private void OnSweepActivationEnd()
	{
		if (_sweepComboTagQueue.Count > 0 && _actor.logicVariable.GetLogicTagToggle("HoldingKeyB"))
		{
			SweepAttack();
		}
		else
		{
			ShootLaser();
		}
	}

	private void ShootLaser()
	{
		_maxRotateSpeed = 0;
		_maxRotateTime = 0;
		string text = "150_Main_Skill_B1";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515003, out var perkLevel))
		{
			int index = Config_MainControl.comboTagList_Skill_Sweep_P3.Count - _sweepComboTagQueue.Count - 1;
			text = Config_MainControl.comboTagList_Skill_Laser_P3.get_Item(index);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515004, out perkLevel))
		{
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(15004011);
			_actor.buffComponent.RemoveBuffByBuffId(15004011);
			_actor.logicVariable.SetLogicTagValue("AdditionalAttrCount_P4", buffNumByID);
			if (buffNumByID >= 3)
			{
				if (CommonUtils.HavePersonalPerk(_actor.dataID, 515003, out perkLevel))
				{
					int index2 = Config_MainControl.comboTagList_Skill_Sweep_P3.Count - _sweepComboTagQueue.Count - 1;
					text = Config_MainControl.comboTagList_Skill_Laser_P3_P4.get_Item(index2);
				}
				else
				{
					text = "150_Main_Skill_2_C1";
				}
				_maxRotateSpeed = Config_MainControl.rotateSpeed_P4;
				_maxRotateTime = Config_MainControl.laserLoopTime_MaxBuff_P4;
				_actor.buffComponent.AddBuff(15004012, _actor);
			}
		}
		if (_actor.attackTarget != null)
		{
			_actor.tsTransform.Forward = (_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
		}
		string actionTag = text;
		Action<string> onCustomEvent = OnLaserCustomEvent;
		Action onRecoveryBegin = OnLaserRecoveryBegin;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, onRecoveryBegin, onComboFinish, onInterrupt, onCustomEvent);
	}

	public void OnUpdate()
	{
		if (_maxRotateTime > 0)
		{
			TSVector2 movementInputDirection = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
			if (movementInputDirection != TSVector2.zero)
			{
				FP fP = TSVector2.SignedAngle(_actor.tsTransform.Forward, movementInputDirection);
				FP fP2 = _maxRotateSpeed * _actor.LogicDeltaTime;
				FP degrees = ((TSMath.Abs(fP) < fP2) ? fP : (fP2 * TSMath.Sign(fP)));
				_actor.tsTransform.Forward = TSVector2.Rotate(_actor.tsTransform.Forward, degrees);
			}
			_maxRotateTime -= _actor.LogicDeltaTime;
			if (_maxRotateTime <= 0)
			{
				comboAttack.CancelAttack();
			}
		}
	}

	private void OnLaserCustomEvent(string eventName)
	{
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515001, out var _) && string.Equals(eventName, "ElectricGrid_Start"))
		{
			TSVector2 position = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : _actor.tsTransform.Position);
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_150_Main_Skill_P01_ElectricGrid", position);
		}
	}

	private void OnLaserRecoveryBegin()
	{
		_actor.buffComponent.RemoveBuffByBuffId(15004012);
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
		_actor.buffComponent.RemoveBuffByBuffId(15004012);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515005, out var _))
		{
			_actor.buffComponent.AddBuff(15005011, _actor);
		}
		_actor.logicVariable.SetLogicTagValue("AdditionalAttrCount_P4", 0);
		_actor.logicVariable.SetLogicTagValue("AdditionalAttrCount_P8", 0);
		_aimTarget?.Cancel();
		_aimTarget?.Clear();
		_maxRotateSpeed = 0;
		_maxRotateTime = 0;
		_sweepComboTagQueue?.Clear();
	}
}
