using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

[AddComponentMenu("Game/Adventure/AreaEffect/AreaEffectComponents/区域效果组件_牵引")]
[RequireComponent(typeof(AreaEffectEntity))]
[DisallowMultipleComponent]
public class AreaEffect_PullComponent : AreaEffect_Component
{
	public FP pullDelay = 0;

	public FP pullTime = 0;

	public FP pullInterval = 0.1;

	public FP pullSpeed = 3;

	public int pullLevel = 99;

	public FP strength = 4;

	public bool pullWithRadius;

	public bool changeTargetDirection = true;

	private FP _pullDelay;

	private FP _pullTime;

	private FP _pullInterval;

	private List<DeterministicCollider> _pullEntityList;

	protected override void OnSetup()
	{
		base.OnSetup();
		_pullDelay = pullDelay;
		_pullTime = pullTime;
		_pullInterval = 0;
	}

	protected override void OnLogicUpdate(FP logicDeltaTime)
	{
		base.OnLogicUpdate(logicDeltaTime);
		if (_pullDelay > 0)
		{
			_pullDelay -= logicDeltaTime;
		}
		else if (pullTime <= 0 || _pullTime > 0)
		{
			if (pullInterval <= 0)
			{
				Pull(logicDeltaTime);
			}
			else if (_pullInterval <= 0)
			{
				Pull(pullInterval);
				_pullInterval = pullInterval;
			}
			else
			{
				_pullInterval -= logicDeltaTime;
			}
			if (_pullTime > 0)
			{
				_pullTime -= logicDeltaTime;
			}
		}
	}

	private void Pull(FP interval)
	{
		UpdatePullEntity();
		List<DeterministicCollider> pullEntityList = _pullEntityList;
		if (pullEntityList == null || pullEntityList.Count <= 0)
		{
			return;
		}
		foreach (DeterministicCollider pullEntity in _pullEntityList)
		{
			FP distance = pullSpeed * interval;
			ILRuntimeAPI.ForceMoveByDistanceToPosition(_context.owner, _context.GetHitPos(), pullEntity.Entity, distance, pullSpeed, strength, pullLevel, isPull: true, pullWithRadius, isCoExist: true, changeTargetDirection);
		}
	}

	private void UpdatePullEntity()
	{
		if (_pullEntityList == null)
		{
			_pullEntityList = new List<DeterministicCollider>(10);
		}
		_context.DeterministicCollision(_pullEntityList, 256, checkTargetWithTag ? _checkTagHashCode : 0);
		_pullEntityList.RemoveAll((DeterministicCollider collider) => !_context.CheckEntitySearchable(collider.Entity) || !_context.CheckTarget(collider.Entity, TargetType.Enemy));
		CommonHelper.SearchEntityAlive(_pullEntityList);
	}

	public override void OnDeactive()
	{
		base.OnDeactive();
		_pullEntityList?.Clear();
	}
}
