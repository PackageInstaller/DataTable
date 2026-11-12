using System;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._11901;

public class SkillScript_MainControl : SkillAdvancedBase
{
	private string key_base = "119_Skill1_Boomerang";

	private string shootBoomerangEvent = "119_Skill1_Shoot";

	private FP searchRange = 15;

	public static readonly FP shootDelay = 0.5;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.CancelAiming();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	protected void OnFinishOrInterrupt()
	{
		_skill.Clear();
	}

	private void DoMainLogic()
	{
		_actor.attackTarget = _actor.attackTarget ?? CommonUtils.SearchNearTargetByCircle(_actor, searchRange);
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
		string actionTag = key_base;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onComboFinish = OnFinishOrInterrupt;
		System.Action onInterrupt = OnFinishOrInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	protected void OnCustomEvent(string eventName)
	{
		if (string.Equals(shootBoomerangEvent, eventName))
		{
			HanaharaSkillShootEvent hanaharaSkillShootEvent = HanaharaSkillShootEvent.Generate();
			hanaharaSkillShootEvent.sender = _actor;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(hanaharaSkillShootEvent);
		}
	}
}
