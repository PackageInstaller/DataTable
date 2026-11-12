using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11601;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private List<TSVector2> _shootDirectionList;

	private bool _isStrength;

	private bool _triggerPerk_P3;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_isStrength = _actor.buffComponent.CheckBuffByBuffTag(Config_MainControl.buffTag_Strength_Skill);
		_triggerPerk_P3 = false;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511603, out var _))
		{
			_triggerPerk_P3 = _actor.logicVariable.GetLogicTagValue("TriggerBulletCount_P3").AsInt() >= 12;
		}
	}

	public void OnStart()
	{
		string text = (_isStrength ? "Shoot_Strength" : "Shoot");
		if (_triggerPerk_P3)
		{
			text = (_isStrength ? "Shoot_Perk03" : "Shoot_Perk03");
		}
		if (_actor.attackTarget != null)
		{
			FP logicTagValue = _actor.logicVariable.GetLogicTagValue("LastUseSpecialCombo_NormalAttack");
			if ((logicTagValue <= 0 || _actor.LogicTime - logicTagValue > Config.interval_UseSpecialCombo_NormalAttack) && _actor.DistanceWithRadius(_actor.attackTarget) < Config.distance_UseSpecialCombo_NormalAttack)
			{
				text = "Melee";
				if (CommonUtils.HavePersonalPerk(_actor.dataID, 511612, out var _))
				{
					text = "Melee_Strengthed";
				}
				_actor.logicVariable.SetLogicTagValue("LastUseSpecialCombo_NormalAttack", _actor.LogicTime);
			}
		}
		string actionTag = text;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "116_Event_NormalAtk_Shoot"))
		{
			Shoot();
		}
	}

	private void Shoot()
	{
		TSVector2 position;
		FP y;
		if (_triggerPerk_P3)
		{
			position = _actor.tsTransform.Position + _actor.tsTransform.Left * Config_MainControl.shootPositionOffset_NormalAttack_P3.x + _actor.tsTransform.Forward * Config_MainControl.shootPositionOffset_NormalAttack_P3.z;
			y = Config_MainControl.shootPositionOffset_NormalAttack_P3.y;
			if (_isStrength)
			{
				position = _actor.tsTransform.Position + _actor.tsTransform.Left * Config_MainControl.shootPositionOffset_NormalAttack_Strength_P3.x + _actor.tsTransform.Forward * Config_MainControl.shootPositionOffset_NormalAttack_Strength_P3.z;
				y = Config_MainControl.shootPositionOffset_NormalAttack_Strength_P3.y;
			}
			ILRuntimeAPI.ShootByDirection("Bullet_11601_NormalBullet_Perk03", _actor, default, _actor.tsTransform.Forward, position, y);
			_actor.logicVariable.SetLogicTagValue("TriggerBulletCount_P3", 0);
			return;
		}
		int num = 2;
		FP fP = Config.shootIncludedAngle_NormalAttack;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511604, out var perkLevel))
		{
			num += 2;
			fP = Config_MainControl.shootIncludedAngle_NormalAttack_P4;
		}
		if (num <= 0)
		{
			return;
		}
		position = _actor.tsTransform.Position + _actor.tsTransform.Left * Config.shootPositionOffset_NormalAttack.x + _actor.tsTransform.Forward * Config.shootPositionOffset_NormalAttack.z;
		y = Config.shootPositionOffset_NormalAttack.y;
		if (_isStrength)
		{
			position = _actor.tsTransform.Position + _actor.tsTransform.Left * Config_MainControl.shootPositionOffset_NormalAttack_Strength.x + _actor.tsTransform.Forward * Config_MainControl.shootPositionOffset_NormalAttack_Strength.z;
			y = Config_MainControl.shootPositionOffset_NormalAttack_Strength.y;
		}
		string bulletAlias = (_isStrength ? "Bullet_11601_NormalBullet_MainSkill" : "Bullet_11601_NormalBullet");
		if (_shootDirectionList == null)
		{
			_shootDirectionList = new List<TSVector2>();
		}
		else
		{
			_shootDirectionList.Clear();
		}
		if (num > 1)
		{
			FP fP2 = (num - 1) * fP;
			TSVector2 v = TSVector2.Rotate(_actor.tsTransform.Forward, -fP2 * 0.5f);
			for (int i = 0; i < num; i++)
			{
				_shootDirectionList.Add(TSVector2.Rotate(v, fP * i));
			}
		}
		else
		{
			_shootDirectionList.Add(_actor.tsTransform.Forward);
		}
		for (int j = 0; j < _shootDirectionList.Count; j++)
		{
			AdventureBulletBase adventureBulletBase = ILRuntimeAPI.ShootByDirection(bulletAlias, _actor, default, _shootDirectionList.get_Item(j), position, y);
			if (adventureBulletBase != null)
			{
				if (_isStrength)
				{
					adventureBulletBase.AddSubTag(Config_MainControl.bulletSubTag_IsStrength);
				}
				if (CommonUtils.HavePersonalPerk(_actor.dataID, 511608, out perkLevel))
				{
					adventureBulletBase.ModifyWeaponScaleByMulti(1 + Config_MainControl.addBulletScale_P8 * 0.01f);
				}
			}
		}
		if (!_isStrength)
		{
			_actor.ammoInfo?.RefreshAmmoCost(-num);
		}
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_isStrength = false;
	}
}
