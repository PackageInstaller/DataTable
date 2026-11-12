#define LOG_ERROR
using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15701;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private bool _havePerk_P3;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_havePerk_P3 = CommonUtils.HavePersonalPerk(_actor.dataID, 515703, out var _);
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
	}

	public void OnStart()
	{
		string text = Config.comboTagList_NormalAttack.get_Item(TSRandom.Range(0, Config.comboTagList_NormalAttack.Count));
		if (_havePerk_P3)
		{
			long num = _actor.logicVariable.GetLogicTagValue("HuntingTargetId").AsLong();
			if (_actor.attackTarget != null && _actor.attackTarget.Id == num)
			{
				text = "Atk_P3";
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
		if (string.Equals(eventName, "157pugong"))
		{
			TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Left * Config.shootOffset_NormalAttack.x + _actor.tsTransform.Forward * Config.shootOffset_NormalAttack.y;
			string bulletAlias = "Bullet_157_NrmAtk_1";
			if (_havePerk_P3)
			{
				int buffNumByID = _actor.buffComponent.GetBuffNumByID(15703011);
				if (Config_MainControl.shootBulletKeyList_P3.ContainsKey(buffNumByID))
				{
					bulletAlias = Config_MainControl.shootBulletKeyList_P3.get_Item(buffNumByID);
				}
			}
			ILRuntimeAPI.ShootByDirection(bulletAlias, _actor, default, _actor.tsTransform.Forward, position, Config.shootPositionY_NormalAttack);
		}
		else
		{
			if (!string.Equals(eventName, "157diaoshe") || !_havePerk_P3)
			{
				return;
			}
			int num = _actor.buffComponent.GetBuffNumByID(15703011) + 1;
			if (Config_MainControl.bulletKeyList_P3.TryGetValue(num, out var value) && value.Count == num)
			{
				DeterministicShape shape = new DeterministicShape
				{
					shapeType = DeterministicShape.ShapeType.Circle,
					innerRadius = 0,
					radius = Config_MainControl.randomRadius_NormalAttack_P3,
					position = ((_actor.attackTarget != null) ? (_actor.tsTransform.Position + (_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized * (TSVector2.Distance(_actor.tsTransform.Position, _actor.attackTarget.tsTransform.Position) - _actor.attackTarget.GetRadius())) : (_actor.tsTransform.Position + _actor.tsTransform.Forward * Config_MainControl.offset_NoTarget_NormalAttack_P3))
				};
				TSVector2 position2 = _actor.tsTransform.Position + _actor.tsTransform.Left * Config_MainControl.shootOffset_NormalAttack_P3.x + _actor.tsTransform.Forward * Config_MainControl.shootOffset_NormalAttack_P3.y;
				for (int i = 0; i < value.Count; i++)
				{
					ILRuntimeAPI.Shoot(value.get_Item(i), targetPosition: ILRuntimeAPI.GetRandomPointInShape(_actor, shape, isReachable: false), actor: _actor, range: default, position: position2, positionY: Config_MainControl.shootPositionY_NormalAttack_P3, target: null, aimType: AimType.Position, bulletDirectionType: BulletDirectionType.BulletToTarget);
				}
			}
			else
			{
				NovaLogger.Error("未配置射击次数对应的子弹列表或子弹列表配置错误");
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
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = false;
	}
}
