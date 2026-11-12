using System;
using System.Collections.Generic;
using TrueSync;
using UnityEngine;

[Obsolete]
public class AdventureLaser : AdventureBulletBase
{
	public class LinePointData
	{
		public Vector3 position;

		public readonly GameObject point;

		public LinePointData(GameObject p, Vector3 vec)
		{
			position = vec;
			point = p;
			point.transform.position = position;
			Show();
		}

		public void Show(bool show = true)
		{
			if (null != point)
			{
				point.SetActive(show);
			}
		}

		public void Destroy()
		{
			UnityEngine.Object.Destroy(point);
		}
	}

	public bool enablePenetratingActor;

	public bool enablePenetratingObstacle;

	public FP maxLaserLength = 100f;

	public GameObject pointPrefab;

	public LineRenderer lineRenderer;

	public GameObject hittedPrefab;

	protected List<LinePointData> _points;

	protected bool _keepAlive;

	protected TSVector2 _startPointPosition;

	protected Timer _timerToHideEffect;

	protected readonly List<DeterministicRaycastHit> _raycastHits = new List<DeterministicRaycastHit>();

	public override void Setup(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP), AimType aimType = AimType.Default)
	{
		base.Setup(owner, position, positionY, direction, target, targetPosition, targetPositionY, aimType);
		DeterministicCollider deterministicCollider = SceneSingleton<DeterministicCollisionManager>.Instance.CheckPointInterior(ref position, 151808);
		if (deterministicCollider != null && owner != null)
		{
			TSVector2 origin = owner.tsTransform.Position;
			if (deterministicCollider.Raycast(ref origin, ref direction, out var hitInfo, TSVector2.Distance(position, origin)))
			{
				position = hitInfo.point - direction * dtCollider.Radius;
			}
		}
		TrueSyncTransform trueSyncTransform = tsTransform;
		TSVector2 position2 = (originPosition = position);
		trueSyncTransform.Position = position2;
		_startPointPosition = originPosition;
		lineRenderer.gameObject.SetActive(value: true);
	}

	public override void Reset(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP))
	{
		base.Reset(owner, position, positionY, direction, target, targetPosition, targetPositionY);
		_startPointPosition = originPosition;
		_keepAlive = true;
		if (_points == null)
		{
			_points = new List<LinePointData>();
		}
		ClearCorners();
		GenerateNewCorner(originPosition);
	}

	protected override void OnLogicUpdate()
	{
		base.OnLogicUpdate();
		if (!DelayShootUpdate() || !_keepAlive)
		{
			return;
		}
		_keepAlive = false;
		TSVector2 origin = _startPointPosition;
		TSVector2 direction = velocityDirection;
		SceneSingleton<DeterministicCollisionManager>.Instance.RaycastAll(ref origin, ref direction, _raycastHits, maxLaserLength, 151808);
		TSVector2 tSVector = TSVector2.zero;
		bool flag = false;
		for (int i = 0; i < _raycastHits.Count; i++)
		{
			DeterministicRaycastHit raycastHit = _raycastHits.get_Item(i);
			int layer = raycastHit.collider.layer;
			_hitBox.HitSingleTarget(uniqueAttackId, raycastHit.collider, out var hitted, out var _, ref raycastHit, hittedPrefab);
			if (hitted)
			{
				flag = true;
				if (layer == 14)
				{
					tSVector = raycastHit.point;
					break;
				}
				if (!enablePenetratingObstacle && layer == 12)
				{
					tSVector = raycastHit.point;
					break;
				}
				if (!enablePenetratingActor && layer == 8)
				{
					tSVector = raycastHit.point;
					break;
				}
			}
		}
		if (!flag)
		{
			tSVector = origin + direction * maxLaserLength;
		}
		GenerateNewCorner(tSVector);
		if (_keepAlive)
		{
			_startPointPosition = tSVector;
		}
	}

	private void GenerateNewCorner(TSVector2 vec)
	{
		LinePointData linePointData = new LinePointData(UnityEngine.Object.Instantiate(pointPrefab), new Vector3((float)vec.x, (float)tsTransform.PositionY, (float)vec.y));
		linePointData.Show();
		_points.Add(linePointData);
		lineRenderer.positionCount = _points.Count;
		lineRenderer.SetPosition(_points.Count - 1, new Vector3((float)vec.x, (float)tsTransform.PositionY, (float)vec.y));
	}

	private void ClearCorners()
	{
		if (_points != null)
		{
			for (int i = 0; i < _points.Count; i++)
			{
				_points.get_Item(i).Destroy();
			}
			_points.Clear();
		}
		lineRenderer.positionCount = 0;
	}

	protected override void OnActive()
	{
		base.OnActive();
		if (_points != null)
		{
			for (int i = 0; i < _points.Count; i++)
			{
				_points.get_Item(i).Show(show: false);
			}
		}
		lineRenderer.gameObject.SetActive(value: false);
		if (_timerToHideEffect == null)
		{
			_timerToHideEffect = MonoSingleton<TimerManager>.Instance.CreateFixedTimer(0.2f, 1, deleteWhenComplete: false);
			_timerToHideEffect.CreateTimerCompleteEventListener(delegate
			{
				HideEffect();
			});
			_timerToHideEffect.Start();
		}
		else
		{
			_timerToHideEffect.ReStart();
		}
	}

	private void HideEffect()
	{
		if (_points != null)
		{
			for (int i = 0; i < _points.Count; i++)
			{
				_points.get_Item(i).Show(show: false);
			}
		}
		lineRenderer.gameObject.SetActive(value: false);
		Finish();
	}
}
