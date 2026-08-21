using UnityEngine;

namespace Ase.ECS;

public class CircleWarningIndicatorShapeData : WarningIndicatorShapeData
{
	private float _radius;

	public float warnRingAngle;

	public float Radius
	{
		get
		{
			return _radius * 2f;
		}
		set
		{
			_radius = value;
		}
	}

	public override void Init(WarningIndicatorTimeData timeData)
	{
		base.scale = new Vector3(Radius, 5f, Radius);
	}

	public override void Clear()
	{
		warnRingAngle = 0f;
		Radius = 0f;
	}
}
