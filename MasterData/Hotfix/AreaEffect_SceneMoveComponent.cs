using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;
using UnityEngine;

[AddComponentMenu("Game/Adventure/AreaEffect/AreaEffectComponents/区域效果组件_场景位移")]
[RequireComponent(typeof(AreaEffectEntity))]
[DisallowMultipleComponent]
public class AreaEffect_SceneMoveComponent : AreaEffect_Component
{
	public TargetFilterCriteriaInfo criteriaInfo;

	public bool triggerEnter;

	public bool triggerStay;

	public FP triggerStayTime = 1;

	public bool triggerExit;

	public TSVector moveDirection;

	public FP moveSpeed = 1;

	public FP moveAcceleratedSpeed = 1;

	public FP moveMaxDistance = 1;

	public FP moveMaxTime = 1;

	public FP horizontalOffsetMoveTime = 0;

	public FP horizontalOffsetMoveDistance = 0;

	public bool isSetPosition;

	public bool isCustomPosition;

	public List<TSVector2> customPositionList;

	[Space]
	public FP componentRadius = 1;

	private Dictionary<long, CoroutineNode> _sceneMoveCorDic;

	private Dictionary<long, FP> _triggerStayDic;

	public void EnterSceneMove(AdventureActor actor)
	{
		if (!(actor == null))
		{
			if (_sceneMoveCorDic == null)
			{
				_sceneMoveCorDic = new Dictionary<long, CoroutineNode>();
			}
			if (!_sceneMoveCorDic.ContainsKey(actor.Id))
			{
				_sceneMoveCorDic.Add(actor.Id, _context.StartLogicCoroutine(SceneMoveCor(actor)));
			}
		}
	}

	private IEnumerator SceneMoveCor(AdventureActor actor)
	{
		bool moveFinish = false;
		bool moveInterrupt = false;
		while (!actor.EnterSceneMove(moveDirection, moveSpeed, moveAcceleratedSpeed, moveMaxDistance, () =>
		{
			moveFinish = true;
		}, () =>
		{
			moveInterrupt = true;
		}))
		{
			yield return null;
		}
		FP horizontalDistance = 0;
		FP horizontalMoveSpeed = 0;
		TSVector2 horizontalMoveDir = default;
		if (horizontalOffsetMoveTime > 0)
		{
			FP fP = TSVector2.Distance(_context.GetHitPos(), actor.tsTransform.Position);
			horizontalDistance = fP + actor.GetRadius() - horizontalOffsetMoveDistance;
			horizontalDistance = TSMath.Clamp(horizontalDistance, 0, fP);
			horizontalMoveSpeed = horizontalDistance / horizontalOffsetMoveTime;
			horizontalMoveDir = _context.GetHitPos() - actor.tsTransform.Position;
			horizontalMoveDir.Normalize();
		}
		FP moveTime = 0;
		FP horizontalMoveTime = 0;
		while (moveTime < moveMaxTime && !moveFinish)
		{
			if (moveInterrupt)
			{
				_sceneMoveCorDic?.Remove(actor.Id);
				yield break;
			}
			moveTime += _context.LogicDeltaTime;
			if (horizontalOffsetMoveTime > 0 && horizontalDistance > 0 && horizontalMoveTime < horizontalOffsetMoveTime)
			{
				TSVector2 tSVector = horizontalMoveSpeed * horizontalMoveDir;
				actor.tsTransform.Position += tSVector * _context.LogicDeltaTime;
				horizontalMoveTime += _context.LogicDeltaTime;
			}
			yield return null;
		}
		SetPosition(actor);
		actor.ExitSceneMove();
		_sceneMoveCorDic?.Remove(actor.Id);
	}

