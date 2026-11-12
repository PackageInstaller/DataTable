using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._10006;

public class MainSkill : SkillAdvancedBase
{
	private readonly string comboTag = "Skill";

	private readonly string eventName_GenerateAreaEffect = "Fire";

	private readonly string areaEffectKey = "AreaEffect_Skill";

	private readonly FP loopDuration = 0.67;

	private bool _beginLoop;

	private FP _loopDuration;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_beginLoop = false;
	}

	public void OnStart()
	{
		string actionTag = comboTag;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnAnticipationEnd()
	{
		_loopDuration = loopDuration;
		_beginLoop = true;
	}

	public void OnUpdate()
	{
		if (_beginLoop)
		{
			if (_loopDuration > 0)
			{
				_loopDuration -= _actor.LogicDeltaTime;
				return;
			}
			_beginLoop = false;
			comboAttack.CancelAttack();
		}
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, eventName_GenerateAreaEffect))
		{
			TSVector2 position = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : _actor.tsTransform.Position);
			ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectKey, position);
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}
}
