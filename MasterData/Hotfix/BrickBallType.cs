using UnityEngine;

public enum BrickBallType
{
	[InspectorName("普通球")]
	Normal,
	[InspectorName("火焰球")]
	Fire,
	[InspectorName("炸弹球")]
	Boom,
	[InspectorName("横激光球")]
	HorizontalLaser,
	[InspectorName("纵激光球")]
	VerticalLaser,
	[InspectorName("闪电球")]
	Lightning,
	[InspectorName("十字激光球")]
	CrossLaser,
	[InspectorName("闪电横激光球")]
	LightningHorizontalLaser,
	[InspectorName("闪电纵激光球")]
	LightningVerticalLaser
}
