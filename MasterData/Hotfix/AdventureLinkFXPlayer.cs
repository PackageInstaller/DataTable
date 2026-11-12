using System;
using System.Collections.Generic;
using UnityEngine;

[AddComponentMenu("Game/FX/Link FX Player")]
public class AdventureLinkFXPlayer : AdventureFXPlayer
{
	public enum LinkMode
	{
		[InspectorName("射线")]
		Ray,
		[InspectorName("连线")]
		Line
	}

	[Header("-- 起点终点特效配置 --")]
	public AnimationSlotConfigComponent.SlotType sourceSlot;

	public GameObject sourceFXPrefab;

	[Space]
	public AnimationSlotConfigComponent.SlotType targetSlot;

	public GameObject targetFXPrefab;

	[Header("-- 连线特效配置 --")]
	public LinkMode linkMode;

	public bool linkLoop;

	[Min(0.001f)]
	public float linkDuration = 1f;

	[Space]
	public bool enableLineCast;

	public float lineCastDistance = 20f;

	public float lineCastRadius = 0.5f;

	[Space]
	public LineRenderer lineRenderer;

	public AdventureLinkFXPlayer_LineRendererMaterial lineRenderMaterialSubComp;

	protected AdventureFXPlayer _sourceFXPlayer;

	protected long _sourceFXToken;

	protected AdventureFXPlayer _targetFXPlayer;

	protected long _targetFXToken;

	protected Vector3 _lastSourcePosition;

	[HideInInspector]
	public Vector3 _lastTargetPosition;

	protected Vector3 _lastMotionPosition;

	protected bool _started;

	protected int _linePositionCount;

	protected Vector3[] _linePositions;

	[Header("-- 曲线轨迹配置 --")]
	public bool enableCurveMotion;

	public float curveMotionFrequency;

	[Space]
	public Vector3 curveControlPoint1 = new Vector3(0f, 5f, 3f);

	public Vector2 randomRadiusCP1;

	public Vector3 curveControlPoint2 = new Vector3(0f, 5f, 6f);

	public Vector2 randomRadiusCP2;

	[Space]
	public bool enableCurveMotion2ndControlPoints;

	public Vector3 curve2ndControlPoint1 = new Vector3(0f, 5f, 3f);

	public Vector2 randomRadius2ndCP1;

	public Vector3 curve2ndControlPoint2 = new Vector3(0f, 5f, 6f);

	public Vector2 randomRadius2ndCP2;

	public AnimationCurve curveControlPointsEase;

	protected const float REFERENCE_LINE_LENGTH = 10f;

	protected static readonly Vector3 CURVE_CP0 = new Vector3(0f, 0f, 0f);

	protected static readonly Vector3 CURVE_CP3 = new Vector3(0f, 0f, 10f);

	protected const int curveSegmentCount = 12;

	protected const int curveSegmentTess = 3;

	protected Vector3 _cp1_ref;

	protected Vector3 _cp2_ref;

	protected Vector3 _2nd_cp1_ref;

	protected Vector3 _2nd_cp2_ref;

	protected Vector3 _cp0;

	protected Vector3 _cp1;

	protected Vector3 _cp2;

	protected Vector3 _cp3;

	protected Vector3 _curr_cp1_ref;

	protected Vector3 _curr_cp2_ref;

	protected Vector3 _next_cp1_ref;

	protected Vector3 _next_cp2_ref;

	protected Vector3 _curr_2nd_cp1_ref;

	protected Vector3 _curr_2nd_cp2_ref;

	protected Vector3 _next_2nd_cp1_ref;

	protected Vector3 _next_2nd_cp2_ref;

	[Space]
	[Range(0f, 1f)]
	[SerializeField]
	protected float _motionNormalizedTimer;

	protected float _curveMotionFrequencyTimer;

	private AnimationSlotConfigComponent _sourceSyncSlotConfigComponent;

	private AnimationSlotConfigComponent _targetSyncSlotConfigComponent;

	public static int LineCastLayerMask { get; set; } = -1;

	public override float size
	{
		get
		{
			return _size;
		}
		set
		{
			_size = value;
		}
	}

	public override float sizeScale
	{
		get
		{
			return _sizeScale;
		}
		set
		{
			_sizeScale = value;
		}
	}

	protected float minRadiusCP1 => Mathf.Min(randomRadiusCP1.x, randomRadiusCP1.y);

	protected float maxRadiusCP1 => Mathf.Max(randomRadiusCP1.x, randomRadiusCP1.y);

