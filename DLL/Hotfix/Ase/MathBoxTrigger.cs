using UnityEngine;

namespace Ase;

public class MathBoxTrigger : MathTriggerBase
{
	[SerializeField]
	private Vector3 _size = Vector3.one;

	private Matrix4x4 matrix;

	private Matrix4x4 inverseMatrix;

	private Vector3 localPoint;

	private Vector3 scaledSize;

	private Bounds cachedBounds;

	private Vector3[] aabbCorners = new Vector3[9];

	private Vector3 _lastPosition = Vector3.zero;

	private Quaternion _lastRotation = Quaternion.identity;

	private Vector3 _lastScale = Vector3.zero;

	public Vector3 size
	{
		get
		{
			return _size;
		}
		set
		{
			_size = value;
		}
	}

	private void CalculateMatrix()
	{
		Vector3 vector = base.Position + base.center;
		Quaternion rotation = base.Rotation;
		if (_lastPosition != vector || _lastRotation != rotation)
		{
			_lastPosition = vector;
			_lastRotation = rotation;
			matrix = Matrix4x4.TRS(_lastPosition, _lastRotation, Vector3.one);
			inverseMatrix = matrix.inverse;
		}
		Vector3 scale = base.Scale;
		if (_lastScale != scale)
		{
			_lastScale = scale;
			scaledSize = Vector3.Scale(size, _lastScale);
		}
	}

	protected override void OnInit()
	{
		CalculateMatrix();
		cachedBounds = CalculateRotatedBounds();
	}

	public override bool Contains(Vector3 point)
	{
		if (base.Dynamic)
		{
			CalculateMatrix();
		}
		localPoint = inverseMatrix.MultiplyPoint3x4(point);
		if (Mathf.Abs(localPoint.x) <= scaledSize.x * 0.5f && Mathf.Abs(localPoint.y) <= scaledSize.y * 0.5f)
		{
			return Mathf.Abs(localPoint.z) <= scaledSize.z * 0.5f;
		}
		return false;
	}

	public override bool Intersects(Bounds bounds)
	{
		Vector3 min = bounds.min;
		Vector3 max = bounds.max;
		int num = 0;
		for (int i = 0; i <= 1; i++)
		{
			for (int j = 0; j <= 1; j++)
			{
				for (int k = 0; k <= 1; k++)
				{
					aabbCorners[num++] = new Vector3((i == 0) ? min.x : max.x, (j == 0) ? min.y : max.y, (k == 0) ? min.z : max.z);
				}
			}
		}
		aabbCorners[num++] = bounds.center;
		Vector3[] array = aabbCorners;
		foreach (Vector3 point in array)
		{
			if (Contains(point))
			{
				return true;
			}
		}
		return false;
	}

	public override Bounds Bounds()
	{
		return cachedBounds;
	}

	private Bounds CalculateRotatedBounds()
	{
		Bounds bounds = new Bounds(Vector3.zero, scaledSize);
		Vector3[] localCorners = GetLocalCorners(bounds);
		Vector3[] array = new Vector3[8];
		for (int i = 0; i < 8; i++)
		{
			array[i] = matrix.MultiplyPoint3x4(localCorners[i]);
		}
		Vector3 vector = array[0];
		Vector3 vector2 = array[0];
		for (int j = 1; j < 8; j++)
		{
			vector = Vector3.Min(vector, array[j]);
			vector2 = Vector3.Max(vector2, array[j]);
		}
		return new Bounds((vector + vector2) * 0.5f, vector2 - vector);
	}

	private Vector3[] GetLocalCorners(Bounds bounds)
	{
		Vector3[] array = new Vector3[8];
		Vector3 extents = bounds.extents;
		array[0] = new Vector3(0f - extents.x, 0f - extents.y, 0f - extents.z);
		array[1] = new Vector3(extents.x, 0f - extents.y, 0f - extents.z);
		array[2] = new Vector3(0f - extents.x, extents.y, 0f - extents.z);
		array[3] = new Vector3(extents.x, extents.y, 0f - extents.z);
		array[4] = new Vector3(0f - extents.x, 0f - extents.y, extents.z);
		array[5] = new Vector3(extents.x, 0f - extents.y, extents.z);
		array[6] = new Vector3(0f - extents.x, extents.y, extents.z);
		array[7] = new Vector3(extents.x, extents.y, extents.z);
		return array;
	}

	protected override void OnDrawGizmosSelected()
	{
		base.OnDrawGizmosSelected();
		Matrix4x4 matrix4x = Gizmos.matrix;
		Gizmos.matrix = Matrix4x4.TRS(base.Position + base.center, base.Rotation, base.Scale);
		Gizmos.color = Color.green;
		Gizmos.DrawWireCube(Vector3.zero, size);
		Gizmos.matrix = matrix4x;
	}

	public void UpdateBounds()
	{
		CalculateMatrix();
		cachedBounds = CalculateRotatedBounds();
	}
}
