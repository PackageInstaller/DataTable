using UnityEngine;

public static class BoundsHelper
{
	public static Bounds TransformBounds(Bounds bounds, in Matrix4x4 matrix)
	{
		Bounds result = bounds;
		Vector4 vector = matrix.GetColumn(0) * bounds.min.x;
		Vector4 vector2 = matrix.GetColumn(0) * bounds.max.x;
		Vector4 vector3 = matrix.GetColumn(1) * bounds.min.y;
		Vector4 vector4 = matrix.GetColumn(1) * bounds.max.y;
		Vector4 vector5 = matrix.GetColumn(2) * bounds.min.z;
		Vector4 vector6 = matrix.GetColumn(2) * bounds.max.z;
		Vector4 column = matrix.GetColumn(3);
		result.SetMinMax(new Vector3
		{
			x = Mathf.Min(vector.x, vector2.x) + Mathf.Min(vector3.x, vector4.x) + Mathf.Min(vector5.x, vector6.x) + column.x,
			y = Mathf.Min(vector.y, vector2.y) + Mathf.Min(vector3.y, vector4.y) + Mathf.Min(vector5.y, vector6.y) + column.y,
			z = Mathf.Min(vector.z, vector2.z) + Mathf.Min(vector3.z, vector4.z) + Mathf.Min(vector5.z, vector6.z) + column.z
		}, new Vector3
		{
			x = Mathf.Max(vector.x, vector2.x) + Mathf.Max(vector3.x, vector4.x) + Mathf.Max(vector5.x, vector6.x) + column.x,
			y = Mathf.Max(vector.y, vector2.y) + Mathf.Max(vector3.y, vector4.y) + Mathf.Max(vector5.y, vector6.y) + column.y,
			z = Mathf.Max(vector.z, vector2.z) + Mathf.Max(vector3.z, vector4.z) + Mathf.Max(vector5.z, vector6.z) + column.z
		});
		return result;
	}
}