	protected float minRadiusCP2 => Mathf.Min(randomRadiusCP2.x, randomRadiusCP2.y);

	protected float maxRadiusCP2 => Mathf.Max(randomRadiusCP2.x, randomRadiusCP2.y);

	protected float minRadius2ndCP1 => Mathf.Min(randomRadius2ndCP1.x, randomRadius2ndCP1.y);

	protected float maxRadius2ndCP1 => Mathf.Max(randomRadius2ndCP1.x, randomRadius2ndCP1.y);

	protected float minRadius2ndCP2 => Mathf.Min(randomRadius2ndCP2.x, randomRadius2ndCP2.y);

	protected float maxRadius2ndCP2 => Mathf.Max(randomRadius2ndCP2.x, randomRadius2ndCP2.y);

	public AnimationSlotConfigComponent sourceSyncSlotComponent
	{
		get
		{
			return _sourceSyncSlotConfigComponent;
		}
		set
		{
			if (_sourceSyncSlotConfigComponent != null)
			{
				AnimationSlotConfigComponent sourceSyncSlotConfigComponent = _sourceSyncSlotConfigComponent;
				sourceSyncSlotConfigComponent.onSlotGroupChange = (Action)Delegate.Remove(sourceSyncSlotConfigComponent.onSlotGroupChange, new Action(OnSourceSlotGroupChange));
			}
			_sourceSyncSlotConfigComponent = value;
			if (_sourceSyncSlotConfigComponent != null)
			{
				AnimationSlotConfigComponent sourceSyncSlotConfigComponent2 = _sourceSyncSlotConfigComponent;
				sourceSyncSlotConfigComponent2.onSlotGroupChange = (Action)Delegate.Combine(sourceSyncSlotConfigComponent2.onSlotGroupChange, new Action(OnSourceSlotGroupChange));
			}
		}
	}

	public AnimationSlotConfigComponent targetSyncSlotComponent
	{
		get
		{
			return _targetSyncSlotConfigComponent;
		}
		set
		{
			if (_targetSyncSlotConfigComponent != null)
			{
				AnimationSlotConfigComponent targetSyncSlotConfigComponent = _targetSyncSlotConfigComponent;
				targetSyncSlotConfigComponent.onSlotGroupChange = (Action)Delegate.Remove(targetSyncSlotConfigComponent.onSlotGroupChange, new Action(OnTargetSlotGroupChange));
			}
			_targetSyncSlotConfigComponent = value;
			if (_targetSyncSlotConfigComponent != null)
			{
				AnimationSlotConfigComponent targetSyncSlotConfigComponent2 = _targetSyncSlotConfigComponent;
				targetSyncSlotConfigComponent2.onSlotGroupChange = (Action)Delegate.Combine(targetSyncSlotConfigComponent2.onSlotGroupChange, new Action(OnTargetSlotGroupChange));
			}
		}
	}

	internal static void InitLineCastLayerMask()
	{
		LineCastLayerMask = 350464;
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		SetupLineRenderer();
	}

	protected override void OnDisable()
	{
		sourceSyncSlotComponent = null;
		targetSyncSlotComponent = null;
		_sourceFXPlayer = null;
		_targetFXPlayer = null;
		base.OnDisable();
	}

	protected override void Preload_Internal()
	{
		base.Preload_Internal();
		if (sourceFXPrefab != null)
		{
			AdventureFXPlayer.PreloadFX(sourceFXPrefab);
		}
		if (targetFXPrefab != null)
		{
			AdventureFXPlayer.PreloadFX(targetFXPrefab);
		}
	}

	public static long PlayStarStyleLinkFX(GameObject fxPrefab, GameObject source, List<GameObject> targets, float playbackSpeed, float spawnSize = 1f, bool bind = true, string fxTag = null)
	{
		long num = 0L;
		for (int i = 0; i < targets.Count; i++)
		{
			GameObject gameObject = targets.get_Item(i);
			if (gameObject != null)
			{
				Quaternion identity = Quaternion.identity;
				Transform transform = source.transform;
				Transform transform2 = gameObject.transform;
				AdventureFXPlayer adventureFXPlayer = AdventureFXPlayer.PlayFX(fxPrefab, playbackSpeed, default, identity, spawnSize, transform, default, transform2);
				if (!string.IsNullOrEmpty(fxTag))
				{
					adventureFXPlayer.fxTag = fxTag;
				}
				if (num == 0L)
				{
					num = adventureFXPlayer.token;
				}
				adventureFXPlayer.rootPlayerToken = num;
				if (bind)
				{
					adventureFXPlayer.Bind(source);
				}
			}
		}
		return num;
	}

