using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器/线性子弹 3D")]
public class AdventureLinerBullet : AdventureBullet
{
	public bool isBezier;

	public float offsetX = 2f;

	public float offsetY = 2f;

	protected FP _distance;

	protected FP _startPositionY;

	protected FP _elapsedTime;

	private TSVector shootDir;

	private TSVector2 shoot2D;

	private FP shootYSpeed;

	private FP _offsetXFP;

	private FP _offsetYFP;

	private TSVector controlP;

	private TSVector targetP;

	private TSVector originP;

	public override bool isShowShadowBlob => true;

	protected override void OnInit()
	{
		base.OnInit();
		_offsetXFP = FP.FromConfigFloat(offsetX);
		_offsetYFP = FP.FromConfigFloat(offsetY);
	}

	public override void Reset(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP))
	{
		base.Reset(owner, position, positionY, direction, target, targetPosition, targetPositionY);
		_distance = TSVector2.Distance(originPosition, targetPosition);
		LiftTime = _distance / velocitySpeed;
		targetP = new TSVector(targetPosition.x, targetPositionY, targetPosition.y);
		originP = new TSVector(originPosition.x, positionY, originPosition.y);
		TSVector normalized = (targetP - originP).normalized;
		TSVector onUnitSphere = TSRandom.onUnitSphere;
		TSVector normalized2 = (onUnitSphere - TSVector.Dot(onUnitSphere, normalized) * normalized).normalized;
		controlP = originP + normalized * _offsetXFP + normalized2 * _offsetYFP;
		shootDir = new TSVector(targetPosition.x - position.x, targetPositionY - positionY, targetPosition.y - position.y).normalized;
		shoot2D.x = shootDir.x;
		shoot2D.y = shootDir.z;
		shootYSpeed = shootDir.y * velocitySpeed / shoot2D.magnitude;
		Motion();
		smooth.OnVisualUpdate();
	}

	public override void Move(FP dt)
	{
		if (isBezier)
		{
			FP t = _lifeTimer / LiftTime;
			TSVector bezierPointByT = CommonHelper.GetBezierPointByT(originP, controlP, targetP, t);
			tsTransform.Position = new TSVector2(bezierPointByT.x, bezierPointByT.z);
			tsTransform.PositionY = bezierPointByT.y;
			tsTransform.Forward = velocityDirection;
		}
		else
		{
			TSVector2 tSVector = velocity * dt;
			tsTransform.Position += tSVector;
			tsTransform.PositionY += shootYSpeed * dt;
			tsTransform.Forward = velocityDirection;
		}
		Motion();
	}

	protected void Motion()
	{
		float pitch = 0f - Vector2.SignedAngle(to: new Vector2((float)shoot2D.magnitude, (float)shootDir.y), from: new Vector2(1f, 0f));
		smooth.pitch = pitch;
	}
}
