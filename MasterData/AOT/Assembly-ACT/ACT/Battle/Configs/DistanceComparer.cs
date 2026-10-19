using UnityEngine;

namespace ACT.Battle.Configs;

public class DistanceComparer : TargetResultComparer
{
	public enum DistanceAxisPriority
	{
		None,
		X,
		Y
	}

	[Tooltip("按参考位置到目标 SourcePosition 的 X/Y 距离优先；相同后回退总距离")]
	public DistanceAxisPriority axisPriority;

	private Vector3 referencePosition;

	public void SetReferencePosition(Vector3 position)
	{
		referencePosition = position;
	}

	private float GetAxisSqrDistance(FindTargetResult target, bool useX)
	{
		if (!target.IsValid)
		{
			return float.MaxValue;
		}
		Vector3 vector = target.SourcePosition - referencePosition;
		float num = (useX ? vector.x : vector.y);
		return num * num;
	}

	public override int Compare(FindTargetResult x, FindTargetResult y)
	{
		if (axisPriority != DistanceAxisPriority.None)
		{
			int num = GetAxisSqrDistance(x, axisPriority == DistanceAxisPriority.X).CompareTo(GetAxisSqrDistance(y, axisPriority == DistanceAxisPriority.X));
			if (num != 0)
			{
				return num;
			}
		}
		return x.sqrDis.CompareTo(y.sqrDis);
	}
}
