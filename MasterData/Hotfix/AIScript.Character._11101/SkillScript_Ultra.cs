using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11101;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private string evt_aoe_A = "add_Area";

	private string evt_aoe_B = "add_Area_FX";

	private string evt_aoe_C = "add_Area_Hit";

	private string aoe_A = "AreaEffect_11101_Ultra_H6";

	private string aoe_B = "AreaEffect_11101_Ultra_H6_FX";

	private string aoe_C = "AreaEffect_11101_Ultra_H6_Hit";

	private FP baseLoopTime = 5;

	private string key_1 = "Ultra_TL";

	private string key_2 = "Ultra_TL_H6";

	private string key_3 = "Ultra_NoTL";

	private string key_4 = "Ultra_NoTL_H6";

	private FP addTime_fate6 = 5;

	private FP baseTime = 5;

	private FP traceStopDis = 2;

	private const int perkId_1 = 511143;

	private const int buff_1 = 11154311;

	private CoroutineNode corMain;

	private CoroutineNode corSupport;

	private string actionKey;

	private bool loop;

	private FP addLoopTime;

	private PlayTimeline _playTimeline = new PlayTimeline();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		addLoopTime = 0;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Clear();
	}

	public void OnStart()
	{
		if ((_actor as PlayerAdventureActor).isAssist)
		{
			DoSupportSkill();
		}
		else
		{
			DoMainSkill();
		}
	}

	protected void onFinishOrInterrupt()
	{
		_skill.Clear();
	}

	private void Clear()
	{
		StopCoroutine(ref corMain);
		StopCoroutine(ref corSupport);
	}

	private void DoMainSkill()
	{
		_playTimeline.Play(_actor, () =>
		{
			ParseKey(timeline: true);
			StartCoroutine(ref corMain, DoMainLogic());
		}, () =>
		{
			ParseKey(timeline: false);
			StartCoroutine(ref corMain, DoMainLogic());
		});
	}

	private void ParseKey(bool timeline)
	{
		if (timeline)
		{
			actionKey = key_1;
		}
		else
		{
			actionKey = key_3;
		}
	}

	private IEnumerator DoMainLogic()
	{
		loop = true;
		SkillScript_Ultra skillScript_Ultra = this;
		string actionTag = actionKey;
		Action<string> action = onCustomEvent;
		Action onComboFinish = onFinishOrInterrupt;
		Action onInterrupt = onFinishOrInterrupt;
		RequestComboAttack req = skillScript_Ultra.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
		if (loop)
		{
			while (!req.isAnticipationEnd)
			{
				yield return null;
			}
			FP curTime = 0;
			while (curTime < baseLoopTime + addLoopTime)
			{
				curTime += _actor.LogicDeltaTime;
				yield return null;
			}
			_actor.CancelAttack();
		}
	}

	private void DoSupportSkill()
	{
		_playTimeline.Play(_actor, () =>
		{
			ParseKey(timeline: true);
			StartCoroutine(ref corSupport, DoSupportLogic());
		}, () =>
		{
			ParseKey(timeline: false);
			StartCoroutine(ref corSupport, DoSupportLogic());
		});
	}

	private IEnumerator DoSupportLogic()
	{
		loop = true;
		SkillScript_Ultra skillScript_Ultra = this;
		string actionTag = actionKey;
		Action<string> action = onCustomEvent;
		Action onInterrupt = onFinishOrInterrupt;
		Action onComboFinish = onFinishOrInterrupt;
		RequestComboAttack req = skillScript_Ultra.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
		if (!loop)
		{
			yield break;
		}
		while (!req.isAnticipationEnd)
		{
			yield return null;
		}
		FP dTime = 0;
		while (true)
		{
			LogicEntity assistantAttackTarget = CommonUtils.GetAssistantAttackTarget(_actor);
			if (assistantAttackTarget != null)
			{
				_actor.TrackMove(assistantAttackTarget, traceStopDis, enableNavigation: false, NavAgentTypeNames.NavigationUpdateQualityLevel.LowQualityNavigationUpdate, AdventureActor.MovementMode.Walk);
			}
			if (dTime > baseTime)
			{
				break;
			}
			dTime += _actor.LogicDeltaTime;
			yield return null;
		}
		_actor.CancelAttack();
		_actor.StandBy();
	}

	private void onCustomEvent(string eventName)
	{
		if (eventName.Equals(evt_aoe_A))
		{
			long id = ILRuntimeAPI.PlayAreaEffect(_actor, aoe_A, default, default, (AreaEffectEntity area) =>
			{
				area.ModifyTag(ParallelScript.areaTag_A);
			});
			if (GetPerkLv(511143, out var _))
			{
				AreaEffect_BuffComponent areaEffectComponent = ILRuntimeAPI.GetAreaEffectComponent<AreaEffect_BuffComponent>(id);
				if (areaEffectComponent != null)
				{
					areaEffectComponent.addBuffIdList = new List<int> { 11154311 };
					areaEffectComponent.triggerEnter = true;
					areaEffectComponent.triggerEnterCriteriaInfo = new TargetFilterCriteriaInfo
					{
						filterCriteriaList = new List<TargetFilterCriteriaInfo.TargetFilterCriteria>
						{
							new TargetFilterCriteriaInfo.TargetFilterCriteria
							{
								targetType = TargetFilterCriteriaInfo.TargetTypeMapping.Friend
							}
						}
					};
				}
			}
		}
		else if (eventName.Equals(evt_aoe_B))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, aoe_B, default, default, (AreaEffectEntity area) =>
			{
				area.ModifyTag(ParallelScript.areaTag_B);
			});
		}
		else if (eventName.Equals(evt_aoe_C))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, aoe_C, default, default, (AreaEffectEntity area) =>
			{
				area.ModifyTag(ParallelScript.areaTag_C);
			});
		}
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
