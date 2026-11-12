using System;
using System.Collections.Generic;
using AdventureBehaviour;

namespace AIScript.Character._14201;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private Dictionary<int, string> dicKey = new Dictionary<int, string>
	{
		[1] = "Atk_1",
		[2] = "Atk_2",
		[3] = "Atk_3",
		[4] = "Atk_4"
	};

	private Dictionary<int, string> dicKey_P3 = new Dictionary<int, string>
	{
		[1] = "Atk_1_P3",
		[2] = "Atk_2_P3",
		[3] = "Atk_3_P3",
		[4] = "Atk_4_P3"
	};

	private const int perkId_3 = 514203;

	private int buff_3 = 14203011;

	private AimTarget _aimTarget = new AimTarget();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_aimTarget?.Cancel();
		_actor.movementFSM.runtimeIgonreRootMotion = false;
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		_skill.Clear();
	}

	public void OnUpdate()
	{
		LockDirection();
	}

	private void DoMainLogic()
	{
		int key = (int)(long)_actor.logicVariable.GetLogicTagValue("curNormalPhase");
		bool flag = _actor.buffComponent.CheckBuffByBuffID(buff_3);
		string value = "Atk_1";
		if (flag)
		{
			dicKey_P3.TryGetValue(key, out value);
		}
		else
		{
			dicKey.TryGetValue(key, out value);
		}
		string actionTag = value;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}
}
