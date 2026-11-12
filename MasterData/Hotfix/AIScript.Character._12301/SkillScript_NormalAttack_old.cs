using System;
using System.Collections.Generic;

namespace AIScript.Character._12301;

public class SkillScript_NormalAttack_old : SkillAdvancedBase
{
	private string key_1 = "Attack1";

	private string key_2 = "Attack2";

	private Dictionary<int, string> key_3 = new Dictionary<int, string>
	{
		[0] = "Attack3",
		[8] = "Attack3_P7",
		[4] = "Attack3_P8",
		[2] = "Attack3_P9",
		[1] = "Attack3_H2",
		[12] = "Attack3_P7P8",
		[10] = "Attack3_P7P9",
		[9] = "Attack3_H2_P7",
		[6] = "Attack3_P8P9",
		[5] = "Attack3_H2_P8",
		[3] = "Attack3_H2_P9",
		[14] = "Attack3_P7P8P9",
		[13] = "Attack3_H2_P7P8",
		[11] = "Attack3_H2_P7P9",
		[7] = "Attack3_H2_P8P9",
		[15] = "Attack3_H2_P7P8P9"
	};

	private string key_4 = "Attack4";

	private const int perkId_7 = 512306;

	private const int perkId_8 = 512307;

	private const int perkId_9 = 512308;

	private string actionKey;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Clear();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	private void Clear()
	{
		comboAttack?.Clear();
	}

	private void onFinish()
	{
		_skill?.Clear();
	}

	public void OnUpdate()
	{
		if (_actor.attackTarget == null)
		{
			comboAttack.InterruptAttack();
		}
	}

	public void ParseKey()
	{
		int num = (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512306, out var perkLevel) ? 8 : 0);
		int num2 = (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512307, out perkLevel) ? 4 : 0);
		int num3 = (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512308, out perkLevel) ? 2 : 0);
		int key = num | num2 | num3;
		switch ((int)(long)_actor.logicVariable.GetLogicTagValue("curNormalPhase"))
		{
		case 1:
			actionKey = key_1;
			break;
		case 2:
			actionKey = key_2;
			break;
		case 3:
			actionKey = key_3.get_Item(key);
			break;
		case 4:
			actionKey = key_4;
			break;
		default:
			actionKey = key_1;
			break;
		}
	}

	private void DoMainLogic()
	{
		ParseKey();
		string actionTag = actionKey;
		System.Action onComboFinish = onFinish;
		System.Action onInterrupt = onFinish;
		BeginAttack(actionTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt);
	}
}
