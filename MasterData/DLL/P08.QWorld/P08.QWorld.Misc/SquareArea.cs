using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace P08.QWorld.Misc;

public class SquareArea : IAreaDistribution, IArea
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

	private IEnumerable<Vector3> DistributeLocalPos(int cnt)
	{
		for (int i = 0; i < cnt; i++)
		{
			float x = Random.value * 2f - 1f;
			float z = Random.value * 2f - 1f;
			yield return bounds.center + Vector3.Scale(new Vector3(x, 0f, z), bounds.extents);
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

	public bool IsInArea(Vector3 localPos)
	{
		localPos = new Vector3(localPos.x, bounds.center.y, localPos.z);
		return bounds.Contains(localPos);
	}

	public IEnumerable<Vector3> RndWorldPos(Transform trs, int cnt)
	{
		return from pos in DistributeLocalPos(cnt)
			select trs.TransformPoint(pos);
	}
}
