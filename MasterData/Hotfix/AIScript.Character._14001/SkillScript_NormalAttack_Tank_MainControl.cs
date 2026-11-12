using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14001;

public class SkillScript_NormalAttack_Tank_MainControl : SkillAdvancedBase
{
	private int _shootIndex;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_shootIndex = 0;
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
	}

	public void OnStart()
	{
		string comboTag = GetComboTag();
		if (string.IsNullOrEmpty(comboTag))
		{
			_skill.Clear();
			return;
		}
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(comboTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private string GetComboTag()
	{
		string result = "140_Attack_Tank";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514004, out var _))
		{
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(14004011);
			result = Config_MainControl.comboTagList_NormalAttack_Tank_P4.get_Item(TSMath.Clamp(buffNumByID, 0, Config_MainControl.comboTagList_NormalAttack_Tank_P4.Count - 1).AsInt());
		}
		return result;
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "Tank_Attack"))
		{
			TSVector2 tSVector = _actor.tsTransform.Position + _actor.tsTransform.Left * Config_MainControl.shootOffset_NormalAttack_Tank.x + _actor.tsTransform.Forward * Config_MainControl.shootOffset_NormalAttack_Tank.y;
			FP shootPositionY_NormalAttack_Tank = Config_MainControl.shootPositionY_NormalAttack_Tank;
			TSVector2 result = tSVector + _actor.tsTransform.Forward * Config_MainControl.offsetDistance_NoTarget_NormalAttack_Tank;
			if (_actor.attackTarget != null)
			{
				result = _actor.attackTarget.tsTransform.Position;
			}
			if (!_actor.QueryPositionWalkable(result))
			{
				_actor.QueryClosestPositionWalkable(result, out result);
			}
			ILRuntimeAPI.Shoot("Bullet_140_Tank_Attack", _actor, default, tSVector, shootPositionY_NormalAttack_Tank, result, null, AimType.Position, BulletDirectionType.BulletToTarget);
			_shootIndex++;
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 514004, out var perkLevel) && _shootIndex > 1)
			{
				_actor.buffComponent.RemoveBuffByBuffId(14004011, 1);
			}
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 514008, out perkLevel))
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_14001_Tank_P08", _actor.tsTransform.Position, _actor.tsTransform.Rotation);
			}
		}
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget == null)
		{
			comboAttack.InterruptAttack();
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
		_shootIndex = 0;
	}
}
