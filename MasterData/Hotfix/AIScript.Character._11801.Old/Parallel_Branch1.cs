using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11801.Old;

public class Parallel_Branch1 : Parallel
{
	protected readonly int _certainBuffId1 = 11803;

	protected readonly int _dizzyBuffId = 11812;

	protected readonly int _pullCount = 3;

	protected FP _pullInterval = 3;

	protected FP _moveSpeed = 10;

	protected readonly int _moveLevel = 99;

	protected FP _strength = 4;

	protected CoroutineNode _pullCoroutine;

	protected int _currentPullCount;

	public override void OnDisable()
	{
		base.OnDisable();
		if (_pullCoroutine != null)
		{
			_actor.StopLogicCoroutine(_pullCoroutine);
			_pullCoroutine = null;
		}
		_currentPullCount = 0;
	}

	protected override IEnumerator WaitForPullEnd(FP duration)
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(duration));
		ClearBuffAndEffect();
		if (_pullCoroutine != null)
		{
			_actor.StopLogicCoroutine(_pullCoroutine);
			_pullCoroutine = null;
			for (int i = 0; i < targets.Count; i++)
			{
				targets.get_Item(i).GetComponent<AdventureActor>().buffComponent.RemoveBuffByBuffId(_certainBuffId1);
			}
		}
		for (int j = 0; j < targets.Count; j++)
		{
			targets.get_Item(j).GetComponent<AdventureActor>().buffComponent.AddBuff(_certainBuffId1, _actor);
		}
		_currentPullCount = 0;
		_pullCoroutine = _actor.StartLogicCoroutine(Pull());
	}

	protected IEnumerator Pull()
	{
		List<LogicEntity> validTargets = new List<LogicEntity>();
		while (_currentPullCount < _pullCount)
		{
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_pullInterval));
			validTargets.Clear();
			for (int i = 0; i < targets.Count; i++)
			{
				if (targets.get_Item(i).GetComponent<AdventureActor>().actorHealthInfo.isAlive)
				{
					validTargets.Add(targets.get_Item(i));
				}
			}
			if (validTargets.Count > 1)
			{
				_actor.SearchEntitySortByDistance(validTargets);
				List<AdventureActor> list = new List<AdventureActor>();
				List<FP> list2 = new List<FP>();
				AdventureActor component;
				if (validTargets.Count == 2)
				{
					component = validTargets.get_Item(0).GetComponent<AdventureActor>();
					AdventureActor component2 = validTargets.get_Item(1).GetComponent<AdventureActor>();
					list.Add(component2);
					FP item = ILRuntimeAPI.CalcDistanceBetweenTwoActor(component, component2);
					list2.Add(item);
				}
				else
				{
					int index = validTargets.Count / 2;
					component = validTargets.get_Item(index).GetComponent<AdventureActor>();
					for (int j = 0; j < validTargets.Count; j++)
					{
						LogicEntity logicEntity = validTargets.get_Item(j);
						if (!(logicEntity == component))
						{
							AdventureActor component3 = logicEntity.GetComponent<AdventureActor>();
							list.Add(component3);
							FP item2 = ILRuntimeAPI.CalcDistanceBetweenTwoActor(component, component3);
							list2.Add(item2);
						}
					}
				}
				ILRuntimeAPI.ForceMove(component, list, _moveSpeed, list2, isCoExist: true, isChangeForward: true, _moveLevel, _strength);
				foreach (LogicEntity item3 in validTargets)
				{
					item3.GetComponent<AdventureActor>()?.buffComponent?.AddBuff(_dizzyBuffId, _actor);
				}
			}
			_currentPullCount++;
		}
		for (int k = 0; k < targets.Count; k++)
		{
			validTargets.get_Item(k).GetComponent<AdventureActor>().buffComponent.RemoveBuffByBuffId(_certainBuffId1);
		}
		_pullCoroutine = null;
	}
}
