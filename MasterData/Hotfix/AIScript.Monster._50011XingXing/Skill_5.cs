#define LOG_DEBUG
using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50011XingXing;

public class Skill_5 : SkillAdvancedBase
{
	protected readonly string _eventName = "SkillEnd";

	protected readonly string _eventDodgeStart = "DodgeStart01";

	protected readonly string _eventTurnStart = "TurnStart01";

	private readonly string addBuff = "AddBuff";

	private readonly string delBuff = "DelBuff";

	private readonly int buffId = 990031100;

	protected ComboAttack _comboAttack;

	protected List<TSVector2> pointLs = new List<TSVector2>(8);

	private Dodge _dodge;

	private readonly LookAtTarget _lookAtTarget = new LookAtTarget();

	private TSVector2 targetPos;

	private FP pontF;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_50011XingXing Skill_5 OnDisable");
		base.OnSkillDisable();
		_lookAtTarget.Clear();
		_comboAttack?.Clear();
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_50011XingXing Skill_5 OnEnable");
		base.OnSkillEnable();
		pointLs.Clear();
		pointLs.Add(new TSVector2(-13, 0));
		pointLs.Add(new TSVector2(13, 0));
		pointLs.Add(new TSVector2(0, 13));
		pointLs.Add(new TSVector2(0, -13));
		pointLs.Add(new TSVector2(10.5, 8.5));
		pointLs.Add(new TSVector2(-10.5, 8.5));
		pointLs.Add(new TSVector2(10.5, -8.5));
		pointLs.Add(new TSVector2(10.5, 8.5));
	}

	public void OnStart()
	{
		NovaLogger.Debug("_50011XingXing Skill_5 OnStart");
		if (!(_skill != null))
		{
			return;
		}
		SetSkillPhaseConfig(SkillPhaseFeatureFlag.None, null, SkillPhaseFeatureFlag.None, null);
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		if (!CommonUtils.CheckTargetIsValid(activedPlayerActor, 0L))
		{
			OnFinish();
			return;
		}
		ILRuntimeAPI.SortByDistance(activedPlayerActor.tsTransform.Position, ref pointLs);
		FP fP = 360;
		int index = 0;
		for (int i = 0; i < 4; i++)
		{
			FP fP2 = TSVector2.Angle(-pointLs.get_Item(i), _actor.tsTransform.Forward);
			if (fP2 < fP)
			{
				index = i;
				fP = fP2;
			}
		}
		targetPos = pointLs.get_Item(index);
		if (_comboAttack == null)
		{
			_comboAttack = new ComboAttack();
		}
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[2]
		{
			ComboInputBuffer.ActionKey.D,
			ComboInputBuffer.ActionKey.A
		};
		pontF = TSVector2.Dot(_actor.tsTransform.Forward, targetPos - _actor.tsTransform.Position);
		if (pontF < 0)
		{
			array = new ComboInputBuffer.ActionKey[2]
			{
				ComboInputBuffer.ActionKey.E,
				ComboInputBuffer.ActionKey.A
			};
		}
		ComboAttack comboAttack = _comboAttack;
		AdventureActor actor = _actor;
		AdventureSkill skill = _skill;
		ComboInputBuffer.ActionKey[] actionKeys = array;
		int skillId = ((_skill != null) ? _skill.skillId : 0);
		Action onAnticipationEnd = OnAnticipationEnd;
		Action onInterrupt = OnInterrupt;
		Action<string> onCustomEvent = OnCustomEvent;
		comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: false, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, null, null, onInterrupt, onCustomEvent);
	}

	protected void OnAnticipationEnd()
	{
	}

	protected void OnDashComplete()
	{
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[2]
		{
			ComboInputBuffer.ActionKey.D,
			ComboInputBuffer.ActionKey.B
		};
		if (pontF < 0)
		{
			array = new ComboInputBuffer.ActionKey[2]
			{
				ComboInputBuffer.ActionKey.E,
				ComboInputBuffer.ActionKey.B
			};
		}
		ComboAttack comboAttack = _comboAttack;
		AdventureActor actor = _actor;
		AdventureSkill skill = _skill;
		ComboInputBuffer.ActionKey[] actionKeys = array;
		int skillId = ((_skill != null) ? _skill.skillId : 0);
		Action onComboFinish = OnDbFinsh;
		Action onInterrupt = OnInterrupt;
		comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: true, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onComboFinish, onInterrupt);
	}

	protected void OnDbFinsh()
	{
		ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.F };
		ComboAttack comboAttack = _comboAttack;
		AdventureActor actor = _actor;
		AdventureSkill skill = _skill;
		int skillId = ((_skill != null) ? _skill.skillId : 0);
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		Action<string> onCustomEvent = OnCustomEvent;
		comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: true, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	protected void OnCustomEvent(string eventName)
	{
		if (_eventName.Equals(eventName))
		{
			_actor.buffComponent.RemoveBuffByBuffId(buffId);
			_comboAttack.CancelAttack();
			OnFinish();
		}
		else if (eventName.Equals(_eventDodgeStart))
		{
			if (_dodge == null)
			{
				_dodge = new Dodge();
			}
			TSVector2 normalized = (targetPos - _actor.tsTransform.Position).normalized;
			FP fP = TSVector2.Distance(targetPos, _actor.tsTransform.Position);
			FP duration = fP / 24;
			_dodge.Begin(_actor, normalized, duration, fP, OnDashComplete, comboWithAttack: true, notChangeForward: true);
		}
		else if (eventName.Equals(_eventTurnStart))
		{
			FP duration2 = TSVector2.Distance(targetPos, _actor.tsTransform.Position) / 8;
			_lookAtTarget.BeginLookAtByPos(_actor, -targetPos, duration2, 350, () =>
			{
				_actor.LookAt(-targetPos, 0);
			});
		}
		else if (eventName.Equals(addBuff))
		{
			_actor.buffComponent.AddBuff(buffId, _actor);
		}
		else if (eventName.Equals(delBuff))
		{
			_actor.buffComponent.RemoveBuffByBuffId(buffId);
		}
	}

	protected void OnFinish()
	{
		NovaLogger.Debug("_50011XingXing Skill_5 onFinish");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("_50011XingXing Skill_5 onInterrupt");
		_skill.Clear();
	}
}