	public static long PlayTandemStyleLinkFX(GameObject fxPrefab, GameObject source, List<GameObject> targets, bool shuffleTargets, float playbackSpeed, float spawnSize = 1f, bool bind = true, string fxTag = null)
	{
		if (shuffleTargets)
		{
			FrameworkMiscUtils.ShuffleList(targets);
		}
		long num = 0L;
		GameObject gameObject = null;
		for (int i = 0; i < targets.Count; i++)
		{
			GameObject gameObject2 = targets.get_Item(i);
			if (gameObject2 != null)
			{
				AdventureFXPlayer adventureFXPlayer = null;
				if (num == 0L)
				{
					Quaternion identity = Quaternion.identity;
					Transform transform = source.transform;
					Transform transform2 = gameObject2.transform;
					adventureFXPlayer = AdventureFXPlayer.PlayFX(fxPrefab, playbackSpeed, default, identity, spawnSize, transform, default, transform2);
					num = adventureFXPlayer.token;
				}
				else
				{
					Quaternion identity2 = Quaternion.identity;
					Transform transform3 = gameObject.transform;
					Transform transform2 = gameObject2.transform;
					adventureFXPlayer = AdventureFXPlayer.PlayFX(fxPrefab, playbackSpeed, default, identity2, spawnSize, transform3, default, transform2);
				}
				if (!string.IsNullOrEmpty(fxTag))
				{
					adventureFXPlayer.fxTag = fxTag;
				}
				adventureFXPlayer.rootPlayerToken = num;
				gameObject = gameObject2;
				if (bind)
				{
					adventureFXPlayer.Bind(source);
				}
			}
		}
		return num;
	}

	private void Play_Internal(float playbackSpeed, Transform sourceArg, Vector3 sourcePositionArg, Transform targetArg, Vector3 targetPositionArg)
	{
		if (sourceArg != null && sourceSlot != AnimationSlotConfigComponent.SlotType.None && sourceArg.TryGetComponent<AnimationSlotConfigComponent>(out var component))
		{
			sourceSyncSlotComponent = component;
			sourceArg = component.GetSlotNode(sourceSlot, allowFallback: true);
		}
		if (targetArg != null && targetSlot != AnimationSlotConfigComponent.SlotType.None && targetArg.TryGetComponent<AnimationSlotConfigComponent>(out var component2))
		{
			targetSyncSlotComponent = component2;
			targetArg = component2.GetSlotNode(targetSlot, allowFallback: true);
		}
		_lastSourcePosition = ((sourceArg != null) ? sourceArg.position : sourcePositionArg);
		_lastTargetPosition = ((targetArg != null) ? targetArg.position : targetPositionArg);
		if (linkMode == LinkMode.Ray)
		{
			Vector3 lastMotionPosition = (transform.position = _lastSourcePosition);
			_lastMotionPosition = lastMotionPosition;
		}
		_started = false;
		if (linkMode == LinkMode.Ray)
		{
			isLoop = false;
		}
		else if (linkMode == LinkMode.Line)
		{
			isLoop = linkLoop;
		}
		base.Play(playbackSpeed, sourceArg, sourcePositionArg, targetArg, targetPositionArg);
		switch (linkMode)
		{
		case LinkMode.Ray:
			if (sourceFXPrefab != null)
			{
				_sourceFXPlayer = AdventureFXPlayer.PlayFX(sourceFXPrefab, playbackSpeed, sourcePosition, sourceRotation, size);
				_sourceFXToken = _sourceFXPlayer.token;
			}
			break;
		case LinkMode.Line:
			if (sourceFXPrefab != null)
			{
				_sourceFXPlayer = AdventureFXPlayer.PlayFX(sourceFXPrefab, playbackSpeed, sourcePosition, sourceRotation, size);
				_sourceFXToken = _sourceFXPlayer.token;
			}
			if (targetFXPrefab != null)
			{
				_targetFXPlayer = AdventureFXPlayer.PlayFX(targetFXPrefab, playbackSpeed, targetPosition, targetRotation, size);
				_targetFXToken = _targetFXPlayer.token;
			}
			lineRenderMaterialSubComp?.PlayWithLinkFXPlayer(this);
			break;
		}
		_motionNormalizedTimer = 0f;
		if (enableCurveMotion)
		{
			UpdateCurveReferenceControlPoints();
		}
	}

