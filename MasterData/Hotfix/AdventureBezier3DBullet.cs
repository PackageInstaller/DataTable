using System;
using System.Collections.Generic;
using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器/贝塞尔曲线轨迹子弹3D")]
[RequireComponent(typeof(WeaponFeatureTraceTarget))]
public class AdventureBezier3DBullet : AdventureBullet
{
	[Serializable]
	public class ControlPos
	{
		public TSVector2 P1;

		public TSVector2 P2;
	}

	private enum State
	{
		Trace,
		AccMove
	}

	[Space]
	public FP flyTime = 1f;

	public bool EnableControlList;

	public List<ControlPos> ControlList = new List<ControlPos>();

	public bool RandomControlIndex;

	public TSVector2 randomP1Min = new TSVector2(2, 2);

	public TSVector2 randomP1Max = new TSVector2(2, 2);

	public TSVector2 randomP2Min = new TSVector2(2, 2);

	public TSVector2 randomP2Max = new TSVector2(2, 2);

	[Space]
	public FP controlXZ = 2;

	public FP controlY = 2;

	[Space]
	public FP controlXZ2 = 2;

	public FP controlY2 = 2;

	[Space]
	public float bezierPathRotate;

	[Space]
	public FP distancePercent = 0.5f;

	[Space]
	public float crossSpd = 50f;

	[Space]
	public float defaultOffsetHeight = 1f;

	public FP startAccTime = 0;

	public FP minVelocitySpeed = 0;

	public FP maxVelocitySpeed = 50f;

	public bool traceTarget;

	protected FP _flyTimer;

	private FP _bezierPathRotateFP;

	private FP _defaultOffsetHeightFP;

	private TSVector controlP1;

	private TSVector controlP2;

	private TSVector targetP;

	private TSVector originP;

	private Transform targetBody;

	protected TSVector _currentPosition;

	protected TSVector _prePosition;

	private Vector3 _currentScale;

	private State curState;

	private WeaponFeatureTraceTarget traceCom;

	private TSVector targetPos;

	private FP escapedTime;

	private int controlIndex;

	public FP DefaultOffsetHeightFP => _defaultOffsetHeightFP;

	protected override void OnInit()
	{
		base.OnInit();
		traceCom = GetComponent<WeaponFeatureTraceTarget>();
		traceCom.iActive = false;
		_currentScale = transform.localScale;
		_bezierPathRotateFP = FP.FromConfigFloat(bezierPathRotate);
		_defaultOffsetHeightFP = FP.FromConfigFloat(defaultOffsetHeight);
	}

	public void OnEnableControlListChanged()
	{
		if (EnableControlList)
		{
			RandomControlIndex = false;
		}
	}

	public void OnRandomControlIndexChanged()
	{
		if (RandomControlIndex)
		{
			EnableControlList = false;
		}
	}

	public void BeforeSetup(int controlIndex)
	{
		this.controlIndex = controlIndex;
	}

