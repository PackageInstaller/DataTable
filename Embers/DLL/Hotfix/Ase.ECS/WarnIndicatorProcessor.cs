using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class WarnIndicatorProcessor
{
	public static WarningIndicatorShapeData ProcessWarnIndicatorRect(float length, float width)
	{
		RectWarningIndicatorShapeData rectWarningIndicatorShapeData = ReferencePool.Acquire<RectWarningIndicatorShapeData>();
		rectWarningIndicatorShapeData.length = length;
		rectWarningIndicatorShapeData.width = width;
		rectWarningIndicatorShapeData.ShapeEnum = WarningIndicatorShapeEnum.Rect;
		return rectWarningIndicatorShapeData;
	}

	public static WarningIndicatorShapeData ProcessWarnIndicatorCircle(float radius, float warnRingAngle)
	{
		CircleWarningIndicatorShapeData circleWarningIndicatorShapeData = ReferencePool.Acquire<CircleWarningIndicatorShapeData>();
		circleWarningIndicatorShapeData.Radius = radius;
		circleWarningIndicatorShapeData.warnRingAngle = warnRingAngle;
		circleWarningIndicatorShapeData.ShapeEnum = WarningIndicatorShapeEnum.Circle;
		return circleWarningIndicatorShapeData;
	}

	public static WarningIndicatorShapeData ProcessWarnIndicatorRing(float inSideRadius, float outSideRadius, float warnRingAngle)
	{
		RingWarningIndicatorShapeData ringWarningIndicatorShapeData = ReferencePool.Acquire<RingWarningIndicatorShapeData>();
		ringWarningIndicatorShapeData.outSideRadius = outSideRadius;
		ringWarningIndicatorShapeData.inSideRadius = inSideRadius;
		ringWarningIndicatorShapeData.warnRingAngle = warnRingAngle;
		ringWarningIndicatorShapeData.ShapeEnum = WarningIndicatorShapeEnum.Ring;
		return ringWarningIndicatorShapeData;
	}

	public static WarningIndicatorTimeData ProcessWarnIndicatorTime(float delayLifeTimer, float fillTimer, float delayDiffuse, float diffuseTimer)
	{
		WarningIndicatorTimeData warningIndicatorTimeData = ReferencePool.Acquire<WarningIndicatorTimeData>();
		warningIndicatorTimeData.delayLifeTimer = delayLifeTimer;
		warningIndicatorTimeData.delayDiffuseTimer = delayDiffuse;
		warningIndicatorTimeData.fillTimer = fillTimer;
		warningIndicatorTimeData.diffuseTimer = diffuseTimer;
		return warningIndicatorTimeData;
	}

	public static WarningIndicatorCommonData ProcessWarnIndicatorCommonData(Vector3 initPos, float initAngle, BaseEntity creator, bool isRelativeAngle, bool isRelativePosition, Vector3 positionOffset, float angleOffset, bool skillStop, Color chargingColor, Color finishedColor)
	{
		WarningIndicatorCommonData warningIndicatorCommonData = ReferencePool.Acquire<WarningIndicatorCommonData>();
		warningIndicatorCommonData.InitPos = initPos;
		warningIndicatorCommonData.InitAngle = initAngle;
		warningIndicatorCommonData.Creator = creator;
		warningIndicatorCommonData.IsRelativeAngle = isRelativeAngle;
		warningIndicatorCommonData.IsRelativePosition = isRelativePosition;
		warningIndicatorCommonData.PositionOffset = positionOffset;
		warningIndicatorCommonData.AngleOffset = angleOffset;
		warningIndicatorCommonData.SkillStop = skillStop;
		warningIndicatorCommonData.ChargingColor = chargingColor;
		warningIndicatorCommonData.FinishedColor = finishedColor;
		return warningIndicatorCommonData;
	}

	public static WarningIndicatorData ProcessWarnIndicator<T>(WarningIndicatorShapeData shapeData, WarningIndicatorTimeData timeData, WarningIndicatorCommonData commonData) where T : WarningIndicatorData
	{
		IReference reference = ReferencePool.Acquire(typeof(T));
		if (reference is WarningIndicatorData warningIndicatorData)
		{
			warningIndicatorData.Make(shapeData, timeData, commonData);
		}
		return reference as T;
	}
}
