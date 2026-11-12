#define LOG_ERROR
#define LOG_DEBUG
using System;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._11201;

public class SkillScript_Zhiyuan_Skill : Skill
{
	private readonly string Skill2_Small2Loop = "Skill2_Small2Loop";

	private readonly string Skill2_Small2LoopT23 = "Skill2_Small2Loop_P23";

	private readonly string Skill2_Small2LoopT29 = "Skill2_Small2Loop_P29";

	private readonly string Skill2_Small2LoopT23T29 = "Skill2_Small2Loop_P23P29";

	private Dictionary<int, string> dicSkillTag = new Dictionary<int, string>
	{
		[0] = "Skill2_Big",
		[1] = "Skill2_Big_P21",
		[10] = "Skill2_Big_P22",
		[100] = "Skill2_Big_P26",
		[11] = "Skill2_Big_P21P22",
		[101] = "Skill2_Big_P21P26",
		[110] = "Skill2_Big_P22P26",
		[111] = "Skill2_Big_P21P22P26"
	};

	private int currentLoop_count;

	private int loopCount;

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.CancelAiming();
	}

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public string GetActionTag(int step = 1)
	{
		if (step == 1)
		{
			string result = Skill2_Small2Loop;
			loopCount = 2;
			if (GetPerk(Parallel.personalPerkId_23))
			{
				result = ((!GetPerk(Parallel.personalPerkId_29)) ? Skill2_Small2LoopT23 : Skill2_Small2LoopT23T29);
			}
			else if (GetPerk(Parallel.personalPerkId_29))
			{
				result = Skill2_Small2LoopT29;
			}
			if (GetPerk(Parallel.personalPerkId_24))
			{
				loopCount += 2;
			}
			return result;
		}
		int num = 0;
		if (GetPerk(Parallel.personalPerkId_21))
		{
			num++;
		}
		if (GetPerk(Parallel.personalPerkId_22))
		{
			num += 10;
		}
		if (GetPerk(Parallel.personalPerkId_26))
		{
			num += 100;
		}
		if (!dicSkillTag.TryGetValue(num, out var value))
		{
			NovaLogger.Error($"_11201 Zhiyuan dicSkillTag missing key: {num}, fallback to 0");
			return dicSkillTag.get_Item(0);
		}
		return value;
	}

	private void SetTarget()
	{
		_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor);
		if (_actor.attackTarget != null)
		{
			TSVector2 direction = _actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position;
			_actor.Aim(direction);
		}
	}

	public override void OnStart()
	{
		NovaLogger.Debug("===================_11201 SkillScript_Zhiyuan_Skill OnStart");
		currentLoop_count = 0;
		string actionTag = GetActionTag();
		System.Action onRecoveryBegin = OnRecoveryBegin;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onComboLoop = OnComboLoop;
		System.Action onAnticipationEnd = OnAnticipationEnd;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, onAnticipationEnd, onRecoveryBegin, null, onInterrupt, onCustomEvent, null, fadeOutAnim: false, onComboLoop);
	}

	protected void OnAnticipationEnd()
	{
	}

	protected void OnComboLoop()
	{
		currentLoop_count++;
		if (currentLoop_count >= loopCount)
		{
			comboAttack.CancelAttack();
		}
	}

	protected virtual void OnRecoveryBegin()
	{
		string actionTag = GetActionTag(2);
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		System.Action onAnticipationEnd = OnStepTwoBegin;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: true, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	protected void OnStepTwoBegin()
	{
	}

	protected virtual void OnFinish()
	{
		NovaLogger.Debug("===================_11201 SkillScript_Zhiyuan_Skill onFinish");
		_skill.Clear();
	}

	protected virtual void OnInterrupt()
	{
		NovaLogger.Debug("===================_11201 SkillScript_Zhiyuan_Skill onInterrupt");
		_skill.Clear();
	}

	public void OnUpdate()
	{
		SetTarget();
	}
}
