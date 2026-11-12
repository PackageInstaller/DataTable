#define LOG_ERROR
using System;

namespace AIScript.Monster.Soldier._108;

public class MainSkill : SkillAdvancedBase
{
	private readonly string comboTag = "MainSkill";

	private const int loopCount = 1;

	public static readonly int buffId_Combo = 250104401;

	private static readonly int buffNum_Combo = 3;

	private int _loopCount;

	public void OnStart()
	{
		_loopCount = 0;
		AddComboBuff();
		string actionTag = comboTag;
		Action onComboLoop = OnComboLoop;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, null, null, fadeOutAnim: false, onComboLoop);
	}

	private void OnComboLoop()
	{
		_loopCount++;
		if (_loopCount >= 1)
		{
			comboAttack?.CancelAttack();
		}
	}

	private void AddComboBuff()
	{
		if (buffId_Combo > 0 && buffNum_Combo > 0 && !(_actor.buffComponent == null))
		{
			_actor.buffComponent.AddBuffNum(buffId_Combo, buffNum_Combo, _actor);
			if (!_actor.buffComponent.CheckBuffByBuffID(buffId_Combo))
			{
				NovaLogger.Error($"108 主控技能：连段替换 buff {buffId_Combo} 添加失败，普攻的连段替换分支不会生效。" + "常见原因：①Buff/BuffValue 配表查不到该 id；②该 buff 配了\"减益(DeBuff)\"标签而棋子处于无双/无敌/离场态被 CheckBuff 静默拒收；③与已有 buff 的 GroupId/Sort 互斥。");
			}
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
}
