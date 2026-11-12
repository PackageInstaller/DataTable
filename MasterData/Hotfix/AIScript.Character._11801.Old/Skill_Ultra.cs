#define LOG_DEBUG
using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11801.Old;

public class Skill_Ultra : SkillAdvancedBase
{
	protected ComboAttack _comboAttack;

	protected PlayTimeline _playTimeline;

	protected PlayFX _playFX;

	protected FP _phase1CheckRange = 10;

	protected FP _checkInterval = 0.5;

	protected FP _checkDuration = 5;

	protected readonly int _attckTotalCount = 5;

	protected FP _moveSpeed = 2;

	protected readonly int _moveLevel = 99;

	protected FP _strength = 4;

	protected readonly int _hitDamageId = 1180501;

	protected readonly int _buffId = 11812;

	protected readonly int _reduceSpdBuffId = 11804;

	protected CoroutineNode _attackCoroutine;

	protected int _attackCount;

	protected ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.U,
		ComboInputBuffer.ActionKey.T
	};

	protected ComboInputBuffer.ActionKey[] _actionKeysForNoTimeline = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.U,
		ComboInputBuffer.ActionKey.A
	};

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("11801 Skill_Ultra OnDisable");
		base.OnSkillDisable();
		Clear();
		_comboAttack?.Clear();
		_playFX?.Stop();
		_playFX?.Clear();
		_actor.CancelAiming();
		_actor.buffComponent.RemoveBuffByBuffId(_reduceSpdBuffId);
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("11801 Skill_Ultra OnEnable");
		base.OnSkillEnable();
		_actor.Aim(_actor.tsTransform.Forward);
		_actor.buffComponent.AddBuff(_reduceSpdBuffId, _actor);
		_attackCount = 0;
	}

	public virtual void OnStart()
	{
		NovaLogger.Debug("11801 Skill_Ultra OnStart");
		if (_skill != null)
		{
			SetSkillPhaseConfig(SkillPhaseFeatureFlag.None, null, SkillPhaseFeatureFlag.None, null);
			_actor.EnableImmuneControl();
			if (_playTimeline == null)
			{
				_playTimeline = new PlayTimeline();
			}
			_playTimeline.Play(_actor, () =>
			{
				Attack(_actionKeys);
			}, () =>
			{
				Attack(_actionKeysForNoTimeline);
			});
		}
	}

	protected void Attack(ComboInputBuffer.ActionKey[] actionKeys)
	{
		if (_comboAttack == null)
		{
			_comboAttack = new ComboAttack();
		}
		ComboAttack comboAttack = _comboAttack;
		AdventureActor actor = _actor;
		AdventureSkill skill = _skill;
		int skillId = ((_skill != null) ? _skill.skillId : 0);
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		System.Action onComboLoop = OnComboLoop;
		Action<string> onCustomEvent = OnCustomEvent;
		comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: false, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboLoop, onComboFinish, onInterrupt, onCustomEvent);
	}

	protected void OnCustomEvent(string eventName)
	{
		if (!(eventName == "EffectOn"))
		{
			if (eventName == "EffectOff")
			{
				_playFX.Stop();
			}
			return;
		}
		if (_playFX == null)
		{
			_playFX = new PlayFX();
		}
		_playFX.Play(_actor, _skill, "fx_11801_base_skill0_02", 0, _actor.tsTransform.Position, _actor.tsTransform.Forward);
	}

	protected void OnComboLoop()
	{
		FP distance = _moveSpeed * _checkInterval;
		ILRuntimeAPI.SearchByRange(_actor, _phase1CheckRange, (List<LogicEntity> result) =>
		{
			if (result.Count > 0)
			{
				CommomAreaHitConfig commonAreaHitConfig = new CommomAreaHitConfig
				{
					hitDamageId = _hitDamageId
				};
				ILRuntimeAPI.HitActors(_actor, result, commonAreaHitConfig);
				ILRuntimeAPI.ForceMoveByDistance(_actor, result, distance, _moveSpeed, isCoExist: true, isChangeForward: true, _moveLevel, _strength, isPull: true);
				for (int i = 0; i < result.Count; i++)
				{
					result.get_Item(i).GetComponent<AdventureActor>()?.buffComponent?.AddBuff(_buffId, _actor);
				}
			}
		}, isConfront: true);
		_attackCount++;
		if (_attackCount >= _attckTotalCount)
		{
			_comboAttack.CancelAttack();
		}
	}

	protected IEnumerator AttackPhase1()
	{
		int totalCount = (int)(long)(_checkDuration / _checkInterval);
		int count = 0;
		FP distance = _moveSpeed * _checkInterval;
		while (count < totalCount)
		{
			ILRuntimeAPI.SearchByRange(_actor, _phase1CheckRange, (List<LogicEntity> result) =>
			{
				if (result.Count > 0)
				{
					CommomAreaHitConfig commonAreaHitConfig = new CommomAreaHitConfig
					{
						hitDamageId = _hitDamageId
					};
					ILRuntimeAPI.HitActors(_actor, result, commonAreaHitConfig);
					ILRuntimeAPI.ForceMoveByDistance(_actor, result, distance, _moveSpeed, isCoExist: true, isChangeForward: true, _moveLevel, _strength, isPull: true);
					for (int i = 0; i < result.Count; i++)
					{
						result.get_Item(i).GetComponent<AdventureActor>()?.buffComponent?.AddBuff(_buffId, _actor);
					}
				}
			}, isConfront: true);
			count++;
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_checkInterval));
		}
		_comboAttack.CancelAttack();
	}

	protected virtual void OnFinish()
	{
		NovaLogger.Debug("11801 Skill_Ultra onFinish");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("11801 Skill_Ultra OnInterrupt");
		_skill.Clear();
	}

	protected void Clear()
	{
		_actor.DisableImmuneControl();
	}
}
