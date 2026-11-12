using System;

namespace AIScript.Character._10301;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	protected readonly string _customEventName = "Shoot1";

	private readonly string _actionKey = "Attack_1";

	private readonly string _actionKey1 = "Attack_P02_AOE";

	private const int perkId_2 = 510302;

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

	public void OnUpdate()
	{
		if (_actor.attackTarget == null)
		{
			comboAttack.InterruptAttack();
		}
	}

	private void DoMainLogic()
	{
		string actionTag = ParseKey();
		Action onComboFinish = onFinish;
		Action onInterrupt = onFinish;
		Action<string> action = onCustomEvent;
		BeginAttack(actionTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private string ParseKey()
	{
		if (_actor.logicVariable.GetLogicTagToggle("attck_strong"))
		{
			return _actionKey1;
		}
		return _actionKey;
	}

	private void onCustomEvent(string eventName)
	{
		if (!eventName.Equals(_customEventName))
		{
			return;
		}
		AmmoInfo flowAmmoInfo = ActorHelper.GetFlowAmmoInfo(_actor.gameObject);
		if (flowAmmoInfo != null && flowAmmoInfo.ammoCount > 0)
		{
			flowAmmoInfo.RefreshAmmoCost(-1);
			if (_actor.logicVariable.GetLogicTagToggle("attck_strong") && flowAmmoInfo.ammoCount <= 0)
			{
				_actor.InterruptAttack(force: true);
			}
		}
	}

	private void onFinish()
	{
		_skill?.Clear();
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
