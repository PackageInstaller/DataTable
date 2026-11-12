using System;
using AIScript.Utils;

namespace AIScript.Character._11901;

public class SkillScript_Support : SkillAdvancedBase
{
	private const string key_Base = "119_Skill2_ClusterBomb";

	private const string shootDartsEvent = "119_Skill2_Shoot";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
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
		LogicEntity assistantAttackTarget = CommonUtils.GetAssistantAttackTarget(_actor);
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onComboFinish = OnFinishOrInterrupt;
		System.Action onInterrupt = OnFinishOrInterrupt;
		BeginAttack("119_Skill2_ClusterBomb", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, assistantAttackTarget, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	protected void OnCustomEvent(string eventName)
	{
		if (string.Equals("119_Skill2_Shoot", eventName))
		{
			HanaharaSkillShootEvent hanaharaSkillShootEvent = HanaharaSkillShootEvent.Generate();
			hanaharaSkillShootEvent.sender = _actor;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(hanaharaSkillShootEvent);
		}
	}
}
