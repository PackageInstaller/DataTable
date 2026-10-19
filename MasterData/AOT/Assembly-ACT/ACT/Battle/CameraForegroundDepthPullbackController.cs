using System;
using Cinemachine;
using Unity.Profiling;
using UnityEngine;

namespace ACT.Battle;

[DisallowMultipleComponent]
[RequireComponent(typeof(CinemachineBrain))]
public sealed class CameraForegroundDepthPullbackController : MonoBehaviour
{
	private const int ColliderBufferSize = 16;

	private const int CastBufferSize = 16;

	private const int MaxSamples = 4;

	private const int BinarySearchIterations = 3;

	private const float Epsilon = 0.0001f;

	private const float CachedDirectionDotThreshold = 0.999f;

	private static readonly ProfilerMarker s_UpdateMarker = new ProfilerMarker("CameraForegroundDepthPullbackController.Update");

	[Header("碰撞")]
	[SerializeField]
	private LayerMask collideAgainst = 1;

	[SerializeField]
	[Min(0.01f)]
	private float cameraRadius = 1.5f;

	[SerializeField]
	[Min(0f)]
	private float maxPullBackDistance = 5f;

	[SerializeField]
	[Min(0f)]
	private float wallStopPadding = 0.02f;

	[SerializeField]
	[Min(0.01f)]
	private float viewportEdgeRadius = 0.05f;

	[SerializeField]
	[Min(0f)]
	private float maxJumpableObstacleHeight;

	[Header("镜头平滑")]
	[SerializeField]
	[Min(0f)]
	private float pullBackDamping = 0.14f;

	[SerializeField]
	[Min(0f)]
	private float returnDamping = 0.2f;

	[SerializeField]
	[Min(0f)]
	private float wallStopDamping = 0.12f;

	[SerializeField]
	[Min(0f)]
	private float wallReleaseDamping = 0.2f;

	[Header("调试")]
	[SerializeField]
	private bool debugDraw;

	private readonly Collider[] _overlapBuffer = new Collider[16];

	private readonly RaycastHit[] _castBuffer = new RaycastHit[16];

	private CinemachineBrain _brain;

	private Camera _outputCamera;

	private float _currentPullBackDistance;

	private float _returnVelocity;

	private float _cachedSafePullBackDistance;

	private Vector3 _cachedPullBackDirection;

	private bool _hasCachedSafePullBackDistance;

	private float _nextUnresolvedWarningTime;

	private Vector3 _lastResolvedPosition;

	private bool _hasLastResolvedPosition;

	private Collider _wallBlocker;

	private Vector3 _wallBlockPoint;

	private Vector3 _wallBlockNormal;

	private bool _wasWallStopped;

	private bool _isWallReleaseDamping;

	private float _wallStopVelocity;

	private float _wallReleaseVelocity;

	private Vector3 _debugCandidatePosition;

	private Vector3 _debugResolvedPosition;

	private Vector3 _debugWallStopTarget;

	private Vector3 _debugWallCastBottom;

	private Vector3 _debugWallCastTop;

	private Vector3 _debugWallCastDirection;

	private bool _debugHasCollision;

	private bool _debugHasWallStopTarget;

	private float _debugWallCastDistance;

	private bool _debugHasWallCast;

	private void Awake()
	{
		_brain = GetComponent<CinemachineBrain>();
		_outputCamera = GetComponent<Camera>();
	}

	private void OnEnable()
	{
		CinemachineCore.CameraUpdatedEvent.RemoveListener(OnCameraUpdated);
		CinemachineCore.CameraUpdatedEvent.AddListener(OnCameraUpdated);
		CinemachineCore.CameraCutEvent.RemoveListener(OnCameraCut);
		CinemachineCore.CameraCutEvent.AddListener(OnCameraCut);
	}

	private void OnDisable()
	{
		CinemachineCore.CameraUpdatedEvent.RemoveListener(OnCameraUpdated);
		CinemachineCore.CameraCutEvent.RemoveListener(OnCameraCut);
		ResetState();
	}

	private void OnValidate()
	{
		cameraRadius = Mathf.Max(0.01f, cameraRadius);
		maxPullBackDistance = Mathf.Max(0f, maxPullBackDistance);
		wallStopPadding = Mathf.Max(0f, wallStopPadding);
		viewportEdgeRadius = Mathf.Max(0.01f, viewportEdgeRadius);
		maxJumpableObstacleHeight = Mathf.Max(0f, maxJumpableObstacleHeight);
		pullBackDamping = Mathf.Max(0f, pullBackDamping);
		returnDamping = Mathf.Max(0f, returnDamping);
		wallStopDamping = Mathf.Max(0f, wallStopDamping);
		wallReleaseDamping = Mathf.Max(0f, wallReleaseDamping);
	}

