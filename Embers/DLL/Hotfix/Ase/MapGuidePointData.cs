using UnityEngine;

namespace Ase;

public class MapGuidePointData
{
	public InteractivePoint.PointInfo PointInfo;

	public int TypePriority;

	public float Angle;

	public Vector2 ShowPos;

	public float Distance;

	public MapGuidePointData()
	{
	}

	public MapGuidePointData(InteractivePoint.PointInfo pointInfo, float angle, Vector2 showPos, float distance)
	{
		PointInfo = pointInfo;
		Angle = angle;
		ShowPos = showPos;
		Distance = distance;
		TypePriority = InteractivePoint.GetPointIconPriority(pointInfo.PointType);
	}

	public bool Equal(MapGuidePointData data)
	{
		return PointInfo.Equal(data.PointInfo);
	}
}
