using UnityEngine;

namespace Ase.ECS;

public class RectWarningIndicatorShapeData : WarningIndicatorShapeData
{
	public float length;

	public float width;

	public override void Init(WarningIndicatorTimeData timeData)
	{
		base.scale = new Vector3(length, 3f, width);
	}

	public override void Clear()
	{
		length = 0f;
		width = 0f;
	}
}
