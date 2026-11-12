using System;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12701;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private Dictionary<int, string> dicKey = new Dictionary<int, string>
	{
		[1] = "Atk1",
		[2] = "Atk2",
		[3] = "Atk3",
		[4] = "Atk4"
	};

	private AimTarget _aimTarget = new AimTarget();

	private bool _canLockTarget;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_canLockTarget = true;
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
		LockDirection(_canLockTarget ? default(TSVector2) : _actor.tsTransform.Forward);
	}

	private void DoMainLogic()
	{
		int key = (int)(long)_actor.logicVariable.GetLogicTagValue("curNormalPhase");
		string actionTag = dicKey.get_Item(key);
		Action<string> action = onCustomEvent;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string evt)
	{
		if (string.Equals(evt, "127_S"))
		{
			_canLockTarget = false;
		}
	}
}
