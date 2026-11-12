using System;
using AIScript.Utils;

namespace AIScript.Character._16201;

public class SkillScript_ExtraSkill_MainControl : SkillAdvancedBase
{
	private bool _isInvincible;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 516206, out var _))
		{
			_actor.buffComponent.AddBuff(16290002, _actor);
		}
		_actor.EnableSuperArmor();
		_isInvincible = false;
		DefaultLookAt();
	}

	public void OnStart()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Skill_Main_SuperQing", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "162wudistart"))
		{
			if (!_isInvincible)
			{
				_isInvincible = true;
				_actor.EnableInvincible();
			}
		}
		else if (string.Equals(eventName, "162wudiend") && _isInvincible)
		{
			_isInvincible = false;
			_actor.DisableInvincible();
		}
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
		_actor.DisableSuperArmor();
		if (_isInvincible)
		{
			_actor.DisableInvincible();
		}
		_isInvincible = false;
	}
}
