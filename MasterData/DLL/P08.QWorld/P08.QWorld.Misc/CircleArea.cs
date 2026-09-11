using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace P08.QWorld.Misc;

public class CircleArea : IAreaDistribution, IArea
{
	[SerializeField]
	private Bounds bounds;

	public void SetSize(Vector3 size)
	{
		bounds.size = size;
	}

	public Bounds WorldBounds(Transform trs)
	{
		return new Bounds(trs.TransformPoint(bounds.center), bounds.size);
	}

	public IEnumerable<Vector3> DistributeLocalPos(int cnt = 1)
	{
		for (int i = 0; i < cnt; i++)
		{
			Vector2 insideUnitCircle = Random.insideUnitCircle;
			yield return bounds.center + Vector3.Scale(new Vector3(insideUnitCircle.x, 0f, insideUnitCircle.y), bounds.extents);
		}
	}

	public IEnumerable<IAreaDistribution.PosRecord> DistributePos(Transform _, int cnt = 1)
	{
		return from pos in DistributeLocalPos(cnt)
			select new IAreaDistribution.PosRecord
			{
				position = pos,
				rotation = IAreaDistribution.RndLookRot()
			};
	}

	public IEnumerable<IAreaDistribution.PosRecord> DistributeWorldPos(Transform transform, int cnt = 1)
	{
		return from pos in DistributeLocalPos(cnt)
			select new IAreaDistribution.PosRecord
			{
				position = transform.TransformPoint(pos),
				rotation = IAreaDistribution.RndLookRot()
			};
	}

	public IEnumerable<Vector3> RndWorldPos(Transform trs, int cnt)
	{
		return from pos in DistributeLocalPos(cnt)
			select trs.TransformPoint(pos);
	}

	public bool IsInArea(Vector3 localPos)
	{
		float x = localPos.x;
		float z = localPos.z;
		float x2 = bounds.extents.x;
		float z2 = bounds.extents.z;
		float num = x / x2;
		float num2 = z / z2;
		return num * num + num2 * num2 <= 1f;
	}
}
