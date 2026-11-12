using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._13001;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
		Aim();
	}

	public void OnStart()
	{
		string comboTag = GetComboTag();
		Action onComboLoop = OnComboLoop;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onRecoveryBegin = OnRecoveryBegin;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(comboTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, onRecoveryBegin, onComboFinish, onInterrupt, onCustomEvent, null, fadeOutAnim: false, onComboLoop);
	}

	protected virtual string GetComboTag()
	{
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513011, out var _) && _actor.logicVariable.GetLogicTagToggle("TriggerPerk_P11"))
		{
			_actor.logicVariable.ToggleLogicTag("TriggerPerk_P11", value: false);
			return "Normal_P11_Attack";
		}
		return "Attack";
	}

	private void OnComboLoop()
	{
		Aim();
		((PlayerAdventureActor)_actor).playerSkillCd.AddSkillEnergyPool(_skill.skillId);
	}

	protected virtual void Aim()
	{
		DefaultLookAt();
	}

	protected virtual void OnCustomEvent(string eventName)
	{
		if (!string.Equals(eventName, "Shoot_P05") || !CommonUtils.HavePersonalPerk(_actor.dataID, 513001, out var _) || !_actor.logicVariable.GetLogicTagToggle("TriggerPerk_P1"))
		{
			return;
		}
		int buffNumByID = _actor.buffComponent.GetBuffNumByID(13005011);
		if (buffNumByID > 0)
		{
			int num = 0;
			for (int i = 0; i < buffNumByID; i++)
			{
				Transform slotNode = _actor.slotConfig.GetSlotNode(Config_MainControl.shootSlotList_P1.get_Item(num));
				TSVector2 tSVector = new TSVector2(slotNode.transform.position.x, slotNode.position.z);
				TSVector2 shootDir = _actor.tsTransform.Forward;
				if (_actor.attackTarget != null)
				{
					shootDir = _actor.attackTarget.tsTransform.Position - tSVector;
				}
				ILRuntimeAPI.ShootByDirection("Bullet_130_B1_Attack_P05", _actor, default, shootDir, tSVector, slotNode.transform.position.y);
				num++;
				num = ((num < Config_MainControl.shootSlotList_P1.Count) ? num : 0);
			}
			_actor.buffComponent.RemoveBuffByBuffId(13005011);
		}
		_actor.logicVariable.ToggleLogicTag("TriggerPerk_P1", value: false);
	}

	public virtual void OnUpdate()
	{
		if (CheckInterrupt())
		{
			comboAttack?.InterruptAttack();
		}
		else if (CheckCancel())
		{
			comboAttack?.CancelAttack();
		}
	}

	protected virtual bool CheckInterrupt()
	{
		return SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection() != TSVector2.zero;
	}

	protected bool CheckCancel()
	{
		return _actor.attackTarget == null;
	}

	protected virtual void OnRecoveryBegin()
	{
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
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = false;
	}
}
