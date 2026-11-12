#define LOG_DEBUG
using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11001;

public class SkillScript_Zhiyuan_Skill : SkillAdvancedBase
{
	private readonly string SkillTag = "110_Support_Skill_QuanZhang";

	private const string event_Name = "110_Support_Skill_QuanZhang_Zadi";

	private readonly string area_Boom = "Actor/Character/11001/Weapons/AreaEffect_110_Support_QuanZhang_Boom";

	private readonly string area_Left = "Actor/Character/11001/Weapons/AreaEffect_110_Support_QuanZhang";

	private readonly FP area_LeftTime = 3;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_11001 SkillScript_Zhiyuan_Skill OnDisable");
		base.OnSkillDisable();
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_11001 SkillScript_Zhiyuan_Skill OnEnable");
		base.OnSkillEnable();
	}

	public void OnLeftArea()
	{
	}

	public void OnStart()
	{
		NovaLogger.Debug("===================_11001 SkillScript_Zhiyuan_Skill OnStart");
		OnLeftArea();
		string skillTag = SkillTag;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onInterrupt = OnInterrupt;
		System.Action onComboFinish = OnFinish;
		BeginAttack(skillTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	protected void OnCustomEvent(string eventName)
	{
		if ("110_Support_Skill_QuanZhang_Zadi".Equals(eventName))
		{
			long num = ILRuntimeAPI.PlayAreaEffect(_actor, area_Left, _actor.tsTransform.Position, _actor.tsTransform.Rotation);
			Parallel.areaLeftId.Add(num);
			ILRuntimeAPI.ModifyAreaEffectLeftTime(num, area_LeftTime);
			if (GetPerk(511021))
			{
				ILRuntimeAPI.AddAreaEffectLeftTime(num, Parallel.addTime_21);
				Parallel.areaBoomId.Add(ILRuntimeAPI.PlayAreaEffect(_actor, "Actor/Character/11001/Weapons/AreaEffect_110_Support_QuanZhang_LoopAOE", _actor.tsTransform.Position, _actor.tsTransform.Rotation));
			}
			ILRuntimeAPI.PlayAreaEffect(_actor, area_Boom, _actor.tsTransform.Position, _actor.tsTransform.Rotation);
			int num2 = 0;
			if (GetPerk(511023))
			{
				num2 = 2;
			}
			_actor.logicVariable.SetLogicTagValue("fenSheng", 2 + num2);
		}
	}

	protected virtual void OnFinish()
	{
		NovaLogger.Debug("===================SkillScript_Zhiyuan_Skill _11001 onFinish");
		_skill.Clear();
	}

	protected virtual void OnInterrupt()
	{
		NovaLogger.Debug("===================_11001 SkillScript_Zhiyuan_Skill onInterrupt");
		_skill.Clear();
	}
}
