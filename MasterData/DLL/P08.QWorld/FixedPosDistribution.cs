using System.Collections.Generic;
using System.Linq;
using P08.QWorld.Misc;
using UnityEngine;

public class FixedPosDistribution : IAreaDistribution
{
	public IAreaDistribution.PosRecord[] posRecords;

	public int Count
	{
		get
		{
			IAreaDistribution.PosRecord[] array = posRecords;
			if (array == null)
			{
				return 0;
			}
			return array.Length;
		}
	}

	private IAreaDistribution.PosRecord AddPosByTrs(Transform trs)
	{
		return new IAreaDistribution.PosRecord(trs);
	}

	private Bounds GetNpcPosBound(IAreaDistribution.PosRecord record)
	{
		return new Bounds(record.position + 0.6f * Vector3.up, new Vector3(1.2f, 1.2f, 1.2f));
	}

	public Bounds WorldBounds(Transform trs)
	{
		IEnumerable<IAreaDistribution.PosRecord> enumerable = posRecords;
		IEnumerable<IAreaDistribution.PosRecord> source = enumerable ?? Enumerable.Empty<IAreaDistribution.PosRecord>();
		if (!source.Any())
		{
			return QWorldLODControlledLogicScheduler.INVALID_BOUNDS;
		}
		return source.Select(GetNpcPosBound).Aggregate(delegate(Bounds a, Bounds b)
		{
			a.Encapsulate(b);
			return a;
		});
	}

	public IEnumerable<IAreaDistribution.PosRecord> DistributePos(Transform trs, int cnt)
	{
		return from pos in DistributeWorldPos(trs, cnt)
			select new IAreaDistribution.PosRecord
			{
				position = trs.InverseTransformPoint(pos.position),
				rotation = Quaternion.Inverse(trs.rotation) * pos.rotation
			};
	}

	public IEnumerable<IAreaDistribution.PosRecord> DistributeWorldPos(Transform trs, int cnt)
	{
		int a = cnt;
		IAreaDistribution.PosRecord[] array = posRecords;
		cnt = Mathf.Min(a, (array != null) ? array.Length : 0);
		for (int i = 0; i < cnt; i++)
		{
			yield return posRecords[i];
		}
	}

	public void SetSize(Vector3 size)
	{
	}

	public IEnumerable<Vector3> RndWorldPos(Transform trs, int cnt)
	{
		Bounds bounds = WorldBounds(trs);
		for (int i = 0; i < cnt; i++)
		{
			Vector2 insideUnitCircle = Random.insideUnitCircle;
			yield return bounds.center + Vector3.Scale(new Vector3(insideUnitCircle.x, 0f, insideUnitCircle.y), bounds.extents);
		}
	}
}
