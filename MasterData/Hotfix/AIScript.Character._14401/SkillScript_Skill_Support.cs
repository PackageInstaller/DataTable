using System;
using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14401;

public class SkillScript_Skill_Support : SkillAdvancedBase
{
	private int _totalAttackTimes;

	private int _attackTimes;

	private bool _beforeAttackActivation;

	private string _attackAreaEffectKey;

	private PlayFX _playFX;

	private CoroutineNode _attackIntervalCor;

	private CoroutineNode _summonCor;

	private bool _canTrigger_P22;

	private CoroutineNode _perkLogicCor_P23;

	private FP _lastTriggerTime_P25;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_attackTimes = 0;
		_totalAttackTimes = 3;
		_beforeAttackActivation = false;
		_attackAreaEffectKey = null;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514421, out var perkLevel))
		{
			_totalAttackTimes += 2;
		}
		_actor.logicVariable.SetLogicTagValue("SkillAttackTimes", 0);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514423, out perkLevel))
		{
			_perkLogicCor_P23 = _actor.StartLogicCoroutine(PerkLogic_P23());
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514427, out perkLevel))
		{
			_totalAttackTimes++;
		}
		UpdateAttackTarget();
		DefaultLookAt();
	}

	public void OnStart()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("144_B2_Start", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, () =>
		{
			Attack();
		});
		_actor.ReplaceAnimationGroup();
		_summonCor = _actor.StartLogicCoroutine(Summon());
	}

	private void UpdateAttackTarget()
	{
		if (!CheckTargetIegal())
		{
			_actor.attackTarget = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor?.attackTarget;
			if (!CheckTargetIegal())
			{
				_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: false, dontLostTarget: false, sortByAngle: true);
			}
		}
	}

	private bool CheckTargetIegal()
	{
		if (_actor.attackTarget == null)
		{
			return false;
		}
		if (_actor.attackTarget.IsDead())
		{
			return false;
		}
		if (_actor.attackTarget.IsSearchedImmunity())
		{
			return false;
		}
		return _actor.DistanceWithRadius(_actor.attackTarget) <= _actor.actorSearchTargetInfo.hearAttackRange;
	}

	private IEnumerator Summon()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Config_Support.delayTime_Summon_Skill));
		for (int i = 0; i < 3; i++)
		{
			TSVector2 tSVector = Config_Support.summonOffsetList_Skill.get_Item(TSRandom.Range(0, Config_Support.summonOffsetList_Skill.Count));
			TSVector2 result = _actor.tsTransform.Position + _actor.tsTransform.Left * tSVector.x + _actor.tsTransform.Forward * tSVector.y;
			if (!_actor.QueryPositionWalkable(result))
			{
				_actor.QueryClosestPositionWalkable(result, out result);
			}
			TSVector2 dir = ((_actor.attackTarget != null) ? (_actor.attackTarget.tsTransform.Position - result).normalized : _actor.tsTransform.Forward);
			if (!Config.replaceMonsterIdDic_Summon_ForSkin.TryGetValue(_actor.skinID, out var value))
			{
				value = 14401111;
			}
			ILRuntimeAPI.SummonMonster(_actor, 0, value, result, dir, Config.summonCfg_Summon, null, (MonsterAdventureActor summoned) =>
			{
				summoned.logicVariable.SetLogicTagStringValue("SpawnFx_Summon", "fx_14401_base_B2_Skill_chuxian");
				summoned.logicVariable.SetLogicTagValue("DelayUseSkillTime_Summon", Config_Support.summonedDelayUseSkillTime_Skill);
				summoned.logicVariable.SetLogicTagStringValue("SkillComboTag_Summon", "144_B2_Shadow_Atk");
				summoned.logicVariable.ToggleLogicTag("CloseBlock_Summon", value: true);
				summoned.attackTarget = _actor.attackTarget;
				summoned.logicVariable.ToggleLogicTag("SummonFinish_Summon", value: true);
			});
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Config_Support.summonInterval_Skill));
		}
	}

	private void Attack(bool interruptAttack = false)
	{
		_attackTimes++;
		_beforeAttackActivation = true;
		_canTrigger_P22 = false;
		_attackAreaEffectKey = "AreaEffect_14401_B2_Skill_MomentarySlash";
		UpdateAttackTarget();
		bool forceInterruptAttack = interruptAttack;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onActivationEnd = OnAttackActivationEnd;
		Action onInterrupt = OnInterrupt;
		BeginAttack("144_B2_Attack", flushInputedKeys: true, forceInterruptAttack, autoLookAtTarget: false, null, null, default, null, null, null, onInterrupt, onCustomEvent, onActivationEnd);
		int num = _actor.logicVariable.GetLogicTagValue("SkillAttackTimes").AsInt();
		_actor.logicVariable.SetLogicTagValue("SkillAttackTimes", num + 1);
		if (_attackTimes < _totalAttackTimes)
		{
			if (_attackIntervalCor != null)
			{
				_actor.StopLogicCoroutine(_attackIntervalCor);
			}
			_attackIntervalCor = _actor.StartLogicCoroutine(AttackInterval());
		}
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "144_B2_Atmos"))
		{
			if (_playFX == null || !_playFX.isPlaying)
			{
				_playFX = new PlayFX();
				_playFX.Play(_actor, _skill, "fx_14401_base_B2_Skill_badao", default, _actor.tsTransform.Position, default);
			}
		}
		else if (string.Equals(eventName, "144_B2_MomentarySlash"))
		{
			if (!string.IsNullOrEmpty(_attackAreaEffectKey))
			{
				TSVector2 position = _actor.tsTransform.Position;
				if (_actor.attackTarget != null)
				{
					position = _actor.attackTarget.tsTransform.Position;
				}
				else if (SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor is PlayerAdventureActor playerAdventureActor && playerAdventureActor.attackTarget != null)
				{
					position = playerAdventureActor.attackTarget.tsTransform.Position;
				}
				else
				{
					position += _actor.tsTransform.Forward * Config_Support.areaEffectOffset_NoTarget_Skill;
				}
				ILRuntimeAPI.PlayAreaEffect(_actor, _attackAreaEffectKey, position);
			}
		}
		else if (string.Equals(eventName, "144_B2_AtmosClear"))
		{
			_playFX?.Stop();
			_playFX?.Clear();
		}
	}

	private void OnAttackActivationEnd()
	{
		_beforeAttackActivation = false;
		if (_canTrigger_P22)
		{
			_attackAreaEffectKey = "AreaEffect_14401_B2P22_Skill_MomentarySlash";
			if (_attackTimes >= _totalAttackTimes)
			{
				Action<string> onCustomEvent = OnCustomEvent;
				Action onActivationEnd = EndAttack;
				Action onInterrupt = OnInterrupt;
				BeginAttack("144_B2_Attack", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onInterrupt, onCustomEvent, onActivationEnd);
			}
			else
			{
				Action<string> onCustomEvent = OnCustomEvent;
				Action onInterrupt = OnInterrupt;
				BeginAttack("144_B2_Attack", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onInterrupt, onCustomEvent);
			}
			int num = _actor.logicVariable.GetLogicTagValue("SkillAttackTimes").AsInt();
			_actor.logicVariable.SetLogicTagValue("SkillAttackTimes", num + 1);
			_canTrigger_P22 = false;
		}
		else if (_attackTimes >= _totalAttackTimes)
		{
			EndAttack();
		}
	}

	private IEnumerator AttackInterval()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Config_Support.attackInterval_Skill));
		Attack(interruptAttack: true);
	}

	protected override void OnReceiveDamage(IEvent evt)
	{
		base.OnReceiveDamage(evt);
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (!(adventureActorReceiveDamageEvent.from == _actor) || !(adventureActorReceiveDamageEvent.to is MonsterAdventureActor))
		{
			return;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514422, out var perkLevel) && _beforeAttackActivation && !_canTrigger_P22)
		{
			_canTrigger_P22 = adventureActorReceiveDamageEvent.isCrit && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P22);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514425, out perkLevel))
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, 14425011);
			if ((_lastTriggerTime_P25 <= 0 || _actor.LogicTime - _lastTriggerTime_P25 > scriptValue) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P25))
			{
				_actor.buffComponent.AddBuff(14425011, _actor);
				_lastTriggerTime_P25 = _actor.LogicTime;
			}
		}
	}

	private void EndAttack()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("144_B2_Connect", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		_actor.ResumeAnimationGroup();
	}

	private IEnumerator PerkLogic_P23()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Config_Support.summonDelay_P23));
		for (int groupIndex = 0; groupIndex < 3; groupIndex++)
		{
			for (int memberIndex = 0; memberIndex < 2; memberIndex++)
			{
				AdventureActor adventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as AdventureActor;
				if (adventureActor != null)
				{
					TSVector2 tSVector = adventureActor.tsTransform.Position + adventureActor.tsTransform.Forward * Config_Support.summoneOffset_NoTarget_P23;
					TSVector2 dir = adventureActor.tsTransform.Forward;
					LogicEntity target = adventureActor.attackTarget ?? ILRuntimeAPI.GetTargetNearByRange(adventureActor, Config_Support.searchRadius_NoTarget_P23);
					if (target != null)
					{
						FP radius = target.GetRadius();
						DeterministicShape shape = new DeterministicShape
						{
							shapeType = DeterministicShape.ShapeType.Fan,
							position = target.tsTransform.Position,
							rotation = target.tsTransform.Rotation,
							innerRadius = radius + Config_Support.summonInnerRadius_P23,
							radius = radius + Config_Support.summonOuterRadius_P23,
							angle = Config_Support.summonAngle_P23
						};
						tSVector = ILRuntimeAPI.GetRandomPointInShape(_actor, shape);
						dir = (target.tsTransform.Position - tSVector).normalized;
					}
					if (!Config.replaceMonsterIdDic_Summon_ForSkin.TryGetValue(_actor.skinID, out var value))
					{
						value = 14401111;
					}
					ILRuntimeAPI.SummonMonster(_actor, 0, value, tSVector, dir, Config.summonCfg_Summon, null, (MonsterAdventureActor summoned) =>
					{
						summoned.logicVariable.SetLogicTagStringValue("SpawnFx_Summon", "fx_14401_base_B2_Skill_chuxian");
						summoned.logicVariable.SetLogicTagValue("DelayUseSkillTime_Summon", Config_Support.summonedDelayUseSkillTime_Skill);
						summoned.logicVariable.SetLogicTagStringValue("SkillComboTag_Summon", "144_B2P23_Shadow_Atk");
						summoned.logicVariable.ToggleLogicTag("CloseBlock_Summon", value: true);
						summoned.attackTarget = target;
						summoned.logicVariable.ToggleLogicTag("SummonFinish_Summon", value: true);
					});
				}
				if (memberIndex + 1 < 2)
				{
					yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Config_Support.summonInterval_EveryMember_P23));
				}
			}
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Config_Support.summonInterval_EveryGroup_P23));
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
		_attackAreaEffectKey = null;
		_playFX?.Stop();
		_playFX?.Clear();
		if (_summonCor != null)
		{
			_actor.StopLogicCoroutine(_summonCor);
		}
		_summonCor = null;
		if (_attackIntervalCor != null)
		{
			_actor.StopLogicCoroutine(_attackIntervalCor);
		}
		_attackIntervalCor = null;
		if (_perkLogicCor_P23 != null)
		{
			_actor.StopLogicCoroutine(_perkLogicCor_P23);
		}
		_perkLogicCor_P23 = null;
		_actor.buffComponent.RemoveBuffByBuffId(14425011);
		_lastTriggerTime_P25 = 0;
		_actor.ResumeAnimationGroup();
		_attackTimes = 0;
	}
}
