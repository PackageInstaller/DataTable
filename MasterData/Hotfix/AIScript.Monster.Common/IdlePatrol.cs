using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Common;

public class IdlePatrol : AIBase
{
	protected CoroutineNode _patrolCoroutine;

	public void OnStart()
	{
		_patrolCoroutine = _actor.StartLogicCoroutine(Patrol());
	}

	private IEnumerator Patrol()
	{
		TSVector2 initPostion = _actor.tsTransform.Position;
		while (true)
		{
			TSVector2 tSVector = _actor.RandomActorReachablePointInsideRing(initPostion, 1, 2);
			if (TSVector2.Distance(_actor.tsTransform.Position, tSVector) >= 2)
			{
				bool moveFinish = false;
				_actor.MoveTo(tSVector, 0.1f, enableNavigation: true, AdventureActor.MovementMode.Run, () =>
				{
					moveFinish = true;
				});
				while (!moveFinish)
				{
					yield return null;
				}
				int num = TSRandom.Range(1, 2);
				yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(num));
			}
			else
			{
				yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(0.5f));
			}
		}
	}

	public void OnStop()
	{
		if (_patrolCoroutine != null)
		{
			_actor.StopLogicCoroutine(_patrolCoroutine);
			_patrolCoroutine = null;
		}
	}

	public void OnUpdate()
	{
		if (!ModuleController<AdventureModuleController>.Instance.InBattleState)
		{
			return;
		}
		ILRuntimeAPI.RangeSearch(_actor, (List<LogicEntity> result) =>
		{
			if (result.Count > 0)
			{
				_actor.Action();
			}
		});
	}

	public void OnDisable()
	{
	}

	public void OnEnable()
	{
	}
}
