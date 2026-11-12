using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14001;

public class SkillScript_Skill_Tank_MainControl : SkillAdvancedBase
{
	private int _shootIndex;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (CommonUtils.CheckAllPlayerActorAreSameElement(HotfixEnum.elementType.SE))
		{
			_actor.actorShield.AddShield(14003011, _actor);
		}
		_shootIndex = 0;
	}

	public void OnStart()
	{
		string text = "140_Tank_P03_Skill";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514004, out var _))
		{
			text = "140_Tank_P03_Skill_P04";
		}
		string actionTag = text;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "Tank_Skill"))
		{
			TSVector2 tSVector = _actor.tsTransform.Position + _actor.tsTransform.Left * Config_MainControl.shootOffset_Skill_Tank.x + _actor.tsTransform.Forward * Config_MainControl.shootOffset_Skill_Tank.y;
			FP shootPositionY_Skill_Tank = Config_MainControl.shootPositionY_Skill_Tank;
			TSVector2 result = tSVector + _actor.tsTransform.Forward * Config_MainControl.offsetDistance_NoTarget_Skill_Tank;
			if (_actor.attackTarget != null)
			{
				result = _actor.attackTarget.tsTransform.Position;
			}
			if (!_actor.QueryPositionWalkable(result))
			{
				_actor.QueryClosestPositionWalkable(result, out result);
			}
			ILRuntimeAPI.Shoot("Bullet_140_Tank_Skill", _actor, default, tSVector, shootPositionY_Skill_Tank, result, null, AimType.Position, BulletDirectionType.BulletToTarget);
			_shootIndex++;
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 514004, out var perkLevel) && _shootIndex > 1)
			{
				_actor.buffComponent.RemoveBuffByBuffId(14004011, 1);
			}
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 514008, out perkLevel))
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_14001_Tank_P08P03", _actor.tsTransform.Position, _actor.tsTransform.Rotation);
			}
		}
	}

	public void OnUpdate()
	{
		LockDirection();
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
		_actor.actorShield.RemoveShieldByShieldID(14003011);
		_shootIndex = 0;
	}
}