	public override void Play(float playbackSpeed, Transform sourceArg, Vector3 sourcePositionArg, Transform targetArg, Vector3 targetPositionArg)
	{
		if (linkMode == LinkMode.Line && enableLineCast && syncSlot != AnimationSlotConfigComponent.SlotType.None)
		{
			base.playbackSpeed = playbackSpeed;
			source = sourceArg;
			sourcePosition = sourcePositionArg;
			target = targetArg;
			targetPosition = targetPositionArg;
		}
		else
		{
			Play_Internal(playbackSpeed, sourceArg, sourcePositionArg, targetArg, targetPositionArg);
		}
	}

	public override void Bind(GameObject owner, GameObject syncTarget = null, ActorState actorState = ActorState.Null, Combo combo = null, Combo.Phase comboPhase = Combo.Phase.All, bool cancelOnInterrupt = false)
	{
		base.Bind(owner, syncTarget, actorState, combo, comboPhase, cancelOnInterrupt);
		if (linkMode == LinkMode.Line && enableLineCast && syncSlot != AnimationSlotConfigComponent.SlotType.None)
		{
			Play_Internal(playbackSpeed, source, sourcePosition, target, targetPosition);
		}
		switch (linkMode)
		{
		case LinkMode.Ray:
			if (_sourceFXPlayer != null && _sourceFXPlayer.token == _sourceFXToken)
			{
				_sourceFXPlayer.Bind(owner, gameObject, actorState, combo, comboPhase);
			}
			break;
		case LinkMode.Line:
			if (_sourceFXPlayer != null && _sourceFXPlayer.token == _sourceFXToken)
			{
				_sourceFXPlayer.Bind(owner, gameObject, actorState, combo, comboPhase);
			}
			if (_targetFXPlayer != null && _targetFXPlayer.token == _targetFXToken)
			{
				_targetFXPlayer.Bind(owner, gameObject, actorState, combo, comboPhase);
			}
			break;
		}
	}

	public override void Stop(bool dontPlaySubFX = false)
	{
		if (isPlaying)
		{
			switch (linkMode)
			{
			case LinkMode.Ray:
				if (_sourceFXPlayer != null && _sourceFXPlayer.token == _sourceFXToken)
				{
					_sourceFXPlayer.Stop(dontPlaySubFX);
					_sourceFXPlayer = null;
				}
				if (!dontPlaySubFX && targetFXPrefab != null)
				{
					_targetFXPlayer = AdventureFXPlayer.PlayFX(targetFXPrefab, playbackSpeed, targetPosition, targetRotation, size);
					_targetFXToken = _targetFXPlayer.token;
				}
				break;
			case LinkMode.Line:
				if (_sourceFXPlayer != null && _sourceFXPlayer.token == _sourceFXToken)
				{
					_sourceFXPlayer.Stop(dontPlaySubFX);
					_sourceFXPlayer = null;
				}
				if (_targetFXPlayer != null && _targetFXPlayer.token == _targetFXToken)
				{
					_targetFXPlayer.Stop(dontPlaySubFX);
					_targetFXPlayer = null;
				}
				break;
			}
		}
		base.Stop(dontPlaySubFX);
	}

	public override void DoLateUpdate()
	{
		base.DoLateUpdate();
		if (!isPlaying)
		{
			return;
		}
		float dt = playbackDeltaTime;
		bool flag = !inRemainPhase;
		_motionNormalizedTimer = _playbackTimer / linkDuration;
		_motionNormalizedTimer = Mathf.Repeat(_motionNormalizedTimer, 1f);
		Vector3 vector;
		Vector3 vector2;
		if (flag)
		{
			if (linkMode == LinkMode.Line && enableLineCast)
			{
				Ray ray = new Ray(transform.position, transform.forward);
				if (Physics.SphereCast(ray, lineCastRadius, out var hitInfo, lineCastDistance, LineCastLayerMask))
				{
					vector = ray.origin;
					vector2 = ray.origin + ray.direction * hitInfo.distance;
				}
				else
				{
					vector = ray.origin;
					vector2 = ray.origin + ray.direction * lineCastDistance;
				}
			}
			else
			{
				vector = sourcePosition;
				vector2 = targetPosition;
			}
		}
		else
		{
			vector = _lastSourcePosition;
			vector2 = _lastTargetPosition;
		}
		switch (linkMode)
		{
		case LinkMode.Ray:
			EvaluateRayMotion(dt, flag, vector, vector2);
			break;
		case LinkMode.Line:
			EvaluateLineMotion(dt, flag, vector, vector2);
			break;
		}
		if (_sourceFXPlayer != null && _sourceFXPlayer.token == _sourceFXToken)
		{
			_sourceFXPlayer.transform.position = vector;
		}
		if (_targetFXPlayer != null && _targetFXPlayer.token == _targetFXToken)
		{
			_targetFXPlayer.transform.position = vector2;
		}
		if (flag)
		{
			_lastSourcePosition = vector;
			_lastTargetPosition = vector2;
		}
	}

