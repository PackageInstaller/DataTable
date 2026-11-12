#define LOG_DEBUG
using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50020ShaYuFaShi;

public class Skill_ShadowBall : SkillAdvancedBase
{
	private LookAtTarget lookAtTarget;

	private readonly FP lookAtTargetDuration = 9999;

	private readonly FP lookAtTargetAngleSpd = 180;

	private readonly int buffID = 990020010;

	public void OnStart()
	{
		SkillLogic();
	}

	private void SkillLogic()
	{
		ComboInputBuffer.ActionKey[] keys = new ComboInputBuffer.ActionKey[1];
		Action onComboFinish = OnComboFinish;
		Action<string> onCustomEvent = OnCustomEvent;
		BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, null, onCustomEvent);
		void OnComboFinish()
		{
			SkillFinish();
		}
		void OnCustomEvent(string evtName)
		{
			switch (evtName)
			{
			case "A":
				NovaLogger.Debug("触发事件A");
				NovaLogger.Debug("朝向玩家");
				if (lookAtTarget == null)
				{
					lookAtTarget = new LookAtTarget();
				}
				lookAtTarget.BeginLookAt(_actor, _actor.monsterTarget, lookAtTargetDuration, lookAtTargetAngleSpd, null);
				break;
			case "B":
				NovaLogger.Debug("触发事件B");
				NovaLogger.Debug("停止朝向玩家");
				lookAtTarget.StopLookAt();
				lookAtTarget.Clear();
				break;
			case "AddBuff":
				NovaLogger.Debug("触发事件AddBuff");
				_actor.buffComponent?.AddBuff(buffID, _actor);
				break;
			case "RemoveBuff":
				NovaLogger.Debug("触发事件RemoveBuff");
				_actor.buffComponent?.RemoveBuffByBuffId(buffID);
				break;
			}
		}
	}

	private void SkillFinish()
	{
		NovaLogger.Debug("技能结束");
		_skill?.Clear();
		if (lookAtTarget != null)
		{
			lookAtTarget.StopLookAt();
			lookAtTarget.Clear();
			lookAtTarget = null;
		}
	}
}
