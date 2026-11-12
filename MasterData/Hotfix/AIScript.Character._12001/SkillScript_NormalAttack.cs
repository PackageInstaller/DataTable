using System;
using System.Collections.Generic;
using AdventureBehaviour;

namespace AIScript.Character._12001;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private static readonly Dictionary<int, string> actionTagDic = new Dictionary<int, string>
	{
		[1] = "Atk1",
		[2] = "Atk2",
		[3] = "Atk3",
		[4] = "Atk4",
		[5] = "Atk5"
	};

	private static readonly Dictionary<int, string> actionTagDic_Plus = new Dictionary<int, string>
	{
		[1] = "Atk1_P04",
		[2] = "Atk2_P04",
		[3] = "Atk3_P04",
		[4] = "Atk4_P04",
		[5] = "Atk5_P04"
	};

	protected ComboAttack _comboAttack;

	protected AimTarget _aimTarget;

	private int _stage;

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Parallel.normalSkill = false;
	}

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		Parallel.normalSkill = true;
		_stage = (int)(long)_actor.logicVariable.GetLogicTagValue("SkillNormalAttackStage_120");
	}

	public void OnStart()
	{
		string actionTag = GetActionTag();
		if (string.IsNullOrEmpty(actionTag))
		{
			OnFinish();
			return;
		}
		System.Action onAnticipationEnd = OnAnticipationEnd;
		System.Action onComboFinish = OnFinish;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private string GetActionTag()
	{
		if (_actor.buffComponent.CheckBuffByBuffID(12004011) && actionTagDic_Plus.TryGetValue(_stage, out var value))
		{
			return value;
		}
		if (actionTagDic.TryGetValue(_stage, out var value2))
		{
			return value2;
		}
		return null;
	}

	protected void OnCustomEvent(string evt)
	{
	}

	private void OnAnticipationEnd()
	{
		int num = ((_stage >= actionTagDic.Count) ? 1 : (_stage + 1));
		_actor.logicVariable.SetLogicTagValue("SkillNormalAttackStage_120", num);
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	public void OnUpdate()
	{
	}
}
