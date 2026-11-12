using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13901;

public class SkillScript_Skill_Support : SkillAdvancedBase
{
	private int _totalLoopTimes;

	private int _loopTims;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_loopTims = 0;
		_totalLoopTimes = 1;
		DefaultLookAt();
	}

	public void OnStart()
	{
		string text = "139_Skill_Sup";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513922, out var perkLevel))
		{
			text = (CommonUtils.HavePersonalPerk(_actor.dataID, 513923, out perkLevel) ? "139_Skill_Sup_P23P22" : "139_Skill_Sup_P22");
			_totalLoopTimes += CommonUtils.GetScriptValue(_actor, 13922011).AsInt();
		}
		else if (CommonUtils.HavePersonalPerk(_actor.dataID, 513923, out perkLevel))
		{
			text = "139_Skill_Sup_P23";
		}
		string actionTag = text;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action onComboLoop = OnComboLoop;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent, null, fadeOutAnim: false, onComboLoop);
	}

	private void OnAnticipationEnd()
	{
		_loopTims = 0;
	}

	private void OnComboLoop()
	{
		_loopTims++;
		if (_loopTims >= _totalLoopTimes)
		{
			comboAttack?.CancelAttack();
		}
	}

	public void OnUpdate()
	{
		if (!CommonUtils.CheckTargetIsValid(_actor.attackTarget, 0L))
		{
			_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor);
		}
		LockDirection();
	}

	private void OnCustomEvent(string eventName)
	{
		int perkLevel;
		if (string.Equals(eventName, "139_Sup_Area"))
		{
			string fxAlias = "AreaEffect_13901_Sup";
			TSVector2 tSVector = Config_Support.offset_AreaEffect_Skill;
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513924, out perkLevel))
			{
				if (CommonUtils.HavePersonalPerk(_actor.dataID, 513930, out perkLevel))
				{
					fxAlias = "AreaEffect_13901_Sup_P30P24";
					tSVector = Config_Support.offset_AreaEffect_Skill_P24_P30;
				}
				else
				{
					fxAlias = "AreaEffect_13901_Sup_P24";
					tSVector = Config_Support.offset_AreaEffect_Skill_P24;
				}
			}
			else if (CommonUtils.HavePersonalPerk(_actor.dataID, 513930, out perkLevel))
			{
				fxAlias = "AreaEffect_13901_Sup_P30";
				tSVector = Config_Support.offset_AreaEffect_Skill_P30;
			}
			TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Left * tSVector.x + _actor.tsTransform.Forward * tSVector.y;
			ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, position, _actor.tsTransform.Rotation);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513921, out perkLevel) && Config_Support.shootInfoDic_P21.TryGetValue(eventName, out (string, FP) value))
		{
			TSVector2 normalized = TSVector2.Rotate(_actor.tsTransform.Forward, value.Item2).normalized;
			TSVector2 position2 = _actor.tsTransform.Position + normalized * Config_Support.shootRadius_P21;
			ILRuntimeAPI.ShootByDirection(value.Item1, _actor, default, normalized, position2, Config_Support.shootPositionY_P21);
		}
	}

	private void OnFinish()
	{
		_skill?.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_loopTims = 0;
	}
}
