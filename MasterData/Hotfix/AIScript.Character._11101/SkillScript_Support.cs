using System;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11101;

public class SkillScript_Support : SkillAdvancedBase
{
	private string key = "B2_Skill";

	private string key_P3 = "B2P23_Skill";

	private string evt_area = "Add_Area";

	private string evt_area_p3 = "Add_P23Area";

	private FP aoe_offset = 3;

	private int evt_CastArea = CommonHelper.StringToHash("CastArea");

	private Dictionary<int, string> dicArea = new Dictionary<int, string>
	{
		[0] = "AreaEffect_11101_B2_Skill_IceWave",
		[8] = "AreaEffect_11101_B2P21_IceWave_Large",
		[4] = "AreaEffect_11101_B2P22_IceWave_Vortex",
		[2] = "AreaEffect_11101_B2P24_IceWave_Follow",
		[1] = "AreaEffect_11101_B2P25_IceWave_Quick",
		[12] = "AreaEffect_11101_B2P21P22_IceWave_LargeVortex",
		[10] = "AreaEffect_11101_B2P21P24_IceWave_LargeFollow",
		[9] = "AreaEffect_11101_B2P21P25_IceWave_LargeQuick",
		[6] = "AreaEffect_11101_B2P22P24_IceWave_VortexFollow",
		[5] = "AreaEffect_11101_B2P22P25_IceWave_VortexQuick",
		[3] = "AreaEffect_11101_B2P24P25_IceWave_FollowQuick",
		[14] = "Area_P124",
		[13] = "AreaEffect_11101_B2P21P22P25_IceWave_LargeVortexQuick",
		[11] = "AreaEffect_11101_B2P21P24P25_IceWave_LargeFollowQuick",
		[7] = "AreaEffect_11101_B2P22P24P25_IceWave_VortexFollowQuick"
	};

	private const int perkId_1 = 511121;

	private const int perkId_2 = 511122;

	private const int perkId_3 = 511123;

	private const int perkId_5 = 511125;

	private const int perkId_6 = 511126;

	private const int parameterId_6 = 11152611;

	private const int perkId_8 = 511128;

	private int count_8 = 3;

	private const int buff_8 = 11152811;

	private const int perkId_10 = 511130;

	private const int buff_10 = 11153011;

	private CoroutineNode corMain;

	private List<LogicEntity> targets = new List<LogicEntity>();

	private TSVector2 targetPos;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		targetPos = TSVector2.zero;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
		targets.Clear();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	private void SkillFinish()
	{
		_skill?.Clear();
	}

	private void SkillInterrupt()
	{
		_skill?.Clear();
	}

	private void DoMainLogic()
	{
		if (GetPerkLv(511123, out var _))
		{
			key = key_P3;
		}
		LogicEntity assistantAttackTarget = CommonUtils.GetAssistantAttackTarget(_actor);
		string actionTag = key;
		Action<string> action = onCustomEvent;
		Action onComboFinish = SkillFinish;
		Action onInterrupt = SkillInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, assistantAttackTarget, null, default, null, null, onComboFinish, onInterrupt, action);
	}

	private void onCustomEvent(string evt)
	{
		int lv;
		if (evt.Equals(evt_area_p3))
		{
			LogicEntity assistantAttackTarget = CommonUtils.GetAssistantAttackTarget(_actor);
			if (targetPos == TSVector2.zero)
			{
				targetPos = ((assistantAttackTarget != null) ? assistantAttackTarget.tsTransform.Position : (_actor.tsTransform.Position + _actor.tsTransform.Forward * aoe_offset));
			}
			if (GetPerkLv(511123, out lv))
			{
				AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
				adventureActorCustomEvent.eventHashCode = evt_CastArea;
				adventureActorCustomEvent.tsVector2ParamList = new List<TSVector2> { targetPos };
				_actor.DispatchEvent(adventureActorCustomEvent);
			}
		}
		else
		{
			if (!evt.Equals(evt_area))
			{
				return;
			}
			LogicEntity assistantAttackTarget2 = CommonUtils.GetAssistantAttackTarget(_actor);
			if (targetPos == TSVector2.zero)
			{
				targetPos = ((assistantAttackTarget2 != null) ? assistantAttackTarget2.tsTransform.Position : (_actor.tsTransform.Position + _actor.tsTransform.Forward * aoe_offset));
			}
			int num = (GetPerkLv(511121, out lv) ? 8 : 0);
			int num2 = (GetPerkLv(511122, out lv) ? 4 : 0);
			int num3 = (GetPerkLv(511125, out lv) ? 1 : 0);
			int num4 = num | num2 | num3;
			long id = ILRuntimeAPI.PlayAreaEffect(_actor, dicArea.get_Item(num4), targetPos, _actor.tsTransform.Rotation, (AreaEffectEntity area) =>
			{
				area.ModifyTag(ParallelScript_Support.areaTag);
			});
			AreaEffectEntity areaEffect = ILRuntimeAPI.GetAreaEffect(id);
			if (GetPerkLv(511126, out var lv2))
			{
				ILRuntimeAPI.AddAreaEffectLeftTime(id, CommonUtils.GetScriptValue(_actor, 11152611));
			}
			if (GetPerkLv(511128, out lv2))
			{
				FP hitBoxRadius = areaEffect.hitBoxRadius;
				CommonUtils.SearchNearTargetsByCircle(_actor, areaEffect.tsTransform.Position, hitBoxRadius, isConfront: true, includeSelf: false, targets);
				if (targets != null && targets.Count < count_8)
				{
					for (int num5 = 0; num5 < targets.Count; num5++)
					{
						(targets.get_Item(num5) as AdventureActor)?.buffComponent.AddBuff(11152811, _actor);
					}
				}
			}
			if (GetPerkLv(511130, out lv2))
			{
				AreaEffect_BuffComponent areaEffectComponent = ILRuntimeAPI.GetAreaEffectComponent<AreaEffect_BuffComponent>(id);
				if (areaEffectComponent != null)
				{
					areaEffectComponent.addBuffIdList = new List<int> { 11153011 };
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
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
