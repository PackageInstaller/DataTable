using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13001;

public class SkillScript_MainControl_NormalAttack : SkillScript_NormalAttack
{
	private PlayerSkillCd _playerSkillCd;

	private List<LogicEntity> _targets_2;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_playerSkillCd = _actor.GetLogicComponent<PlayerSkillCd>();
	}

	protected override string GetComboTag()
	{
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513011, out var _) && _actor.logicVariable.GetLogicTagToggle("TriggerPerk_P11"))
		{
			_actor.logicVariable.ToggleLogicTag("TriggerPerk_P11", value: false);
			return "B1P11_Attack";
		}
		return "B1_Attack";
	}

	protected override void Aim()
	{
		LockDirection();
	}

	private void CancelAim()
	{
		CancelLockDirection();
	}

	public override void OnUpdate()
	{
		if (CheckInterrupt())
		{
			comboAttack?.InterruptAttack();
			CancelAim();
		}
		else if (CheckCancel())
		{
			comboAttack?.CancelAttack();
			CancelAim();
		}
		else
		{
			Aim();
		}
	}

	protected override bool CheckInterrupt()
	{
		if (_skill.skillId != _playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal))
		{
			return true;
		}
		if (_actor.attackTarget == null)
		{
			return _actor.movementState != ActorState.Idle;
		}
		return _actor.DistanceWithRadius(_actor.attackTarget) > CommonUtils.GetAttackRange(_actor);
	}

	protected override void OnCustomEvent(string eventName)
	{
		base.OnCustomEvent(eventName);
		if (string.Equals(eventName, "B1Perk02_Shoot") && CommonUtils.HavePersonalPerk(_actor.dataID, 513002, out var _) && _actor.attackTarget != null)
		{
			ILRuntimeAPI.SearchByRangeAndPosition(_actor, _actor.attackTarget.tsTransform.Position, Config_MainControl.searchRadius_P2, OnSearchTargetFinish_2, isConfront: true);
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	private void OnSearchTargetFinish_2(List<LogicEntity> targets)
	{
		if (targets == null || targets.Count <= 0 || Config_MainControl.bulletPathList_P2.Count <= 0)
		{
			return;
		}
		if (_targets_2 == null)
		{
			_targets_2 = new List<LogicEntity>(10);
		}
		else
		{
			_targets_2.Clear();
		}
		bool flag = false;
		if (_actor.attackTarget != null)
		{
			for (int i = 0; i < targets.Count; i++)
			{
				if (targets.get_Item(i).Id == _actor.attackTarget.Id)
				{
					_targets_2.Add(targets.get_Item(i));
					flag = true;
					break;
				}
			}
			for (int j = 0; j < targets.Count; j++)
			{
				if (targets.get_Item(j).Id != _actor.attackTarget.Id)
				{
					_targets_2.Add(targets.get_Item(j));
				}
			}
		}
		else
		{
			_targets_2.AddRange(targets);
		}
		int num = 0;
		int num2 = 0;
		bool flag2 = false;
		while (true)
		{
			LogicEntity logicEntity = _targets_2.get_Item(num2) ?? _targets_2.get_Item(0);
			ILRuntimeAPI.Shoot((_targets_2.Count > 1) ? Config_MainControl.bulletPathList_P2.get_Item(TSRandom.Range(0, Config_MainControl.bulletPathList_P2.Count)) : Config_MainControl.bulletPathList_P2.get_Item(num), position: _actor.tsTransform.Position + _actor.tsTransform.Left * Config_MainControl.shootOffset_P2.x + _actor.tsTransform.Forward * Config_MainControl.shootOffset_P2.z, actor: _actor, range: default, positionY: Config_MainControl.shootOffset_P2.y, targetPosition: logicEntity.tsTransform.Position, target: logicEntity, aimType: AimType.Target, bulletDirectionType: BulletDirectionType.BulletToTarget);
			num++;
			if (num >= Config_MainControl.bulletPathList_P2.Count)
			{
				break;
			}
			if (flag2)
			{
				if (flag)
				{
					num2 = 0;
					continue;
				}
				num2++;
				num2 = ((num2 < _targets_2.Count) ? num2 : 0);
				continue;
			}
			num2++;
			if (num2 >= _targets_2.Count)
			{
				flag2 = true;
				num2 = 0;
			}
		}
	}
}
