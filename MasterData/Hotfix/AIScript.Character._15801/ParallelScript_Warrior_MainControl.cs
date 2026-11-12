using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15801;

public class ParallelScript_Warrior_MainControl : ParallelScript_Summoned_MainControl
{
	private CoroutineNode _returnCor;

	private HashSet<long> _removeMoraleUniqueIdSet;

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
		}
		else
		{
			CheckReturn();
		}
	}

	protected override bool HaveMoraleLogic()
	{
		return true;
	}

	protected override int GetMoraleBuffId()
	{
		return 15800003;
	}

	protected override void OnMoraleChange(bool isAdd = false)
	{
		base.OnMoraleChange(isAdd);
		if (isAdd)
		{
			if (_returnCor != null)
			{
				_actor.StopLogicCoroutine(_returnCor);
			}
			_returnCor = null;
		}
		else
		{
			CheckReturn();
		}
	}

	protected override void OnBattleReady()
	{
		base.OnBattleReady();
		TSVector2 randomPointInShape = ILRuntimeAPI.GetRandomPointInShape(_summoner, new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Circle,
			innerRadius = _summoner.GetRadius(),
			radius = Config_MainControl.defaultSummonRadius_Warrior,
			position = _summoner.tsTransform.Position
		});
		_actor.Teleport(randomPointInShape);
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor target = damageEvent.to as MonsterAdventureActor;
		if (HavePersonalPerk(515805, out var _) && CommonUtils.CheckElementMark(CommonDefine.Fire, target) && TSRandom.Range(FP.Zero, 100) <= CommonUtils.GetScriptValue(_summoner, 15805011))
		{
			AddMorale(1);
			_actor.buffComponent.AddBuff(15805011, _actor);
		}
		if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_TriggerMorale))
		{
			if (_removeMoraleUniqueIdSet == null)
			{
				_removeMoraleUniqueIdSet = new HashSet<long>();
			}
			if (_removeMoraleUniqueIdSet.Add(damageEvent.uniqueAttackId))
			{
				RemoveMorale(2);
			}
		}
	}

	private void CheckReturn()
	{
		if ((_returnCor == null || _returnCor.finished) && !_actor.buffComponent.CheckBuffByBuffID(GetMoraleBuffId()))
		{
			_returnCor = _actor.StartLogicCoroutine(ReturnLogic(), runImmediately: true);
		}
	}

	private IEnumerator ReturnLogic()
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
		_removeMoraleUniqueIdSet?.Clear();
		if (_returnCor != null)
		{
			_actor.StopLogicCoroutine(_returnCor);
		}
		_returnCor = null;
	}
}
