using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Sprites;
using UnityEngine.UI;

namespace ACT.UI.AOT;

public class RoundedImage : Image
{
	private const int MaxTriangleNum = 20;

	private const int MinTriangleNum = 1;

	public float Radius;

	[Range(1f, 20f)]
	public int TriangleNum;

	protected override void OnPopulateMesh(VertexHelper vh)
	{
		Vector4 drawingDimensions = GetDrawingDimensions(shouldPreserveAspect: false);
		Vector4 vector = ((overrideSprite != null) ? DataUtility.GetOuterUV(overrideSprite) : Vector4.zero);
		Color color = this.color;
		vh.Clear();
		float num = Radius;
		if (num > (drawingDimensions.z - drawingDimensions.x) / 2f)
		{
			num = (drawingDimensions.z - drawingDimensions.x) / 2f;
		}
		if (num > (drawingDimensions.w - drawingDimensions.y) / 2f)
		{
			num = (drawingDimensions.w - drawingDimensions.y) / 2f;
		}
		if (num < 0f)
		{
			num = 0f;
		}
		float num2 = num / (drawingDimensions.z - drawingDimensions.x);
		float num3 = num / (drawingDimensions.w - drawingDimensions.y);
		vh.AddVert(new Vector3(drawingDimensions.x, drawingDimensions.w - num), color, new Vector2(vector.x, vector.w - num3));
		vh.AddVert(new Vector3(drawingDimensions.x, drawingDimensions.y + num), color, new Vector2(vector.x, vector.y + num3));
		vh.AddVert(new Vector3(drawingDimensions.x + num, drawingDimensions.w), color, new Vector2(vector.x + num2, vector.w));
		vh.AddVert(new Vector3(drawingDimensions.x + num, drawingDimensions.w - num), color, new Vector2(vector.x + num2, vector.w - num3));
		vh.AddVert(new Vector3(drawingDimensions.x + num, drawingDimensions.y + num), color, new Vector2(vector.x + num2, vector.y + num3));
		vh.AddVert(new Vector3(drawingDimensions.x + num, drawingDimensions.y), color, new Vector2(vector.x + num2, vector.y));
		vh.AddVert(new Vector3(drawingDimensions.z - num, drawingDimensions.w), color, new Vector2(vector.z - num2, vector.w));
		vh.AddVert(new Vector3(drawingDimensions.z - num, drawingDimensions.w - num), color, new Vector2(vector.z - num2, vector.w - num3));
		vh.AddVert(new Vector3(drawingDimensions.z - num, drawingDimensions.y + num), color, new Vector2(vector.z - num2, vector.y + num3));
		vh.AddVert(new Vector3(drawingDimensions.z - num, drawingDimensions.y), color, new Vector2(vector.z - num2, vector.y));
		vh.AddVert(new Vector3(drawingDimensions.z, drawingDimensions.w - num), color, new Vector2(vector.z, vector.w - num3));
		vh.AddVert(new Vector3(drawingDimensions.z, drawingDimensions.y + num), color, new Vector2(vector.z, vector.y + num3));
		vh.AddTriangle(1, 0, 3);
		vh.AddTriangle(1, 3, 4);
		vh.AddTriangle(5, 2, 6);
		vh.AddTriangle(5, 6, 9);
		vh.AddTriangle(8, 7, 10);
		vh.AddTriangle(8, 10, 11);
		List<Vector2> list = new List<Vector2>();
		List<Vector2> list2 = new List<Vector2>();
		List<int> list3 = new List<int>();
		list.Add(new Vector2(drawingDimensions.z - num, drawingDimensions.w - num));
		list2.Add(new Vector2(vector.z - num2, vector.w - num3));
		list3.Add(7);
		list.Add(new Vector2(drawingDimensions.x + num, drawingDimensions.w - num));
		list2.Add(new Vector2(vector.x + num2, vector.w - num3));
		list3.Add(3);
		list.Add(new Vector2(drawingDimensions.x + num, drawingDimensions.y + num));
		list2.Add(new Vector2(vector.x + num2, vector.y + num3));
		list3.Add(4);
		list.Add(new Vector2(drawingDimensions.z - num, drawingDimensions.y + num));
		list2.Add(new Vector2(vector.z - num2, vector.y + num3));
		list3.Add(8);
		float num4 = MathF.PI / 2f / (float)TriangleNum;
		float num5 = 0f;
		for (int i = 0; i < list3.Count; i++)
		{
			int currentVertCount = vh.currentVertCount;
			for (int j = 0; j <= TriangleNum; j++)
			{
				float num6 = Mathf.Cos(num5);
				float num7 = Mathf.Sin(num5);
				Vector3 position = new Vector3(list[i].x + num6 * num, list[i].y + num7 * num);
				Vector3 vector2 = new Vector2(list2[i].x + num6 * num2, list2[i].y + num7 * num3);
				vh.AddVert(position, color, vector2);
				num5 += num4;
			}
			num5 -= num4;
			for (int k = 0; k <= TriangleNum - 1; k++)
			{
				vh.AddTriangle(list3[i], currentVertCount + k + 1, currentVertCount + k);
			}
		}
	}

	private Vector4 GetDrawingDimensions(bool shouldPreserveAspect)
	{
		Vector4 vector = ((overrideSprite == null) ? Vector4.zero : DataUtility.GetPadding(overrideSprite));
		Rect pixelAdjustedRect = GetPixelAdjustedRect();
		Vector2 vector2 = ((overrideSprite == null) ? new Vector2(pixelAdjustedRect.width, pixelAdjustedRect.height) : new Vector2(overrideSprite.rect.width, overrideSprite.rect.height));
		int num = Mathf.RoundToInt(vector2.x);
		int num2 = Mathf.RoundToInt(vector2.y);
		if (shouldPreserveAspect && vector2.sqrMagnitude > 0f)
		{
			float num3 = vector2.x / vector2.y;
			float num4 = pixelAdjustedRect.width / pixelAdjustedRect.height;
			if (num3 > num4)
			{
				float height = pixelAdjustedRect.height;
				pixelAdjustedRect.height = pixelAdjustedRect.width * (1f / num3);
				pixelAdjustedRect.y += (height - pixelAdjustedRect.height) * rectTransform.pivot.y;
			}
			else
			{
				float width = pixelAdjustedRect.width;
				pixelAdjustedRect.width = pixelAdjustedRect.height * num3;
				pixelAdjustedRect.x += (width - pixelAdjustedRect.width) * rectTransform.pivot.x;
			}
		}
		Vector4 vector3 = new Vector4(vector.x / (float)num, vector.y / (float)num2, ((float)num - vector.z) / (float)num, ((float)num2 - vector.w) / (float)num2);
		return new Vector4(pixelAdjustedRect.x + pixelAdjustedRect.width * vector3.x, pixelAdjustedRect.y + pixelAdjustedRect.height * vector3.y, pixelAdjustedRect.x + pixelAdjustedRect.width * vector3.z, pixelAdjustedRect.y + pixelAdjustedRect.height * vector3.w);
	}
}
