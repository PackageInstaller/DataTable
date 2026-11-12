#define LOG_ERROR
using System;
using TrueSync;

namespace AIScript.Character._14901;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private int _stage;

	private string _comboTag;

	private bool _canLockTarget;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_stage = (int)(long)_actor.logicVariable.GetLogicTagValue("NormalAttackStage");
		if (_stage < 0)
		{
			NovaLogger.Error($"非法的普攻段数:{_stage}");
			OnFinish();
			return;
		}
		_comboTag = ((_stage < Config.comboTagList_NormalAttack.Count) ? Config.comboTagList_NormalAttack.get_Item(_stage) : null);
		if (Config_MainControl.mainConcTime > 0)
		{
			if (GetPerk(514902))
			{
				_comboTag = ((_stage < Config.dicNormalTag_plus_p2.Count) ? Config.dicNormalTag_plus_p2.get_Item(_stage) : null);
			}
			else
			{
				_comboTag = ((_stage < Config.dicNormalTag_plus.Count) ? Config.dicNormalTag_plus.get_Item(_stage) : null);
			}
		}
		_canLockTarget = true;
	}

	public void OnStart()
	{
		if (string.IsNullOrEmpty(_comboTag))
		{
			NovaLogger.Error($"该普攻段数未配置,普攻段数:{_stage}");
			OnFinish();
			return;
		}
		string comboTag = _comboTag;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		Action<string> onCustomEvent = OnCustomEvent;
		BeginAttack(comboTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnAnticipationEnd()
	{
		int num = _stage + 1;
		_actor.logicVariable.SetLogicTagValue("NormalAttackStage", (num < Config.comboTagList_NormalAttack.Count) ? num : 0);
	}

	public void OnUpdate()
	{
		LockDirection(_canLockTarget ? default(TSVector2) : _actor.tsTransform.Forward);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "149_S"))
		{
			_canLockTarget = false;
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_stage = 0;
		_comboTag = null;
	}
}
