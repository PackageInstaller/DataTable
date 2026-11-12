using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11601;

public class SkillScript_Skill_MainControl : SkillAdvancedBase
{
	private List<TSVector2> _shootDirectionList;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		DefaultLookAt();
	}

	public void OnStart()
	{
		string text = "B1_Skill";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511601, out var _))
		{
			text = "B1_Skill_Perk1";
		}
		string actionTag = text;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	public void OnUpdate()
	{
		LockDirection();
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "116_MainSkill_Shoot"))
		{
			Shoot();
		}
		else if (string.Equals(eventName, "116_MainSkill_StrengthShoot"))
		{
			_actor.buffComponent.RemoveBuffByTag(Config_MainControl.buffTag_Strength_Skill);
			int buffID = 11690011;
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 511610, out var _))
			{
				buffID = 11610011;
			}
			_actor.buffComponent.AddBuff(buffID, _actor);
			_actor.ammoInfo.ammoCount = _actor.ammoInfo.ammoCountMax;
		}
	}

	private void Shoot()
	{
		TSVector2 tSVector = _actor.tsTransform.Position + _actor.tsTransform.Left * Config_MainControl.shootPositionOffset_Skill.x + _actor.tsTransform.Forward * Config_MainControl.shootPositionOffset_Skill.z;
		FP y = Config_MainControl.shootPositionOffset_Skill.y;
		string bulletAlias = "Bullet_11601_MainSkill_Seed";
		int num = 1;
		FP fP = 0;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511601, out var perkLevel))
		{
			bulletAlias = "Bullet_11601_MainSkill_Seed_Perk01";
			num = 2;
			fP = Config_MainControl.totalAngle_Shoot_Skill_P1;
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 511607, out perkLevel))
			{
				FP scriptValue = CommonUtils.GetScriptValue(_actor, 11607011);
				if (TSRandom.Range(FP.Zero, 100) <= scriptValue)
				{
					num++;
					fP = Config_MainControl.totalAngle_Shoot_Skill_P1_P7;
				}
			}
		}
		else if (CommonUtils.HavePersonalPerk(_actor.dataID, 511607, out perkLevel))
		{
			FP scriptValue2 = CommonUtils.GetScriptValue(_actor, 11607011);
			if (TSRandom.Range(FP.Zero, 100) <= scriptValue2)
			{
				num++;
				fP = Config_MainControl.totalAngle_Shoot_Skill_P7;
			}
		}
		if (num <= 0)
		{
			return;
		}
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
			FP fP2 = fP / (num - 1);
			TSVector2 v = TSVector2.Rotate(_actor.tsTransform.Forward, -fP * 0.5f);
			for (int i = 0; i < num; i++)
			{
				_shootDirectionList.Add(TSVector2.Rotate(v, fP2 * i));
			}
		}
		else
		{
			_shootDirectionList.Add(_actor.tsTransform.Forward);
		}
		FP fP3 = Config_MainControl.maxShootDistance_Skill;
		if (_actor.attackTarget != null)
		{
			fP3 = TSMath.Clamp(TSVector2.Distance(tSVector, _actor.attackTarget.tsTransform.Position) - _actor.attackTarget.GetRadius(), Config_MainControl.minShootDistance_Skill, Config_MainControl.maxShootDistance_Skill);
		}
		for (int j = 0; j < _shootDirectionList.Count; j++)
		{
			TSVector2 result = tSVector + _shootDirectionList.get_Item(j) * fP3;
			if (!_actor.QueryPositionWalkable(result))
			{
				_actor.QueryClosestPositionWalkable(result, out result);
			}
			AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot(bulletAlias, _actor, default, tSVector, y, result, null, AimType.Position, BulletDirectionType.BulletToTarget);
			if (adventureBulletBase != null && CommonUtils.HavePersonalPerk(_actor.dataID, 511605, out perkLevel))
			{
				adventureBulletBase.ModifyWeaponScaleByMulti(1 + Config_MainControl.addBulletScale_P5 * 0.01f);
			}
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
	}
}
