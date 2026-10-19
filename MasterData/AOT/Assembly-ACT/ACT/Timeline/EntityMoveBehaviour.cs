using System;
using ACT.Battle;
using Bamboo.ECS;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

[Serializable]
public class EntityMoveBehaviour : PlayableBehaviour
{
	public enum MoveSpace
	{
		World,
		LocalToStart
	}

	public enum FacingMode
	{
		None,
		FaceMoveDirection,
		ForceLeft,
		ForceRight
	}

	public MoveSpace moveSpace = MoveSpace.LocalToStart;

	public Vector3 targetPosition = Vector3.forward;

	public AnimationCurve positionCurve = AnimationCurve.Linear(0f, 0f, 1f, 1f);

	public bool snapToEnd = true;

	public FacingMode facingMode = FacingMode.FaceMoveDirection;

	[NonSerialized]
	private Entity _entity;

	[NonSerialized]
	private bool _initialized;

	[NonSerialized]
	private Vector3 _startPosition;

	[NonSerialized]
	private ACTMovementMode _cachedMovementMode;

	[NonSerialized]
	private bool _cachedDetectCollision;

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (!Application.isPlaying)
		{
			return;
		}
		_entity = EntityControlPlayableUtility.ResolveEntity(playerData);
		CompTransform compTransform = _entity.GetCompTransform();
		if (compTransform == null)
		{
			return;
		}
		CompPhysics compPhysics = _entity.GetCompPhysics();
		if (!_initialized)
		{
			_startPosition = compTransform.physicsPosition;
			if (compPhysics != null)
			{
				_cachedMovementMode = compPhysics.state;
				_cachedDetectCollision = compPhysics.DetectCollision;
				compPhysics.ClearVelocity();
				compPhysics.DetectCollision = false;
				compPhysics.SetMovementMode(ACTMovementMode.Custom);
			}
			_initialized = true;
		}
		double num = Math.Max(playable.GetDuration(), 0.0001);
		float num2 = Mathf.Clamp01((float)(playable.GetTime() / num));
		float t = ((positionCurve != null) ? positionCurve.Evaluate(num2) : num2);
		Vector3 endPosition = GetEndPosition();
		Vector3 vector = Vector3.LerpUnclamped(_startPosition, endPosition, t);
		Vector3 moveDelta = vector - compTransform.physicsPosition;
		compPhysics?.ClearVelocity();
		_entity.Teleport(vector);
		UpdateFacing(moveDelta);
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		if (Application.isPlaying)
		{
			if (_initialized && snapToEnd && playable.GetTime() >= playable.GetDuration() && _entity != null)
			{
				Vector3 endPosition = GetEndPosition();
				Vector3 moveDelta = endPosition - _entity.GetCompTransform().physicsPosition;
				_entity.Teleport(endPosition);
				UpdateFacing(moveDelta);
			}
			RestoreState();
		}
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		RestoreState();
	}

	private Vector3 GetEndPosition()
	{
		return moveSpace switch
		{
			MoveSpace.World => targetPosition, 
			MoveSpace.LocalToStart => _startPosition + targetPosition, 
			_ => _startPosition, 
		};
	}

	private void UpdateFacing(Vector3 moveDelta)
	{
		if (_entity == null)
		{
			return;
		}
		switch (facingMode)
		{
		case FacingMode.None:
			break;
		case FacingMode.FaceMoveDirection:
			if (!(Mathf.Abs(moveDelta.x) < 0.001f))
			{
				ApplyFacing(moveDelta.x < 0f);
			}
			break;
		case FacingMode.ForceLeft:
			ApplyFacing(faceLeft: true);
			break;
		case FacingMode.ForceRight:
			ApplyFacing(faceLeft: false);
			break;
		}
	}

	private void ApplyFacing(bool faceLeft)
	{
		_entity.SetFaceLeft(faceLeft);
		_entity.GetCompPhysics()?.SetDirImmediately();
	}

	private void RestoreState()
	{
		if (_initialized)
		{
			CompPhysics compPhysics = _entity.GetCompPhysics();
			if (compPhysics != null)
			{
				compPhysics.ClearVelocity();
				compPhysics.DetectCollision = _cachedDetectCollision;
				compPhysics.SetMovementMode(_cachedMovementMode);
			}
			_entity = default;
			_initialized = false;
		}
	}
}