	private void OnCameraCut(CinemachineBrain brain)
	{
		if (brain == _brain)
		{
			ResetState();
		}
	}

	private void OnCameraUpdated(CinemachineBrain brain)
	{
		if (brain != _brain || _brain.ActiveVirtualCamera == null || _brain.ActiveVirtualCamera.Priority >= 91)
		{
			ResetState();
			return;
		}
		if (UsesCinemachineConfiner())
		{
			ResetState();
			return;
		}
		using (s_UpdateMarker.Auto())
		{
			UpdateCameraPosition();
		}
	}

	private void UpdateCameraPosition()
	{
		Vector3 position = transform.position;
		Vector3 vector = -transform.forward;
		if (vector.sqrMagnitude < 0.0001f)
		{
			ResetState();
			return;
		}
		vector.Normalize();
		_debugCandidatePosition = position;
		_debugHasCollision = HasBlockingOverlap(position, out var blockingCollider);
		_debugHasWallStopTarget = false;
		_debugHasWallCast = false;
		if (!_debugHasCollision && TryResolveWallStop(position, out var wallStopPosition))
		{
			ResetPullBackState();
			_wasWallStopped = true;
			_isWallReleaseDamping = false;
			_wallReleaseVelocity = 0f;
			_debugWallStopTarget = wallStopPosition;
			_debugHasWallStopTarget = true;
			ApplyWallStopDamping(ref wallStopPosition);
			_debugResolvedPosition = wallStopPosition;
			transform.position = wallStopPosition;
			RecordResolvedPosition(wallStopPosition);
			return;
		}
		if (!_debugHasCollision && _wasWallStopped)
		{
			_wasWallStopped = false;
			_isWallReleaseDamping = true;
			_wallStopVelocity = 0f;
			_wallReleaseVelocity = 0f;
		}
		float target = 0f;
		if (_debugHasCollision)
		{
			target = ResolvePullBackDistance(position, vector, out var resolved);
			if (!resolved)
			{
				WarnUnresolved(blockingCollider);
			}
		}
		else
		{
			_hasCachedSafePullBackDistance = false;
		}
		if (_debugHasCollision)
		{
			_currentPullBackDistance = Mathf.SmoothDamp(_currentPullBackDistance, target, ref _returnVelocity, pullBackDamping);
		}
		else
		{
			float currentPullBackDistance = _currentPullBackDistance;
			_currentPullBackDistance = Mathf.SmoothDamp(_currentPullBackDistance, target, ref _returnVelocity, returnDamping);
			if (_currentPullBackDistance > 0.0001f && HasBlockingOverlap(position + vector * _currentPullBackDistance, out var blockingCollider2))
			{
				if (currentPullBackDistance > 0.0001f && !HasBlockingOverlap(position + vector * currentPullBackDistance, out blockingCollider2))
				{
					_currentPullBackDistance = currentPullBackDistance;
				}
				else
				{
					_currentPullBackDistance = 0f;
				}
				_returnVelocity = 0f;
			}
		}
		Vector3 position2 = position + vector * _currentPullBackDistance;
		ApplyWallReleaseDamping(ref position2);
		_debugResolvedPosition = position2;
		transform.position = position2;
		RecordResolvedPosition(position2);
	}

	private float ResolvePullBackDistance(Vector3 candidatePosition, Vector3 pullBackDirection, out bool resolved)
	{
		if (_hasCachedSafePullBackDistance && Vector3.Dot(pullBackDirection, _cachedPullBackDirection) >= 0.999f && !HasBlockingOverlap(candidatePosition + pullBackDirection * _cachedSafePullBackDistance, out var blockingCollider))
		{
			resolved = true;
			return _cachedSafePullBackDistance;
		}
		float blockedDistance = 0f;
		for (int i = 1; i <= 4; i++)
		{
			float num = maxPullBackDistance * (float)i / 4f;
			if (!HasBlockingOverlap(candidatePosition + pullBackDirection * num, out blockingCollider))
			{
				float result = (_cachedSafePullBackDistance = RefineSafeDistance(candidatePosition, pullBackDirection, blockedDistance, num));
				_cachedPullBackDirection = pullBackDirection;
				_hasCachedSafePullBackDistance = true;
				resolved = true;
				return result;
			}
			blockedDistance = num;
		}
		_hasCachedSafePullBackDistance = false;
		resolved = false;
		return maxPullBackDistance;
	}

