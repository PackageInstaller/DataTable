using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11601;

public class SkillScript_Skill_Summoned : SkillAdvancedBase
{
	private PlayerAdventureActor _summoner;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		if (logicComponent != null)
		{
			_summoner = logicComponent.SummonActor as PlayerAdventureActor;
		}
	}

	public void OnStart()
	{
		if (_actor.monsterTarget != null)
		{
			_actor.LookAt(_actor.monsterTarget.tsTransform.Position, 0);
		}
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("116_PeaShooter_Atk", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		int perkLevel;
		if (string.Equals(eventName, "PeaShooter_Fire"))
		{
			Shoot();
		}
		else if (string.Equals(eventName, "PeaShooter_RandomFire") && _summoner != null && CommonUtils.HavePersonalPerk(_summoner.dataID, 511607, out perkLevel))
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, 11607011);
			if (TSRandom.Range(FP.Zero, 100) <= scriptValue)
			{
				Shoot();
			}
		}
	}

	private void Shoot()
	{
		if (!(_summoner == null))
		{
			TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Left * Config_MainControl.shootPositionOffset_SummonedSkill_P2.x + _actor.tsTransform.Forward * Config_MainControl.shootPositionOffset_SummonedSkill_P2.z;
			FP y = Config_MainControl.shootPositionOffset_SummonedSkill_P2.y;
			TSVector2 result = _actor.tsTransform.Position + _actor.tsTransform.Forward * Config_MainControl.shootDistance_SummonedSkill_NoTarget_P2;
			if (_actor.monsterTarget != null)
			{
				result = _actor.monsterTarget.tsTransform.Position;
			}
			if (!_actor.QueryPositionWalkable(result))
			{
				_actor.QueryClosestPositionWalkable(result, out result);
			}
			AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot("Bullet_11601_MainSkill_Seed_PeaShooter", _summoner, default, position, y, result, null, AimType.Position, BulletDirectionType.BulletToTarget);
			if (adventureBulletBase != null && CommonUtils.HavePersonalPerk(_summoner.dataID, 511605, out var _))
			{
				adventureBulletBase.ModifyWeaponScaleByMulti(1 + Config_MainControl.addBulletScale_P5 * 0.01f);
			}
		}
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
	}
}
