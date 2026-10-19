using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI.AOT;

public class RoundedRawImage : RawImage
{
	private const int MaxTriangleNum = 20;

	private const int MinTriangleNum = 1;

	[Tooltip("圆角半径")]
	public float Radius = 20f;

	[Range(1f, 20f)]
	public int TriangleNum = 5;

	protected override void OnPopulateMesh(VertexHelper vh)
	{
		Texture texture = mainTexture;
		vh.Clear();
		Color color = this.color;
		Rect pixelAdjustedRect = GetPixelAdjustedRect();
		Vector4 vector = new Vector4(pixelAdjustedRect.x, pixelAdjustedRect.y, pixelAdjustedRect.x + pixelAdjustedRect.width, pixelAdjustedRect.y + pixelAdjustedRect.height);
		float num = ((texture == null) ? 0f : ((float)texture.width * texture.texelSize.x));
		float num2 = ((texture == null) ? 0f : ((float)texture.height * texture.texelSize.y));
		Vector4 vector2 = new Vector4(uvRect.xMin * num, uvRect.yMin * num2, uvRect.xMax * num, uvRect.yMax * num2);
		float num3 = Radius;
		if (num3 > (vector.z - vector.x) / 2f)
		{
			num3 = (vector.z - vector.x) / 2f;
		}
		if (num3 > (vector.w - vector.y) / 2f)
		{
			num3 = (vector.w - vector.y) / 2f;
		}
		if (num3 < 0f)
		{
			num3 = 0f;
		}
		float num4 = num3 / (vector.z - vector.x);
		float num5 = num3 / (vector.w - vector.y);
		vh.AddVert(new Vector3(vector.x, vector.w - num3), color, new Vector2(vector2.x, vector2.w - num5));
		vh.AddVert(new Vector3(vector.x, vector.y + num3), color, new Vector2(vector2.x, vector2.y + num5));
		vh.AddVert(new Vector3(vector.x + num3, vector.w), color, new Vector2(vector2.x + num4, vector2.w));
		vh.AddVert(new Vector3(vector.x + num3, vector.w - num3), color, new Vector2(vector2.x + num4, vector2.w - num5));
		vh.AddVert(new Vector3(vector.x + num3, vector.y + num3), color, new Vector2(vector2.x + num4, vector2.y + num5));
		vh.AddVert(new Vector3(vector.x + num3, vector.y), color, new Vector2(vector2.x + num4, vector2.y));
		vh.AddVert(new Vector3(vector.z - num3, vector.w), color, new Vector2(vector2.z - num4, vector2.w));
		vh.AddVert(new Vector3(vector.z - num3, vector.w - num3), color, new Vector2(vector2.z - num4, vector2.w - num5));
		vh.AddVert(new Vector3(vector.z - num3, vector.y + num3), color, new Vector2(vector2.z - num4, vector2.y + num5));
		vh.AddVert(new Vector3(vector.z - num3, vector.y), color, new Vector2(vector2.z - num4, vector2.y));
		vh.AddVert(new Vector3(vector.z, vector.w - num3), color, new Vector2(vector2.z, vector2.w - num5));
		vh.AddVert(new Vector3(vector.z, vector.y + num3), color, new Vector2(vector2.z, vector2.y + num5));
		vh.AddTriangle(1, 0, 3);
		vh.AddTriangle(1, 3, 4);
		vh.AddTriangle(5, 2, 6);
		vh.AddTriangle(5, 6, 9);
		vh.AddTriangle(8, 7, 10);
		vh.AddTriangle(8, 10, 11);
		List<Vector2> list = new List<Vector2>();
		List<Vector2> list2 = new List<Vector2>();
		List<int> list3 = new List<int>();
		list.Add(new Vector2(vector.z - num3, vector.w - num3));
		list2.Add(new Vector2(vector2.z - num4, vector2.w - num5));
		list3.Add(7);
		list.Add(new Vector2(vector.x + num3, vector.w - num3));
		list2.Add(new Vector2(vector2.x + num4, vector2.w - num5));
		list3.Add(3);
		list.Add(new Vector2(vector.x + num3, vector.y + num3));
		list2.Add(new Vector2(vector2.x + num4, vector2.y + num5));
		list3.Add(4);
		list.Add(new Vector2(vector.z - num3, vector.y + num3));
		list2.Add(new Vector2(vector2.z - num4, vector2.y + num5));
		list3.Add(8);
		float num6 = MathF.PI / 2f / (float)TriangleNum;
		float num7 = 0f;
		for (int i = 0; i < list3.Count; i++)
		{
			int currentVertCount = vh.currentVertCount;
			for (int j = 0; j <= TriangleNum; j++)
			{
				float num8 = Mathf.Cos(num7);
				float num9 = Mathf.Sin(num7);
				Vector3 position = new Vector3(list[i].x + num8 * num3, list[i].y + num9 * num3);
				Vector3 vector3 = new Vector2(list2[i].x + num8 * num4, list2[i].y + num9 * num5);
				vh.AddVert(position, color, vector3);
				num7 += num6;
			}
			num7 -= num6;
			for (int k = 0; k <= TriangleNum - 1; k++)
			{
				vh.AddTriangle(list3[i], currentVertCount + k + 1, currentVertCount + k);
			}
		}
	}
}
