using System;

namespace AIScript.Character._11301;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private string key_1_base = "A1";

	private string key_1_P11 = "A1_P11";

	private string key_2_base = "A2";

	private string key_2_P11 = "A2_P11";

	private string key_3_base = "A3";

	private string key_3_P11 = "A3_P11";

	private const int perkId_11 = 511311;

	private int buff_11 = 11311011;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.movementFSM.runtimeIgonreRootMotion = false;
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	private void OnFinish()
	{
		_skill?.Clear();
	}

	private void OnInterrupt()
	{
		_skill?.Clear();
	}

	public void OnUpdate()
	{
		LockDirection();
	}

	private void DoMainLogic()
	{
		string text = key_1_base;
		bool perkLv = GetPerkLv(511311, out var _);
		bool flag = _actor.buffComponent.CheckBuffByBuffID(buff_11);
		switch ((int)(long)_actor.logicVariable.GetLogicTagValue("curNormalPhase"))
		{
		case 1:
			text = key_1_base;
			if (perkLv & flag)
			{
				text = key_1_P11;
			}
			break;
		case 2:
			text = key_2_base;
			if (perkLv & flag)
			{
				text = key_2_P11;
			}
			break;
		case 3:
			text = key_3_base;
			if (perkLv & flag)
			{
				text = key_3_P11;
			}
			break;
		}
		string actionTag = text;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
