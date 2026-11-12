#define LOG_DEBUG
using System;
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50011XingXing;

public class Skill_2 : SkillAdvancedBase
{
	private readonly string startTurn = "Turn";

	private readonly string stopTurn = "StopTurn";

	private readonly FP rotSpd = 240;

	private CoroutineNode corRotate;

	protected ComboAttack _comboAttack;

	private readonly LookAtTarget lookAtTarget = new LookAtTarget();

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_50011XingXing Skill_2 OnDisable");
		base.OnSkillDisable();
		_comboAttack?.Clear();
		StopCoroutine(ref corRotate);
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_50011XingXing Skill_2 OnEnable");
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		NovaLogger.Debug("_50011XingXing Skill_2 OnStart");
		if (_skill != null)
		{
			SetSkillPhaseConfig(SkillPhaseFeatureFlag.None, null, SkillPhaseFeatureFlag.None, null);
			if (_comboAttack == null)
			{
				_comboAttack = new ComboAttack();
			}
			ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1];
			ComboAttack comboAttack = _comboAttack;
			AdventureActor actor = _actor;
			AdventureSkill skill = _skill;
			int skillId = ((_skill != null) ? _skill.skillId : 0);
			Action onComboFinish = OnFinish;
			Action onInterrupt = OnInterrupt;
			Action<string> action = onCustomEvent;
			comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: false, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onComboFinish, onInterrupt, action);
		}
	}

	private IEnumerator DoRotateLogic()
	{
		if (!CommonUtils.CheckTargetIsValid(_actor.monsterTarget, 0L))
		{
			yield break;
		}
		while (true)
		{
			lookAtTarget.BeginLookAt(_actor, _actor.monsterTarget, 0, rotSpd, () =>
			{
			});
			yield return null;
		}
	}

	private void onCustomEvent(string eventName)
	{
		if (eventName.Equals(startTurn))
		{
			StartCoroutine(ref corRotate, DoRotateLogic());
		}
		else if (eventName.Equals(stopTurn))
		{
			StopCoroutine(ref corRotate);
			lookAtTarget.StopLookAt();
		}
	}

	protected void OnFinish()
	{
		NovaLogger.Debug("_50011XingXing Skill_2 onFinish");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("_50011XingXing Skill_2 onInterrupt");
		_skill.Clear();
	}
}
