using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15001;

public class SkillScript_Skill_Support : SkillAdvancedBase
{
	private Queue<TSVector2> _attackPositionQueue;

	private CoroutineNode _loopAttackCor;

	private HashSet<long> _lockedSet_P24;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515029, out var _))
		{
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(15029011);
			_actor.logicVariable.SetLogicTagValue("AdditionalAttrCount_P29", buffNumByID);
			_actor.buffComponent.RemoveBuffByBuffId(15029011);
		}
		DefaultLookAt();
	}

	public void OnStart()
	{
		string text = "150_Support_Skill";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515028, out var _))
		{
			text = "150_Support_Skill_Strengthen";
		}
		string actionTag = text;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt);
	}

	private void OnAnticipationEnd()
	{
		if (_loopAttackCor != null)
		{
			_actor.StopLogicCoroutine(_loopAttackCor);
		}
		_loopAttackCor = _actor.StartLogicCoroutine(LoopAttackLogic());
	}

	private IEnumerator LoopAttackLogic()
	{
		bool flag = CommonUtils.HavePersonalPerk(_actor.dataID, 515021, out var perkLevel);
		bool flag2 = CommonUtils.HavePersonalPerk(_actor.dataID, 515022, out perkLevel);
		bool flag3 = CommonUtils.HavePersonalPerk(_actor.dataID, 515023, out perkLevel);
		bool havePerk_24 = CommonUtils.HavePersonalPerk(_actor.dataID, 515024, out perkLevel);
		bool havePerk_27 = CommonUtils.HavePersonalPerk(_actor.dataID, 515027, out perkLevel);
		FP duration = Config_Support.loopAttackTime_Skill;
		int maxAreaEffectCount = 4;
		FP generateInterval = Config_Support.generateInterval_AreaEffect_Skill;
		if (flag2)
		{
			duration = (flag ? Config_Support.loopAttackTime_Skill_P21_P22 : Config_Support.loopAttackTime_Skill_P22);
			maxAreaEffectCount = 6;
			generateInterval = Config_Support.generateInterval_AreaEffect_Skill_P22;
		}
		string areaEffectKey = "AreaEffect_150_Support_Skill_Boom";
		string extraAreaEffectKey = null;
		if (flag)
		{
			areaEffectKey = (flag3 ? "AreaEffect_150_Support_Skill_P23P21_Jet_Big" : "AreaEffect_150_Support_Skill_P21_Jet");
			extraAreaEffectKey = (flag3 ? "AreaEffect_150_Support_Skill_P23P21_Jet_Center" : null);
		}
		else if (flag3)
		{
			areaEffectKey = "AreaEffect_150_Support_Skill_P23_Boom_Big";
			extraAreaEffectKey = "AreaEffect_150_Support_Skill_P23_Boom_Center";
		}
		GenerateAttackPosition(maxAreaEffectCount);
		int i = 0;
		while (i < maxAreaEffectCount)
		{
			TSVector2 attackPosition = GetAttackPosition(havePerk_24);
			if (!string.IsNullOrEmpty(areaEffectKey))
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectKey, attackPosition, default, (AreaEffectEntity areaEffectEntity) =>
				{
					AreaEffect_AttackComponent areaEffectComponent = areaEffectEntity.GetAreaEffectComponent<AreaEffect_AttackComponent>();
					if (areaEffectComponent != null && areaEffectComponent.hitFeatureData != null)
					{
						areaEffectComponent.hitFlags = (havePerk_27 ? (HitBox.FeatureFlag.AirBorne | HitBox.FeatureFlag.Stiff) : HitBox.FeatureFlag.Stiff);
						areaEffectComponent.hitFeatureData.hitStrenth = (havePerk_27 ? Config_Support.hitStrength_AreaEffect_Skill_P27 : Config_Support.hitStrength_AreaEffect_Skill);
					}
				});
			}
			if (!string.IsNullOrEmpty(extraAreaEffectKey))
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, extraAreaEffectKey, attackPosition, default, (AreaEffectEntity areaEffectEntity) =>
				{
					AreaEffect_AttackComponent areaEffectComponent = areaEffectEntity.GetAreaEffectComponent<AreaEffect_AttackComponent>();
					if (areaEffectComponent != null && areaEffectComponent.hitFeatureData != null)
					{
						areaEffectComponent.hitFlags = (havePerk_27 ? (HitBox.FeatureFlag.AirBorne | HitBox.FeatureFlag.Stiff) : HitBox.FeatureFlag.Stiff);
						areaEffectComponent.hitFeatureData.hitStrenth = (havePerk_27 ? Config_Support.hitStrength_AreaEffect_Skill_P27 : Config_Support.hitStrength_AreaEffect_Skill);
					}
				});
			}
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(generateInterval));
			perkLevel = i++;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515025, out perkLevel))
		{
			TSVector2 position = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.tsTransform.Position;
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_150_Support_Skill_P25_LightRain", position);
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_150_Support_Skill_P25_LightRain_Ground", position);
		}
		FP fP = duration - maxAreaEffectCount * generateInterval;
		if (fP > 0)
		{
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(fP));
		}
		comboAttack.CancelAttack();
	}

	private void GenerateAttackPosition(int maxAreaEffectCount)
	{
		if (_attackPositionQueue == null)
		{
			_attackPositionQueue = new Queue<TSVector2>();
		}
		else
		{
			_attackPositionQueue.Clear();
		}
		if (maxAreaEffectCount <= 0)
		{
			return;
		}
		FP fP = (FP)360 / (FP)maxAreaEffectCount;
		TSVector2 forward = _actor.tsTransform.Forward;
		DeterministicShape shape = new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Fan,
			innerRadius = Config_Support.randomPositionInnerRadius_Skill,
			radius = Config_Support.randomPositionOuterRadius_Skill,
			angle = fP
		};
		for (int i = 0; i < maxAreaEffectCount; i++)
		{
			FP fP2 = -fP * i;
			TSVector2 v = forward;
			if (fP2 != 0)
			{
				v = TSVector2.Rotate(v, fP2);
			}
			shape.position = _actor.tsTransform.Position;
			shape.rotation = v.GetAngle();
			_attackPositionQueue.Enqueue(ILRuntimeAPI.GetRandomPointInShape(_actor, shape, isReachable: false));
		}
	}

	private TSVector2 GetAttackPosition(bool havePerk_24)
	{
		if (havePerk_24)
		{
			LogicEntity target = null;
			ILRuntimeAPI.SearchByRange(_actor, Config_Support.searchRadius_P24, (List<LogicEntity> result) =>
			{
				if (result.Count > 0)
				{
					if (_lockedSet_P24 == null)
					{
						_lockedSet_P24 = new HashSet<long>();
					}
					for (int i = 0; i < result.Count; i++)
					{
						if (_lockedSet_P24.Add(result.get_Item(i).Id))
						{
							target = result.get_Item(i);
							break;
						}
					}
					if (target == null)
					{
						target = result.get_Item(TSRandom.Range(0, result.Count));
					}
				}
			}, isConfront: true);
			if (target != null)
			{
				return target.tsTransform.Position;
			}
			if (_attackPositionQueue != null && _attackPositionQueue.Count > 0)
			{
				return _attackPositionQueue.Dequeue();
			}
			return _actor.tsTransform.Position;
		}
		if (_attackPositionQueue != null && _attackPositionQueue.Count > 0)
		{
			return _attackPositionQueue.Dequeue();
		}
		return _actor.tsTransform.Position;
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
		_attackPositionQueue?.Clear();
		if (_loopAttackCor != null)
		{
			_actor.StopLogicCoroutine(_loopAttackCor);
		}
		_loopAttackCor = null;
		_lockedSet_P24?.Clear();
	}
}
