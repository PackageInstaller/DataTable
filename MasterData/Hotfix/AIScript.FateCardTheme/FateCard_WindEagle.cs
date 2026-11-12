#define LOG_DEBUG
#define LOG_ERROR
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.FateCardTheme;

public class FateCard_WindEagle : BaseFateCardTheme
{
	private const int hitDamageId = 986071;

	private readonly FP cd = 3;

	private readonly FP searchTargetRadius = 7;

	private readonly FP duration_AreaEffect = 1.45;

	private readonly FP hitDelay = 0.4;

	private readonly FP hitTimes_Base = 3;

	private const string areaEffectPath_Base = "FateCard_WindEagle";

	private const string fxPath_AreaTrigger = "wind_sickleweasel_atk_1";

	private static readonly int damageTag_WindEagle = CommonHelper.StringToHash("WindEagle");

	private readonly FP hitRadius_14 = 1.5;

	private const int hitDamageId_14 = 986072;

	private const string hitFxPath_14 = "wind_sickleweasel_14_lv1";

	private const string hittedFxPath_14 = "hit_wind_magic";

	private const string areaEffectPath_Base_Task_2 = "FateCard_WindEagle_17";

	private readonly FP duration_AreaEffect_B = 2.2;

	private readonly FP hitDelay_Task_2 = 1.95;

	private const int hitDamageId_Task_2 = 986073;

	private const string hittedFxPath_Task_2 = "hit_wind_magic";

	private readonly FP pullMoveSpeed_Task_2 = 10;

	private const int pullMoveLevel_Task_2 = 99;

	private readonly FP pullStrenth_Task_2 = 4;

	private static readonly int damageTag_Task_2 = CommonHelper.StringToHash("WindEagle_Task_2");

	private readonly Dictionary<int, int> additionalAttrIdDic_Task_2 = new Dictionary<int, int>
	{
		[0] = 50,
		[1] = 50,
		[2] = 50,
		[3] = 45,
		[4] = 40,
		[5] = 35,
		[6] = 30,
		[7] = 20,
		[8] = 10,
		[9] = 0
	};

	private PlayFX _playFX;

	private CommomAreaHitConfig _areaHitConfig;

	private HashSet<long> _triggerSet_14;

	private List<FP> _pullDistanceList;

	public override void OnEnable()
	{
		NovaLogger.Debug("FateCard_WindEagle OnEnable");
		base.OnEnable();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_triggerSet_14?.Clear();
	}

	protected override void OnTrigger()
	{
		NovaLogger.Debug("FateCard_WindEagle OnTrigger");
		if (CheckTimeout(cd))
		{
			GenerateWindEagle(986071);
			TriggerTheme();
		}
	}

	private bool GenerateWindEagle(int hitDamageId)
	{
		LogicEntity target = _actor.attackTarget ?? CommonUtils.SearchNearTargetByCircle(_actor, searchTargetRadius);
		if (target == null)
		{
			return false;
		}
		string windEaglgPrefabPath = GetWindEaglgPrefabPath();
		if (ILRuntimeAPI.PlayAreaEffect(_actor, windEaglgPrefabPath, target.tsTransform.Position, default, (AreaEffectEntity areaEffect) =>
		{
			if (areaEffect != null)
			{
				FP fP = (areaEffect.duration = (CanExcuteB ? duration_AreaEffect_B : duration_AreaEffect));
				AreaEffect_AttackComponent logicComponent = areaEffect.GetLogicComponent<AreaEffect_AttackComponent>();
				if (logicComponent != null)
				{
					logicComponent.hitDamageId = hitDamageId;
					logicComponent.hitDelay = hitDelay;
					logicComponent.damageImmuneDuration = -1;
					FP fP2 = fP - hitDelay;
					if (hitTimes_Base > 0)
					{
						logicComponent.hitInterval = fP2 / hitTimes_Base;
					}
					else
					{
						NovaLogger.Error("风鹰基础攻击次数配置有误");
					}
				}
				if (CanExcuteB)
				{
					StartLogicCoroutine(AreaHit_PerkTask2(_actor, target.tsTransform.Position, areaEffect.hitBoxRadius));
				}
			}
		}) <= 0)
		{
			return false;
		}
		string text = "wind_sickleweasel_atk_1";
		if (!string.IsNullOrEmpty(text))
		{
			if (_playFX == null)
			{
				_playFX = new PlayFX();
			}
			else
			{
				_playFX.Clear();
			}
			_playFX.Play(_actor, null, text, default, target.tsTransform.Position, default);
			_playFX.Clear();
		}
		return true;
	}