	protected override bool PlaybackStoped()
	{
		if (!isLoop)
		{
			if (_playbackTimer >= linkDuration)
			{
				return true;
			}
			return false;
		}
		return false;
	}

	public override void Pause()
	{
		if (!paused)
		{
			if (_sourceFXPlayer != null && _sourceFXPlayer.token == _sourceFXToken)
			{
				_sourceFXPlayer.Pause();
			}
			if (_targetFXPlayer != null && _targetFXPlayer.token == _targetFXToken)
			{
				_targetFXPlayer.Pause();
			}
			base.Pause();
		}
	}

	public override void Resume()
	{
		if (paused)
		{
			if (_sourceFXPlayer != null && _sourceFXPlayer.token == _sourceFXToken)
			{
				_sourceFXPlayer.Resume();
			}
			if (_targetFXPlayer != null && _targetFXPlayer.token == _targetFXToken)
			{
				_targetFXPlayer.Resume();
			}
			base.Resume();
		}
	}

	protected void EvaluateRayMotion(float dt, bool updateMotion, Vector3 sourcePos, Vector3 targetPos)
	{
		if (!_started)
		{
			_motionNormalizedTimer = 0f;
			_started = true;
		}
		Vector3 pos;
		Vector3 dir;
		if (enableCurveMotion)
		{
			if (updateMotion)
			{
				CalcCurveControlPoints(_motionNormalizedTimer, sourcePos, targetPos);
			}
			CalcCurvePoint(_motionNormalizedTimer, out pos, out dir);
		}
		else
		{
			pos = Vector3.Lerp(sourcePos, targetPos, _motionNormalizedTimer);
			dir = targetPos - sourcePos;
		}
		transform.position = Vector3.Lerp(_lastMotionPosition, pos, _motionNormalizedTimer);
		transform.forward = dir;
		if (updateMotion)
		{
			_lastMotionPosition = pos;
		}
	}

	protected void SetupLineRenderer()
	{
		if (!(lineRenderer == null))
		{
			lineRenderer.loop = false;
			lineRenderer.useWorldSpace = true;
			lineRenderer.allowOcclusionWhenDynamic = false;
			_linePositionCount = lineRenderer.positionCount;
			if (_linePositions == null || _linePositions.Length != _linePositionCount)
			{
				_linePositions = new Vector3[_linePositionCount];
			}
			lineRenderMaterialSubComp?.BindWithLinkFXPlayer(this);
		}
	}