	private float RefineSafeDistance(Vector3 candidatePosition, Vector3 pullBackDirection, float blockedDistance, float safeDistance)
	{
		for (int i = 0; i < 3; i++)
		{
			float num = (blockedDistance + safeDistance) * 0.5f;
			if (HasBlockingOverlap(candidatePosition + pullBackDirection * num, out var _))
			{
				blockedDistance = num;
			}
			else
			{
				safeDistance = num;
			}
		}
		return safeDistance;
	}

	private bool HasBlockingOverlap(Vector3 position, out Collider blockingCollider)
	{
		blockingCollider = null;
		if (!Physics.CheckSphere(position, cameraRadius, collideAgainst, QueryTriggerInteraction.Ignore))
		{
			return false;
		}
		int num = Physics.OverlapSphereNonAlloc(position, cameraRadius, _overlapBuffer, collideAgainst, QueryTriggerInteraction.Ignore);
		for (int i = 0; i < num; i++)
		{
			Collider collider = _overlapBuffer[i];
			if (IsBlockingCollider(collider))
			{
				blockingCollider = collider;
				return true;
			}
		}
		return false;
	}

	private bool TryResolveWallStop(Vector3 candidatePosition, out Vector3 wallStopPosition)
	{
		wallStopPosition = candidatePosition;
		if (!_hasLastResolvedPosition || !TryGetViewportReferencePoint(out var characterPosition))
		{
			return false;
		}
		float num = candidatePosition.x - _lastResolvedPosition.x;
		if (ShouldKeepWallStop(num, characterPosition))
		{
			wallStopPosition.x = _lastResolvedPosition.x;
			return true;
		}
		if (Mathf.Abs(num) < 0.0001f)
		{
			return false;
		}
		float viewportX = ((num > 0f) ? 1f : 0f);
		if (!TryGetViewportEdgeCapsule(_lastResolvedPosition, characterPosition, viewportX, out var bottom, out var top))
		{
			return false;
		}
		Vector3 vector = ((num > 0f) ? Vector3.right : Vector3.left);
		_debugWallCastBottom = bottom;
		_debugWallCastTop = top;
		_debugWallCastDirection = vector;
		_debugWallCastDistance = Mathf.Abs(num);
		_debugHasWallCast = true;
		Collider collider = (CanReleaseWallBlocker() ? _wallBlocker : null);
		int num2 = Physics.CapsuleCastNonAlloc(bottom, top, viewportEdgeRadius, vector, _castBuffer, Mathf.Abs(num), collideAgainst, QueryTriggerInteraction.Ignore);
		int num3 = -1;
		float num4 = float.MaxValue;
		for (int i = 0; i < num2; i++)
		{
			RaycastHit raycastHit = _castBuffer[i];
			if (!(raycastHit.collider == collider) && IsBlockingWall(raycastHit.collider, characterPosition) && !(raycastHit.distance >= num4))
			{
				num3 = i;
				num4 = raycastHit.distance;
			}
		}
		if (num3 < 0)
		{
			return false;
		}
		RaycastHit raycastHit2 = _castBuffer[num3];
		_wallBlocker = raycastHit2.collider;
		_wallBlockPoint = raycastHit2.point;
		_wallBlockNormal = raycastHit2.normal;
		float num5 = Mathf.Max(0f, raycastHit2.distance - wallStopPadding);
		wallStopPosition.x = _lastResolvedPosition.x + Mathf.Sign(num) * num5;
		return true;
	}

	private bool ShouldKeepWallStop(float deltaX, Vector3 characterPosition)
	{
		if (_wallBlocker == null || _wallBlockNormal.sqrMagnitude < 0.0001f || CanReleaseWallBlocker() || !IsBlockingWall(_wallBlocker, characterPosition))
		{
			return false;
		}
		if (Mathf.Abs(deltaX) < 0.0001f)
		{
			return true;
		}
		return Vector3.Dot((deltaX > 0f) ? Vector3.right : Vector3.left, _wallBlockNormal) < -0.0001f;
	}

	private bool TryGetViewportReferencePoint(out Vector3 characterPosition)
	{
		characterPosition = Vector3.zero;
		Transform transform = _brain.ActiveVirtualCamera?.Follow;
		if (transform == null)
		{
			return false;
		}
		characterPosition = transform.position;
		return true;
	}

	private bool TryGetViewportEdgeCapsule(Vector3 cameraPosition, Vector3 characterPosition, float viewportX, out Vector3 bottom, out Vector3 top)
	{
		bottom = Vector3.zero;
		top = Vector3.zero;
		if (_outputCamera == null)
		{
			return false;
		}
		float num = Vector3.Dot(characterPosition - cameraPosition, transform.forward);
		if (num <= _outputCamera.nearClipPlane)
		{
			return false;
		}
		float num2 = ((!_outputCamera.orthographic) ? (num * Mathf.Tan(_outputCamera.fieldOfView * (MathF.PI / 180f) * 0.5f)) : _outputCamera.orthographicSize);
		float num3 = num2 * _outputCamera.aspect;
		float num4 = ((viewportX < 0.5f) ? (0f - num3) : num3);
		Vector3 vector = cameraPosition + transform.forward * num + transform.right * num4;
		bottom = vector - transform.up * num2;
		top = vector + transform.up * num2;
		return true;
	}