	private void SetPosition(AdventureActor actor)
	{
		if (actor == null || !isSetPosition)
		{
			return;
		}
		TSVector2 tSVector = actor.tsTransform.Position;
		if (isCustomPosition)
		{
			if (customPositionList != null && customPositionList.Count > 0)
			{
				tSVector = customPositionList.get_Item(TSRandom.Range(0, customPositionList.Count));
				actor.tsTransform.Position = tSVector;
			}
		}
		else
		{
			FP radius = GetRadius();
			DeterministicShape shape = new DeterministicShape
			{
				shapeType = _context.hitBoxShape switch
				{
					HitBox.Shape.Rectangle => DeterministicShape.ShapeType.Circle, 
					HitBox.Shape.Circle => DeterministicShape.ShapeType.Circle, 
					HitBox.Shape.Fan => DeterministicShape.ShapeType.Fan, 
					_ => throw new ArgumentOutOfRangeException(), 
				},
				position = _context.GetHitPos(),
				rotation = _context.GetHitRot(),
				radius = radius + 1,
				innerRadius = radius,
				angle = _context.hitBoxAngle
			};
			tSVector = actor.RandomActorReachablePointInsideShape(shape);
		}
		actor.tsTransform.Position = tSVector;
		FP terrainHeight = CommonHelper.GetTerrainHeight(tSVector, actor.tsTransform.PositionY);
		actor.tsTransform.PositionY = terrainHeight;
	}

	private FP GetRadius()
	{
		FP result = _context.GetAreaRadius();
		if (_context.hitBoxShape == HitBox.Shape.Rectangle)
		{
			result = componentRadius * _context.GetAreaScale();
		}
		return result;
	}

	private bool CheckTarget(AdventureActor actor)
	{
		if (actor is DestructibleStateSingle)
		{
			return false;
		}
		if (actor.GetRadius() > GetRadius())
		{
			return false;
		}
		if (checkTargetWithTag && _checkTagHashCode != 0 && !actor.CheckTag(_checkTagHashCode))
		{
			return false;
		}
		return _context.CheckTarget(actor, criteriaInfo);
	}

	public override void OnDeactive()
	{
		base.OnDeactive();
		if (_sceneMoveCorDic != null && _sceneMoveCorDic.Count > 0)
		{
			foreach (KeyValuePair<long, CoroutineNode> item in _sceneMoveCorDic)
			{
				CoroutineNode value = item.Value;
				if (!value.finished)
				{
					_context.StopLogicCoroutine(value);
					AdventureActor adventureActor = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(item.Key) as AdventureActor;
					SetPosition(adventureActor);
					adventureActor?.ExitSceneMove();
				}
			}
			_sceneMoveCorDic?.Clear();
		}
		_triggerStayDic?.Clear();
	}

	protected override void OnDeterministicCollisionEnter(LogicEntity entity)
	{
		base.OnDeterministicCollisionEnter(entity);
		if (_context.CheckEntitySearchable(entity) && triggerEnter && entity is AdventureActor actor && CheckTarget(actor))
		{
			EnterSceneMove(actor);
		}
	}

	protected override void OnDeterministicCollisionStay(LogicEntity entity)
	{
		base.OnDeterministicCollisionStay(entity);
		if (!_context.CheckEntitySearchable(entity) || !triggerStay || !(entity is AdventureActor adventureActor) || !CheckTarget(adventureActor))
		{
			return;
		}
		if (triggerStayTime <= 0)
		{
			EnterSceneMove(adventureActor);
			return;
		}
		if (_triggerStayDic == null)
		{
			_triggerStayDic = new Dictionary<long, FP>(10);
		}
		if (_triggerStayDic.ContainsKey(adventureActor.Id))
		{
			_triggerStayDic.get_Item(adventureActor.Id) += _context.LogicDeltaTime;
		}
		else
		{
			_triggerStayDic.Add(adventureActor.Id, _context.LogicDeltaTime);
		}
		if (_triggerStayDic.get_Item(adventureActor.Id) >= triggerStayTime)
		{
			EnterSceneMove(adventureActor);
			_triggerStayDic.set_Item(adventureActor.Id, (FP)0);
		}
	}

	protected override void OnDeterministicCollisionExit(LogicEntity entity)
	{
		base.OnDeterministicCollisionExit(entity);
		if (_context.CheckEntitySearchable(entity) && triggerExit && entity is AdventureActor actor && CheckTarget(actor))
		{
			EnterSceneMove(actor);
		}
	}
}
