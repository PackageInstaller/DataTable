#define LOG_DEBUG
using System;
using AIScript.Utils;
using TrueSync;
using TrueSync.Physics2D;

namespace AIScript.Character._13701;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private int _attackCount;

	private string _attackTag;

	private static bool IsNormalComboTag(string tag)
	{
		return Config.comboTagListNormalAttack.Contains(tag);
	}

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		NovaLogger.Debug("13701 SkillNormalAttack OnStart");
		if (_actor.attackTarget == null)
		{
			OnFinish();
			return;
		}
		int buffNumByID = _actor.buffComponent.GetBuffNumByID(13700012);
		int num = 0;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513702, out var perkLevel))
		{
			num = (int)(long)CommonUtils.GetScriptValue(_actor, 13702011);
		}
		int num2 = 10 - num;
		if (buffNumByID >= num2)
		{
			bool flag = CommonUtils.HavePersonalPerk(_actor.dataID, 513701, out perkLevel);
			bool flag2 = CommonUtils.HavePersonalPerk(_actor.dataID, 513705, out perkLevel);
			if (flag & flag2)
			{
				_attackTag = "Atk_Sp_P1_P5";
			}
			else if (flag)
			{
				_attackTag = "Atk_Sp_P1";
			}
			else if (flag2)
			{
				_attackTag = "Atk_Sp_P5";
			}
			else
			{
				_attackTag = "Atk_Sp";
			}
			_actor.buffComponent.RemoveBuffByBuffId(13700012, num2);
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513703, out perkLevel))
			{
				_actor.buffComponent.AddBuff(13703011, _actor);
			}
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513706, out perkLevel))
			{
				_actor.buffComponent.AddBuff(13706011, _actor);
			}
			CommonHelper_137.TryFireGrenade(_actor);
		}
		else
		{
			FP logicTagValue = _actor.logicVariable.GetLogicTagValue("LastNormalAttackTime");
			if (_actor.LogicTime > logicTagValue + Config.SaveComboIndexTime)
			{
				_attackCount = 0;
			}
			else
			{
				_attackCount = (int)(long)_actor.logicVariable.GetLogicTagValue("NormalAttackCount");
			}
			_attackCount = MathUtils.Clamp(_attackCount, 0, Config.comboTagListNormalAttack.Count);
			_attackTag = Config.comboTagListNormalAttack.get_Item(_attackCount);
		}
		NovaLogger.Debug($"13701 NormalAttack Start attackCount = {_attackCount}, attackTag = {_attackTag}");
		string attackTag = _attackTag;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action<string> onCustomEvent = OnCustomEvent;
		BeginAttack(attackTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	public void OnUpdate()
	{
		LockDirection();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.logicVariable.SetLogicTagValue("LastNormalAttackTime", _actor.LogicTime);
	}

	protected void OnAnticipationEnd()
	{
		NovaLogger.Debug($"13701 NormalAttack OnAnticipationEnd attackCount = {_attackCount}");
		if (IsNormalComboTag(_attackTag))
		{
			if (++_attackCount >= Config.comboTagListNormalAttack.Count)
			{
				_attackCount = 0;
			}
			_actor.logicVariable.SetLogicTagValue("NormalAttackCount", _attackCount);
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		NovaLogger.Debug("13701 NormalAttack Interrupted");
		if (!IsNormalComboTag(_attackTag))
		{
			_actor.buffComponent.RemoveBuffByBuffId(13700012);
		}
		OnFinish();
	}

	private void OnCustomEvent(string eventName)
	{
		NovaLogger.Debug("13701 NormalAttack CustomEvent: " + eventName);
	}
}