	private bool CanReleaseWallBlocker()
	{
		if (_wallBlocker == null || _wallBlockNormal.sqrMagnitude < 0.0001f || !TryGetViewportReferencePoint(out var characterPosition))
		{
			return false;
		}
		return Vector3.Dot(characterPosition - _wallBlockPoint, _wallBlockNormal) < 0f - wallStopPadding;
	}

	private bool IsBlockingWall(Collider collider, Vector3 characterPosition)
	{
		if (IsBlockingCollider(collider))
		{
			return collider.bounds.max.y - characterPosition.y > maxJumpableObstacleHeight;
		}
		return false;
	}

	private void ApplyWallReleaseDamping(ref Vector3 position)
	{
		if (_isWallReleaseDamping && _hasLastResolvedPosition)
		{
			float x = position.x;
			position.x = Mathf.SmoothDamp(_lastResolvedPosition.x, x, ref _wallReleaseVelocity, wallReleaseDamping);
			if (Mathf.Abs(position.x - x) < 0.0001f && Mathf.Abs(_wallReleaseVelocity) < 0.0001f)
			{
				_isWallReleaseDamping = false;
				_wallReleaseVelocity = 0f;
			}
		}
	}

	private void ApplyWallStopDamping(ref Vector3 position)
	{
		if (!(wallStopDamping <= 0.0001f) && _hasLastResolvedPosition)
		{
			float x = _lastResolvedPosition.x;
			float x2 = position.x;
			float value = Mathf.SmoothDamp(x, x2, ref _wallStopVelocity, wallStopDamping);
			position.x = Mathf.Clamp(value, Mathf.Min(x, x2), Mathf.Max(x, x2));
		}
	}

	private static bool IsBlockingCollider(Collider collider)
	{
		if (collider == null || collider.isTrigger)
		{
			return false;
		}
		if (collider.GetComponentInParent<MonoEntity>() != null || collider.GetComponentInParent<MonoHiddenRoomField>() != null || collider.GetComponentInParent<CameraForegroundDepthPullbackIgnore>() != null)
		{
			return false;
		}
		if (collider.GetComponentInParent<IOcclusionCallback>() == null)
		{
			return collider.GetComponentInChildren<IOcclusionCallback>() == null;
		}
		return false;
	}

	private bool UsesCinemachineConfiner()
	{
		CinemachineVirtualCameraBase cinemachineVirtualCameraBase = _brain.ActiveVirtualCamera as CinemachineVirtualCameraBase;
		if (cinemachineVirtualCameraBase == null)
		{
			return false;
		}
		CinemachineConfiner component = cinemachineVirtualCameraBase.VirtualCameraGameObject.GetComponent<CinemachineConfiner>();
		if (component != null && component.isActiveAndEnabled)
		{
			return component.IsValid;
		}
		return false;
	}

	private void WarnUnresolved(Collider blocker)
	{
		if (LuminApplication.LogEnabled && !(Time.unscaledTime < _nextUnresolvedWarningTime))
		{
			_nextUnresolvedWarningTime = Time.unscaledTime + 1f;
			Debug.LogWarning("Camera foreground pullback reached its maximum distance. Camera: " + name + ", blocker: " + blocker?.name, blocker);
		}
	}

	private void ResetState()
	{
		ResetPullBackState();
		_lastResolvedPosition = Vector3.zero;
		_hasLastResolvedPosition = false;
		_wasWallStopped = false;
		_isWallReleaseDamping = false;
		_wallStopVelocity = 0f;
		_wallReleaseVelocity = 0f;
		ClearWallBlocker();
	}

	private void ResetPullBackState()
	{
		_currentPullBackDistance = 0f;
		_returnVelocity = 0f;
		_cachedSafePullBackDistance = 0f;
		_cachedPullBackDirection = Vector3.zero;
		_hasCachedSafePullBackDistance = false;
		_debugHasCollision = false;
		_debugHasWallStopTarget = false;
		_debugHasWallCast = false;
	}

	private void RecordResolvedPosition(Vector3 position)
	{
		_lastResolvedPosition = position;
		_hasLastResolvedPosition = true;
	}

	private void ClearWallBlocker()
	{
		_wallBlocker = null;
		_wallBlockPoint = Vector3.zero;
		_wallBlockNormal = Vector3.zero;
	}
}