	protected void EvaluateLineMotion(float dt, bool updateMotion, Vector3 sourcePos, Vector3 targetPos)
	{
		if (lineRenderer == null)
		{
			return;
		}
		if (enableCurveMotion)
		{
			if (updateMotion && curveMotionFrequency > float.Epsilon)
			{
				if (!_started)
				{
					_curr_cp1_ref = _cp1_ref;
					_curr_cp2_ref = _cp2_ref;
					_curr_2nd_cp1_ref = _2nd_cp1_ref;
					_curr_2nd_cp2_ref = _2nd_cp2_ref;
					UpdateCurveReferenceControlPoints();
					_next_cp1_ref = _cp1_ref;
					_next_cp2_ref = _cp2_ref;
					_next_2nd_cp1_ref = _2nd_cp1_ref;
					_next_2nd_cp2_ref = _2nd_cp2_ref;
					_started = true;
					_curveMotionFrequencyTimer = 0f;
				}
				_curveMotionFrequencyTimer += dt;
				if (_curveMotionFrequencyTimer >= curveMotionFrequency)
				{
					_curveMotionFrequencyTimer -= curveMotionFrequency;
					_curr_cp1_ref = _next_cp1_ref;
					_curr_cp2_ref = _next_cp2_ref;
					_curr_2nd_cp1_ref = _next_2nd_cp1_ref;
					_curr_2nd_cp2_ref = _next_2nd_cp2_ref;
					UpdateCurveReferenceControlPoints();
					_next_cp1_ref = _cp1_ref;
					_next_cp2_ref = _cp2_ref;
					_next_2nd_cp1_ref = _2nd_cp1_ref;
					_next_2nd_cp2_ref = _2nd_cp2_ref;
				}
				float t = _curveMotionFrequencyTimer / curveMotionFrequency;
				_cp1_ref = Vector3.Lerp(_curr_cp1_ref, _next_cp1_ref, t);
				_cp2_ref = Vector3.Lerp(_curr_cp2_ref, _next_cp2_ref, t);
				if (enableCurveMotion2ndControlPoints)
				{
					_2nd_cp1_ref = Vector3.Lerp(_curr_2nd_cp1_ref, _next_2nd_cp1_ref, t);
					_2nd_cp2_ref = Vector3.Lerp(_curr_2nd_cp2_ref, _next_2nd_cp2_ref, t);
				}
			}
			CalcCurveControlPoints(_motionNormalizedTimer, sourcePos, targetPos);
			for (int i = 0; i < _linePositionCount; i++)
			{
				float t2 = (float)i / (float)(_linePositionCount - 1);
				CalcCurvePoint(t2, out var pos, out var _);
				_linePositions[i] = pos;
			}
		}
		else
		{
			for (int j = 0; j < _linePositionCount; j++)
			{
				float t3 = (float)j / (float)(_linePositionCount - 1);
				Vector3 vector = Vector3.Lerp(sourcePos, targetPos, t3);
				_linePositions[j] = vector;
			}
		}
		lineRenderer.SetPositions(_linePositions);
	}

	protected void UpdateCurveReferenceControlPoints()
	{
		float num = Mathf.Lerp(minRadiusCP1, maxRadiusCP1, UnityEngine.Random.value);
		float num2 = Mathf.Lerp(minRadiusCP2, maxRadiusCP2, UnityEngine.Random.value);
		_cp1_ref = curveControlPoint1 + UnityEngine.Random.onUnitSphere * num;
		_cp2_ref = curveControlPoint2 + UnityEngine.Random.onUnitSphere * num2;
		if (enableCurveMotion2ndControlPoints)
		{
			float num3 = Mathf.Lerp(minRadius2ndCP1, maxRadius2ndCP1, UnityEngine.Random.value);
			float num4 = Mathf.Lerp(minRadius2ndCP2, maxRadius2ndCP2, UnityEngine.Random.value);
			_2nd_cp1_ref = curve2ndControlPoint1 + UnityEngine.Random.onUnitSphere * num3;
			_2nd_cp2_ref = curve2ndControlPoint2 + UnityEngine.Random.onUnitSphere * num4;
		}
	}

	protected void CalcCurveControlPoints(float t, Vector3 startPoint, Vector3 endPoint)
	{
		Vector3 point = _cp1_ref;
		Vector3 point2 = _cp2_ref;
		if (enableCurveMotion2ndControlPoints)
		{
			t = curveControlPointsEase.Evaluate(t);
			point = Vector3.Lerp(_cp1_ref, _2nd_cp1_ref, t);
			point2 = Vector3.Lerp(_cp2_ref, _2nd_cp2_ref, t);
		}
		_cp0 = GameMathUtils.YAxisSkewTransformPointByLine(CURVE_CP0, startPoint, endPoint, 10f);
		_cp1 = GameMathUtils.YAxisSkewTransformPointByLine(point, startPoint, endPoint, 10f);
		_cp2 = GameMathUtils.YAxisSkewTransformPointByLine(point2, startPoint, endPoint, 10f);
		_cp3 = GameMathUtils.YAxisSkewTransformPointByLine(CURVE_CP3, startPoint, endPoint, 10f);
	}

	protected void CalcCurvePoint(float t, out Vector3 pos, out Vector3 dir)
	{
		pos = BezierCurve3D.CalcPoint(_cp0, _cp1, _cp2, _cp3, t);
		dir = BezierCurve3D.CalcFirstDerivative(_cp0, _cp1, _cp2, _cp3, t);
	}

	private void OnSourceSlotGroupChange()
	{
		source = sourceSyncSlotComponent.GetSlotNode(sourceSlot, allowFallback: true);
	}

	private void OnTargetSlotGroupChange()
	{
		target = targetSyncSlotComponent.GetSlotNode(targetSlot, allowFallback: true);
	}
}
