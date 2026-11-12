using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DormActorFSM_Rome(DormActor actor, int state) : DormActorFSM(actor, state)
{
	private enum RomeState
	{
		Idle,
		Move,
		Interact
	}

	private enum RoamBehaviour
	{
		Idle,
		Move,
		Interact
	}

	private bool _roamArrived;

	private bool _roamRepick;

	private bool _roamStuck;

	private Coroutine corWaitForNextBehaviour;

	private float avoidDistance = 1.5f;

	private Vector2 roamIdleDurationRange = new Vector2(3f, 8f);

	private Vector2 roamMoveDurationRange = new Vector2(3f, 8f);

	private Vector2 roamIdleShowDelayRange = new Vector2(3f, 5f);

	private float roamSpecialIdleThreshold = 5f;

	private float roamInteractMoveTimeout = 8f;

	private float roamInteractArriveRange = 0.5f;

	private float roamLeaveFurnitureDistance = 2f;

	private float roamLeaveFurnitureTimeout = 5f;

	private float _lastAvoidTime = -10f;

	private const float kAvoidCooldown = 0.6f;

	private RomeState romeState;

	private RoamBehaviour _lastExecutedBehaviour;

	private int _sameBehaviourRun;

	private bool _isPlayingIdleShow;

	private float _overlapCheckCountdown;

	private float _overlapTime;

	private bool _stepAsidePending;

	public override void OnEnter(object data = null)
	{
		base.OnEnter(data);
		if (actor.IsHeldByInteractIcon)
		{
			actor.DiscardLeaveFurniturePending();
			actor.HoldByInteractIcon();
			return;
		}
		actor.EnableMovment();
		avoidDistance = 1.5f;
		roamIdleDurationRange = DormConfigs.roamIdleDurationRange;
		roamMoveDurationRange = DormConfigs.roamMoveDurationRange;
		roamIdleShowDelayRange = DormConfigs.roamIdleShowDelayRange;
		roamSpecialIdleThreshold = 5f;
		roamInteractMoveTimeout = 8f;
		roamInteractArriveRange = 0.5f;
		roamLeaveFurnitureDistance = 2f;
		roamLeaveFurnitureTimeout = 5f;
		_overlapCheckCountdown = Random.Range(0f, Mathf.Max(0.01f, 1f));
		_overlapTime = 0f;
		_stepAsidePending = false;
		corWaitForNextBehaviour = StartCoroutine(RoamCycle());
		actor.StartRandomBlink();
	}

	public override void OnExit()
	{
		actor.StopRandomBlink();
		if (corWaitForNextBehaviour != null)
		{
			StopCoroutine(corWaitForNextBehaviour);
		}
		actor.StopMove();
		ResetIdleShow();
		romeState = RomeState.Idle;
		_stepAsidePending = false;
		actor.ReleaseFurnitureInteractReservation();
		base.OnExit();
	}

	public void RequestMoveAway(Vector3 avoidFromPos)
	{
		Vector3 position = actor.transform.position;
		float num = position.x - avoidFromPos.x;
		float num2 = position.z - avoidFromPos.z;
		float minDistance = Mathf.Sqrt(num * num + num2 * num2);
		if (TryPickPointAwayFrom(avoidFromPos, minDistance, preferFarthest: true, out var result, out var metMinDistance) & metMinDistance)
		{
			romeState = RomeState.Move;
			_roamArrived = false;
			actor.MoveTo(result, () =>
			{
				_roamArrived = true;
			});
		}
		else
		{
			_roamRepick = true;
			_stepAsidePending = true;
		}
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		UpdateOverlapSelfHealDetect();
	}

	private void UpdateOverlapSelfHealDetect()
	{
		if (_stepAsidePending)
		{
			return;
		}
		if (actor.IsMoving)
		{
			_overlapTime = 0f;
			return;
		}
		_overlapCheckCountdown -= Time.deltaTime;
		if (_overlapCheckCountdown > 0f)
		{
			return;
		}
		_overlapCheckCountdown = 1f;
		if (!IsOverlappingOtherActor())
		{
			_overlapTime = 0f;
			return;
		}
		_overlapTime++;
		if (!(_overlapTime < 1.5f))
		{
			_overlapTime = 0f;
			_stepAsidePending = true;
		}
	}

	private bool ConsumeStepAsidePending()
	{
		if (!_stepAsidePending)
		{
			return false;
		}
		_stepAsidePending = false;
		return true;
	}

	private IEnumerator RoamCycle()
	{
		yield return null;
		bool immediate = actor.ConsumeSpawnBehaviourPending() && !(actor is DormPlayer);
		if (actor.ConsumeLeaveFurniturePending(out var furniturePos))
		{
			yield return LeaveFurnitureBehaviour(furniturePos);
			immediate = false;
		}
		while (true)
		{
			if (ConsumeStepAsidePending())
			{
				yield return StepAsideFromOverlapBehaviour();
				immediate = false;
				continue;
			}
			switch (PickBehaviour())
			{
			case RoamBehaviour.Interact:
				yield return InteractBehaviour(immediate);
				break;
			case RoamBehaviour.Move:
				yield return MoveBehaviour();
				break;
			default:
				yield return IdleBehaviour();
				break;
			}
			immediate = false;
		}
	}

	private void NoteBehaviourExecuted(RoamBehaviour behaviour)
	{
		if (behaviour == _lastExecutedBehaviour)
		{
			_sameBehaviourRun++;
		}
		else
		{
			_sameBehaviourRun = 1;
		}
		_lastExecutedBehaviour = behaviour;
	}

	private float GetEffectiveWeight(RoamBehaviour behaviour, float baseWeight)
	{
		baseWeight = Mathf.Max(0f, baseWeight);
		if (_sameBehaviourRun <= 0 || behaviour != _lastExecutedBehaviour)
		{
			return baseWeight;
		}
		if (_sameBehaviourRun >= 3)
		{
			return 0f;
		}
		float f = Mathf.Clamp01(0.3f);
		return baseWeight * Mathf.Pow(f, _sameBehaviourRun);
	}

	private RoamBehaviour PickBehaviour()
	{
		float num = GetEffectiveWeight(RoamBehaviour.Idle, 5f);
		float num2 = GetEffectiveWeight(RoamBehaviour.Move, 2f);
		float num3 = GetEffectiveWeight(RoamBehaviour.Interact, 3f);
		if (num + num2 + num3 <= 0f)
		{
			num = Mathf.Max(0f, 5f);
			num2 = Mathf.Max(0f, 2f);
			num3 = Mathf.Max(0f, 3f);
		}
		float num4 = num + num2 + num3;
		if (num4 <= 0f)
		{
			return RoamBehaviour.Idle;
		}
		float num5 = Random.Range(0f, num4);
		if (num5 < num)
		{
			return RoamBehaviour.Idle;
		}
		if (num5 < num + num2)
		{
			return RoamBehaviour.Move;
		}
		return RoamBehaviour.Interact;
	}

	private IEnumerator IdleBehaviour()
	{
		NoteBehaviourExecuted(RoamBehaviour.Idle);
		actor.StopMove();
		romeState = RomeState.Idle;
		float idleT = Random.Range(roamIdleDurationRange.x, roamIdleDurationRange.y);
		float elapsed = 0f;
		while (elapsed < idleT)
		{
			yield return null;
			elapsed += Time.deltaTime;
			if (_stepAsidePending)
			{
				yield break;
			}
		}
		if (idleT > roamSpecialIdleThreshold)
		{
			_isPlayingIdleShow = true;
			actor.PlayIdleShowAnim(() =>
			{
				_isPlayingIdleShow = false;
			});
			while (_isPlayingIdleShow)
			{
				yield return null;
			}
		}
	}

	private IEnumerator MoveBehaviour()
	{
		NoteBehaviourExecuted(RoamBehaviour.Move);
		float moveT = Random.Range(roamMoveDurationRange.x, roamMoveDurationRange.y);
		float elapsed = 0f;
		_roamArrived = true;
		_roamRepick = false;
		for (; elapsed < moveT; elapsed += Time.deltaTime)
		{
			if (_roamArrived || _roamRepick)
			{
				_roamArrived = false;
				_roamRepick = false;
				if (actor.TryGetRandomWalkablePointInScene(out var result, 1f))
				{
					romeState = RomeState.Move;
					actor.MoveTo(result, () =>
					{
						_roamArrived = true;
					}, () =>
					{
						_roamArrived = true;
					});
				}
			}
			yield return null;
		}
		actor.StopMove();
	}

	private IEnumerator LeaveFurnitureBehaviour(Vector3 furniturePos)
	{
		if (!TryPickPointAwayFrom(furniturePos, roamLeaveFurnitureDistance, preferFarthest: false, out var result, out var _))
		{
			yield return MoveBehaviour();
			yield break;
		}
		NoteBehaviourExecuted(RoamBehaviour.Move);
		romeState = RomeState.Move;
		_roamArrived = false;
		_roamStuck = false;
		actor.MoveTo(result, () =>
		{
			_roamArrived = true;
		}, () =>
		{
			_roamStuck = true;
		});
		float elapsed = 0f;
		while (!_roamArrived && !_roamStuck && elapsed < roamLeaveFurnitureTimeout)
		{
			yield return null;
			elapsed += Time.deltaTime;
		}
		actor.StopMove();
	}

	private IEnumerator StepAsideFromOverlapBehaviour()
	{
		DormLevelController dormLevelController = ModuleController<DormModuleController>.Instance.levelInstance as DormLevelController;
		if (dormLevelController == null || !dormLevelController.TryGetFreeCellNearActor(actor, out var result))
		{
			yield return MoveBehaviour();
			yield break;
		}
		romeState = RomeState.Move;
		_roamArrived = false;
		_roamStuck = false;
		actor.MoveTo(result, () =>
		{
			_roamArrived = true;
		}, () =>
		{
			_roamStuck = true;
		});
		float elapsed = 0f;
		while (!_roamArrived && !_roamStuck && elapsed < 3f)
		{
			yield return null;
			elapsed += Time.deltaTime;
		}
		actor.StopMove();
	}

	private bool IsOverlappingOtherActor()
	{
		List<DynamicSimpleEntity> list = ModuleController<DormModuleController>.Instance?.ActorEntities;
		if (list == null)
		{
			return false;
		}
		float num = 0.48999998f;
		Vector3 position = actor.transform.position;
		for (int i = 0; i < list.Count; i++)
		{
			DormActor dormActor = list.get_Item(i) as DormActor;
			if (!(dormActor == null) && dormActor.id != actor.id && !dormActor.isHide && !dormActor.IsMoving)
			{
				float num2 = dormActor.transform.position.x - position.x;
				float num3 = dormActor.transform.position.z - position.z;
				if (num2 * num2 + num3 * num3 < num)
				{
					return true;
				}
			}
		}
		return false;
	}

	private bool TryPickPointAwayFrom(Vector3 avoidPos, float minDistance, bool preferFarthest, out Vector3 result, out bool metMinDistance)
	{
		result = default;
		metMinDistance = false;
		float num = minDistance * minDistance;
		Vector3 vector = default;
		float num2 = float.MaxValue;
		Vector3 vector2 = default;
		float num3 = -1f;
		for (int i = 0; i < 6; i++)
		{
			if (actor.TryGetRandomWalkablePointInScene(out var result2, 1f))
			{
				float num4 = result2.x - avoidPos.x;
				float num5 = result2.z - avoidPos.z;
				float num6 = num4 * num4 + num5 * num5;
				if (num6 >= num && num6 < num2)
				{
					num2 = num6;
					vector = result2;
					metMinDistance = true;
				}
				if (num6 > num3)
				{
					num3 = num6;
					vector2 = result2;
				}
			}
		}
		if (num3 < 0f)
		{
			return false;
		}
		result = ((metMinDistance && !preferFarthest) ? vector : vector2);
		return true;
	}

	private IEnumerator InteractBehaviour(bool immediate = false)
	{
		DormLevelController level = ModuleController<DormModuleController>.Instance.levelInstance as DormLevelController;
		if (level == null || !level.TryPickInteractableFurnitureForActor(actor, out var furniture, out var walkTarget))
		{
			yield return MoveBehaviour();
			yield break;
		}
		if (immediate)
		{
			if (level.ActorBeginInteractWithFurniture(actor, furniture))
			{
				NoteBehaviourExecuted(RoamBehaviour.Interact);
				romeState = RomeState.Interact;
			}
			else
			{
				actor.ReleaseFurnitureInteractReservation();
				yield return MoveBehaviour();
			}
			yield break;
		}
		romeState = RomeState.Move;
		_roamArrived = false;
		_roamStuck = false;
		actor.MoveTo(walkTarget, () =>
		{
			_roamArrived = true;
		}, () =>
		{
			_roamStuck = true;
		});
		float sqrArrive = roamInteractArriveRange * roamInteractArriveRange;
		float elapsed = 0f;
		while (!_roamArrived)
		{
			Vector3 position = actor.transform.position;
			float num = position.x - walkTarget.x;
			float num2 = position.z - walkTarget.z;
			if (num * num + num2 * num2 <= sqrArrive)
			{
				break;
			}
			if (_roamStuck || elapsed >= roamInteractMoveTimeout)
			{
				actor.StopMove();
				actor.ReleaseFurnitureInteractReservation();
				yield return MoveBehaviour();
				yield break;
			}
			yield return null;
			elapsed += Time.deltaTime;
		}
		if (level.ActorBeginInteractWithFurniture(actor, furniture))
		{
			NoteBehaviourExecuted(RoamBehaviour.Interact);
			romeState = RomeState.Interact;
		}
		else
		{
			actor.StopMove();
			actor.ReleaseFurnitureInteractReservation();
			yield return MoveBehaviour();
		}
	}

	private void ResetIdleShow()
	{
		if (_isPlayingIdleShow)
		{
			actor.StopTimelineAnimation();
		}
		_isPlayingIdleShow = false;
	}
}