	protected override void OnHitPost(AdventureActorReceiveDamageEvent _evt)
	{
		base.OnHitPost(_evt);
		MonsterAdventureActor monsterAdventureActor = _evt.to as MonsterAdventureActor;
		if (monsterAdventureActor != null && CommonUtils.CheckHitByTag(_evt.hitDamageTag, damageTag_WindEagle) && CanExcuteA)
		{
			if (_triggerSet_14 == null)
			{
				_triggerSet_14 = new HashSet<long>();
			}
			_triggerSet_14.Add(monsterAdventureActor.Id);
		}
	}

	protected override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent _evt)
	{
		base.OnBeforeHit(_evt);
		MonsterAdventureActor monsterAdventureActor = _evt.to as MonsterAdventureActor;
		if (!(monsterAdventureActor != null) || !CanExcuteB || !CommonUtils.CheckHitByTag(_evt.hitDamageTag, damageTag_Task_2))
		{
			return;
		}
		FP fP = (FP)monsterAdventureActor.actorHealthInfo.hpPercentage;
		if (fP < 100)
		{
			int key = TSMath.FloorToInt(fP * 10);
			if (additionalAttrIdDic_Task_2.TryGetValue(key, out var value) && value > 0)
			{
				AdventureActor.AddFromAttr(value, _actor);
			}
		}
	}

	protected override void OnMonsterKilled(AdventureActorReceiveDamageEvent _evt)
	{
		base.OnMonsterKilled(_evt);
		MonsterAdventureActor monsterAdventureActor = _evt.to as MonsterAdventureActor;
		if (CanExcuteA)
		{
			HashSet<long> triggerSet_ = _triggerSet_14;
			if (triggerSet_ != null && triggerSet_.Remove(monsterAdventureActor.Id))
			{
				AreaHit_Perk14(monsterAdventureActor.tsTransform.Position);
			}
		}
	}

	private IEnumerator AreaHit_PerkTask2(AdventureActor actor, TSVector2 position, FP hitRadius)
	{
		yield return hitDelay_Task_2;
		if (_areaHitConfig == null)
		{
			_areaHitConfig = new CommomAreaHitConfig();
		}
		_areaHitConfig.position = position;
		_areaHitConfig.hitDamageId = 986073;
		_areaHitConfig.hittedEffectAlias = "hit_wind_magic";
		ILRuntimeAPI.CircleAreaHit(actor, _areaHitConfig, hitRadius, 0);
		ILRuntimeAPI.SearchByRangeAndPosition(_actor, position, hitRadius, (List<LogicEntity> targets) =>
		{
			if (targets != null && targets.Count > 0)
			{
				if (_pullDistanceList == null)
				{
					_pullDistanceList = new List<FP>(5);
				}
				else
				{
					_pullDistanceList.Clear();
				}
				for (int i = 0; i < targets.Count; i++)
				{
					_pullDistanceList.Add(TSVector2.Distance(targets.get_Item(i).tsTransform.Position, position));
				}
				ILRuntimeAPI.ForceMoveToPosition(position, targets, pullMoveSpeed_Task_2, _pullDistanceList, isCoExist: true, isChangeForward: true, 99, pullStrenth_Task_2);
			}
		}, isConfront: true);
	}

	private void AreaHit_Perk14(TSVector2 position)
	{
		if (_areaHitConfig == null)
		{
			_areaHitConfig = new CommomAreaHitConfig();
		}
		_areaHitConfig.fxAlias = "wind_sickleweasel_14_lv1";
		_areaHitConfig.position = position;
		_areaHitConfig.hitDamageId = 986072;
		_areaHitConfig.hittedEffectAlias = "hit_wind_magic";
		ILRuntimeAPI.CircleAreaHit(_actor, _areaHitConfig, hitRadius_14, 0);
	}

	private string GetWindEaglgPrefabPath()
	{
		if (!CanExcuteB)
		{
			return "FateCard_WindEagle";
		}
		return "FateCard_WindEagle_17";
	}
}