	public override void Setup(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP), AimType aimType = AimType.Default)
	{
		base.Setup(owner, position, positionY, direction, target, targetPosition, targetPositionY, aimType);
		curState = State.Trace;
		if (smooth != null)
		{
			smooth.dontSyncRotate = true;
		}
		_currentPosition = (_prePosition = default);
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
		CalTargetPos();
		originP = new TSVector(originPosition.x, positionY, originPosition.y);
		targetP = originP + (targetP - originP) * distancePercent;
		FP fP = controlXZ;
		FP fP2 = controlY;
		FP fP3 = controlXZ2;
		FP fP4 = controlY2;
		if (EnableControlList && controlIndex >= 0 && controlIndex < ControlList.Count)
		{
			ControlPos controlPos = ControlList.get_Item(controlIndex);
			fP = controlPos.P1.x;
			fP2 = controlPos.P1.y;
			fP3 = controlPos.P2.x;
			fP4 = controlPos.P2.y;
		}
		else if (RandomControlIndex)
		{
			fP = TSRandom.Range(randomP1Min.x, randomP1Max.x);
			fP2 = TSRandom.Range(randomP1Min.y, randomP1Max.y);
			fP3 = TSRandom.Range(randomP2Min.x, randomP2Max.x);
			fP4 = TSRandom.Range(randomP2Min.y, randomP2Max.y);
		}
		TSVector2 normalized = direction.normalized;
		TSVector tSVector2 = new TSVector(normalized.x, 0, normalized.y);
		TSVector tSVector3 = originP + tSVector2 * fP;
		TSVector tSVector4 = new TSVector(originP.x, originP.y + fP2, originP.z);
		TSVector tSVector5 = tSVector3 - originP + (tSVector4 - originP);
		if (_bezierPathRotateFP != 0)
		{
			controlP1 = TSQuaternion.AngleAxis(_bezierPathRotateFP, tSVector2.normalized) * tSVector5 + originP;
		}
		else
		{
			controlP1 = tSVector5 + originP;
		}
		tSVector2 = new TSVector(normalized.x, 0, normalized.y);
		TSVector tSVector6 = originP + tSVector2 * fP3;
		tSVector4 = new TSVector(originP.x, originP.y + fP4, originP.z);
		tSVector5 = tSVector6 - originP + (tSVector4 - originP);
		if (_bezierPathRotateFP != 0)
		{
			controlP2 = TSQuaternion.AngleAxis(_bezierPathRotateFP, tSVector2.normalized) * tSVector5 + originP;
		}
		else
		{
			controlP2 = tSVector5 + originP;
		}
		_flyTimer = 0f;
	}

	public override void Reset(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP))
	{
		base.Reset(owner, position, positionY, direction, target, targetPosition, targetPositionY);
		_flyTimer = 0f;
		escapedTime = 0;
	}

	protected override void OnLogicUpdate()
	{
		if (CheckFinishByWeaponFeature())
		{
			Finish(cancel: true);
		}
		else
		{
			if (!DelayShootUpdate())
			{
				return;
			}
			FP logicDeltaTime = LogicDeltaTime;
			if (curState == State.Trace)
			{
				FP fP = TSMath.Clamp01(_flyTimer / flyTime);
				if (fP < 1)
				{
					_flyTimer += logicDeltaTime;
					if (_currentPosition != default(TSVector))
					{
						_prePosition = _currentPosition;
					}
					CalTargetPos();
					targetP = originP + (targetP - originP) * distancePercent;
					_currentPosition = MoveByBezier(fP, targetP);
					tsTransform.Position = new TSVector2(_currentPosition.x, _currentPosition.z);
					tsTransform.PositionY = _currentPosition.y;
					if (_prePosition != default(TSVector))
					{
						TSVector normalized = (_currentPosition - _prePosition).normalized;
						transform.forward = new Vector3((float)normalized.x, (float)normalized.y, (float)normalized.z);
						if (transform.localScale == Vector3.zero)
						{
							transform.localScale = _currentScale;
						}
						velocitySpeed = (_currentPosition - _prePosition).magnitude / LogicDeltaTime;
					}
					if (!AdventureModuleController.sceneLimitZone.Contains(tsTransform.Position))
					{
						Finish(cancel: true);
					}
				}
				else
				{
					curState = State.AccMove;
					if (smooth != null)
					{
						smooth.dontSyncRotate = false;
					}
					FP x = ((target != null) ? target.tsTransform.Position.x : targetPos.x) - tsTransform.Position.x;
					FP y = ((target != null) ? target.tsTransform.Position.y : targetPos.z) - tsTransform.Position.y;
					velocityDirection = new TSVector2(x, y).normalized;
					tsTransform.Forward = velocityDirection;
					if (traceTarget)
					{
						traceCom.iActive = true;
					}
				}
			}
			else
			{
				escapedTime += logicDeltaTime;
				base.OnLogicUpdate();
			}
		}
	}

	private void CalTargetPos()
	{
		if (aimType == AimType.Target && target != null)
		{
			targetP = target.tsTransform.Position3D;
			targetBody = target.GetComponent<AnimationSlotConfigComponent>()?.bodySlot;
			if (targetBody != null)
			{
				targetP.y = targetBody.position.y;
			}
			targetPos = new TSVector(target.tsTransform.Position.x, targetP.y, target.tsTransform.Position.y);
		}
		else
		{
			targetP = new TSVector(targetPosition.x, targetPositionY, targetPosition.y);
			targetPos = new TSVector(targetPosition.x, targetPositionY, targetPosition.y);
		}
	}

	public override void Move(FP dt)
	{
		TSVector2 tSVector = velocity * dt;
		tsTransform.Position += tSVector;
		tsTransform.Forward = velocityDirection;
		if (!AdventureModuleController.sceneLimitZone.Contains(tsTransform.Position))
		{
			Finish(cancel: true);
		}
		else if (acceleratedVelocity != 0f && (startAccTime <= 0 || (startAccTime > 0 && escapedTime > startAccTime)))
		{
			velocitySpeed += acceleratedVelocity * dt;
			if ((acceleratedVelocity > 0f && velocitySpeed > borderVelocitySpeed) || (acceleratedVelocity < 0f && velocitySpeed < borderVelocitySpeed))
			{
				velocitySpeed = borderVelocitySpeed;
			}
		}
	}

	protected TSVector MoveByBezier(FP dt, TSVector targetPos)
	{
		return CommonHelper.GetBezier3PointByT(originP, controlP1, controlP2, targetPos, dt);
	}
}
