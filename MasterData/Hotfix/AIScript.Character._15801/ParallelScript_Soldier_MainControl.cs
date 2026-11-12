using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15801;

public class ParallelScript_Soldier_MainControl : ParallelScript_Summoned_MainControl
{
	private CoroutineNode _promotionCor;

	private HashSet<long> _addMoraleUniqueIdSet;

	public override void OnEnable()
	{
		base.OnEnable();
		Init();
	}

	private void Init()
	{
		int buffNumByID = _summoner.buffComponent.GetBuffNumByID(15800002);
		if (buffNumByID > 0)
		{
			_actor.buffComponent.AddBuffNum(GetMoraleBuffId(), buffNumByID, _actor);
			CheckPromotion();
		}
	}

	protected override bool HaveMoraleLogic()
	{
		return true;
	}

	protected override int GetMoraleBuffId()
	{
		return 15800001;
	}

	protected override void OnMoraleChange(bool isAdd = false)
	{
		base.OnMoraleChange(isAdd);
		if (isAdd)
		{
			CheckPromotion();
		}
	}

	protected override void OnBattleReady()
	{
		base.OnBattleReady();
		TSVector2 randomPointInShape = ILRuntimeAPI.GetRandomPointInShape(_summoner, new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Circle,
			innerRadius = _summoner.GetRadius(),
			radius = Config_MainControl.defaultSummonRadius_Soldier,
			position = _summoner.tsTransform.Position
		});
		_actor.Teleport(randomPointInShape);
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor target = damageEvent.to as MonsterAdventureActor;
		if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_TriggerMorale))
		{
			if (_addMoraleUniqueIdSet == null)
			{
				_addMoraleUniqueIdSet = new HashSet<long>();
			}
			if (_addMoraleUniqueIdSet.Add(damageEvent.uniqueAttackId))
			{
				AddMorale(1);
			}
		}
		if (HavePersonalPerk(515805, out var _) && CommonUtils.CheckElementMark(CommonDefine.Fire, target) && TSRandom.Range(FP.Zero, 100) <= CommonUtils.GetScriptValue(_summoner, 15805011))
		{
			AddMorale(1);
			_actor.buffComponent.AddBuff(15805011, _actor);
		}
	}

	private void CheckPromotion()
	{
		if (_promotionCor == null || _promotionCor.finished)
		{
			int num = CommonUtils.GetScriptValue(_actor, 15800002).AsInt();
			if (_actor.buffComponent.GetBuffNumByID(GetMoraleBuffId()) >= num)
			{
				_promotionCor = _actor.StartLogicCoroutine(PromotionLogic(), runImmediately: true);
			}
		}
	}

	private IEnumerator PromotionLogic()
	{
		while (_actor.state == ActorState.Null || _actor.state == ActorState.Spawn || _actor.actorSkillManage.HaveRunningSkill())
		{
			yield return null;
		}
		_summoner.logicVariable.ToggleLogicTag("IsToyChange", value: true);
		_actor.buffComponent.RemoveBuffByBuffId(GetMoraleBuffId());
		_actor.DestroySelf();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_addMoraleUniqueIdSet?.Clear();
		if (_promotionCor != null)
		{
			_actor.StopLogicCoroutine(_promotionCor);
		}
		_promotionCor = null;
	}
}
