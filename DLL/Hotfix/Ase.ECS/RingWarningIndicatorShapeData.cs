using UnityEngine;

namespace Ase.ECS;

public class RingWarningIndicatorShapeData : WarningIndicatorShapeData
{
	public float warnRingAngle;

	private float _inSideRadius;

	private float _outSideRadius;

	public float inSideRadius
	{
		get
		{
			return _inSideRadius / _outSideRadius;
		}
		set
		{
			_inSideRadius = value;
		}
	}

	public float outSideRadius
	{
		get
		{
			return _outSideRadius * 2f;
		}
		set
		{
			_outSideRadius = value;
		}
	}

	public override void Init(WarningIndicatorTimeData timeData)
	{
		base.scale = new Vector3(outSideRadius, 5f, outSideRadius);
	}

	public override void Clear()
	{
		warnRingAngle = 0f;
		inSideRadius = 0f;
		outSideRadius = 0f;
	}
}
