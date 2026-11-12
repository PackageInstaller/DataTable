using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._10015;

public class MainSkill : SkillAdvancedBase
{
	private readonly string comboTag = "Skill";

	private readonly string eventName_Shoot = "Fire";

	private readonly string bulletKey = "Bullet";

	private readonly TSVector2 shootOffset = new TSVector2(0, 0);

	private readonly FP shootPositionY = 0;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		string actionTag = comboTag;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, eventName_Shoot))
		{
			TSVector2 tSVector = _actor.tsTransform.Position + _actor.tsTransform.Left * shootOffset.x + _actor.tsTransform.Forward * shootOffset.y;
			TSVector2 normalized = (_actor.attackTarget.tsTransform.Position - tSVector).normalized;
			ILRuntimeAPI.ShootByDirection(bulletKey, _actor, default, normalized, tSVector, shootPositionY);
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}
}
