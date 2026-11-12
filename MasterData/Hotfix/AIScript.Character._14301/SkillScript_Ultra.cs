#define LOG_ERROR
using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14301;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private PlayTimeline _playTimeline;

	private long _mainAreaEffectId;

	private PlayFX _playFX;

	private int _loopAttackIndex;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
		_actor.EnableSuperArmor();
		_actor.EnableImmuneControl();
		_actor.EnableCloseBlock();
		_loopAttackIndex = 0;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514342, out var _))
		{
			_actor.buffComponent.AddBuff(14342011, _actor);
		}
		DefaultLookAt();
	}

	public void OnStart()
	{
		if (_playTimeline == null)
		{
			_playTimeline = new PlayTimeline();
		}
		_playTimeline.Play(_actor, OnPlayTimeLineFinish, OnNotPlayTimeLine);
	}

	private void OnPlayTimeLineFinish()
	{
		string text = "Ultra_TimelineOn_T2";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514341, out var _))
		{
			text = "Ultra_TimelineOn_T2P41";
		}
		string actionTag = text;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action onComboLoop = OnComboLoop;
		Action onRecoveryBegin = OnRecoveryBegin;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, onAnticipationEnd, onRecoveryBegin, onComboFinish, onInterrupt, onCustomEvent, null, fadeOutAnim: false, onComboLoop);
	}

	private void OnNotPlayTimeLine()
	{
		string text = "Ultra_TimelineOff_T2";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514341, out var _))
		{
			text = "Ultra_TimelineOff_T2P41";
		}
		string actionTag = text;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action onComboLoop = OnComboLoop;
		Action onRecoveryBegin = OnRecoveryBegin;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, onAnticipationEnd, onRecoveryBegin, onComboFinish, onInterrupt, onCustomEvent, null, fadeOutAnim: false, onComboLoop);
	}

	private void OnAnticipationEnd()
	{
		_actor.Hide(performanceMode: true);
	}

	private void OnComboLoop()
	{
		_actor.CancelAttack();
	}

	private void OnRecoveryBegin()
	{
		_actor.Visible();
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "WindDomainOpen"))
		{
			GenerateMainAreaEffect();
		}
		else if (string.Equals(eventName, "WindDomainQuickAtk_1"))
		{
			LoopAttack(Config.fxSpeed_UltraSkill_LoopAttack_Low);
		}
		else if (string.Equals(eventName, "WindDomainQuickAtk_2"))
		{
			LoopAttack(Config.fxSpeed_UltraSkill_LoopAttack_Middle);
		}
		else if (string.Equals(eventName, "WindDomainQuickAtk_3"))
		{
			LoopAttack(Config.fxSpeed_UltraSkill_LoopAttack_High);
		}
		else if (string.Equals(eventName, "WindDomainClose"))
		{
			StopMainAreaEffect();
		}
	}

	private void LoopAttack(FP fxSpeed)
	{
		if (_mainAreaEffectId <= 0)
		{
			return;
		}
		AreaEffectEntity mainAreaEffect = ILRuntimeAPI.GetAreaEffect(_mainAreaEffectId);
		if (mainAreaEffect == null)
		{
			return;
		}
		FP radius = mainAreaEffect.GetAreaRadius();
		if (radius <= 0)
		{
			return;
		}
		_loopAttackIndex = TSMath.Clamp(_loopAttackIndex, 0, Config.loopAttackFxKeyList_UltraSkill.Count - 1).AsInt();
		string loopAttackFxKey = Config.loopAttackFxKeyList_UltraSkill.get_Item(_loopAttackIndex);
		ILRuntimeAPI.SearchByRangeAndPosition(_actor, mainAreaEffect.tsTransform.Position, radius, (List<LogicEntity> result) =>
		{
			if (!string.IsNullOrEmpty(loopAttackFxKey))
			{
				TSVector2 position = _actor.tsTransform.Position;
				if (result == null || result.Count <= 0)
				{
					DeterministicShape shape = new DeterministicShape
					{
						shapeType = DeterministicShape.ShapeType.Circle,
						innerRadius = _actor.dtCollider.Radius,
						radius = radius,
						position = mainAreaEffect.tsTransform.Position
					};
					position = ILRuntimeAPI.GetRandomPointInShape(_actor, shape);
				}
				else
				{
					int index = TSRandom.Range(0, result.Count);
					position = result.get_Item(index).tsTransform.Position;
				}
				if (_playFX == null)
				{
					_playFX = new PlayFX();
				}
				else
				{
					_playFX.Clear();
				}
				_playFX.Play(_actor, null, loopAttackFxKey, default, position, default, null, fxSpeed.AsFloat());
				if (!string.IsNullOrEmpty("AreaEffect_143_Ultra_WindDomainQuickAtk"))
				{
					ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_143_Ultra_WindDomainQuickAtk", position);
				}
				else
				{
					NovaLogger.Error("风影(Id:143)大招循环阶段攻击用区域效果未配置");
				}
			}
			else
			{
				NovaLogger.Error($"风影(Id:143)大招循环阶段攻击用特效未配置,索引:{_loopAttackIndex}");
			}
			_loopAttackIndex++;
			_loopAttackIndex = ((_loopAttackIndex < Config.loopAttackFxKeyList_UltraSkill.Count) ? _loopAttackIndex : 0);
		}, isConfront: true);
	}

	private void GenerateMainAreaEffect()
	{
		if (!string.IsNullOrEmpty("AreaEffect_143_Ultra_WindDomain"))
		{
			_mainAreaEffectId = ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_143_Ultra_WindDomain", _actor.tsTransform.Position);
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 514343, out var _))
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_143_Ultra_WindDomain_P43_XiYin", _actor.tsTransform.Position);
			}
		}
	}

	private void StopMainAreaEffect()
	{
		if (_mainAreaEffectId > 0)
		{
			ILRuntimeAPI.StopAreaEffect(_mainAreaEffectId);
			_mainAreaEffectId = 0L;
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
		if (_actor.isHide)
		{
			_actor.Visible();
		}
		_actor.DisableInvincible();
		_actor.DisableSuperArmor();
		_actor.DisableImmuneControl();
		_actor.DisableCloseBlock();
		StopMainAreaEffect();
		_playFX?.Clear();
		_loopAttackIndex = 0;
	}
}
