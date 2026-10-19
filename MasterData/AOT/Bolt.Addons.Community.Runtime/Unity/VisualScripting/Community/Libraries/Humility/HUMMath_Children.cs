using System;
using System.Collections.Generic;
using UnityEngine;

namespace Unity.VisualScripting.Community.Libraries.Humility;

public static class HUMMath_Children
{
	public static Rect[,] Grid(this HUMMath.Data.SplitInto into, int columns, int rows)
	{
		float num = into.split.rect.height / (float)rows;
		float num2 = into.split.rect.width / (float)columns;
		Rect[,] array = (Rect[,])Array.CreateInstance(typeof(Rect), columns, rows);
		for (int i = 0; i < columns; i++)
		{
			for (int j = 0; j < rows; j++)
			{
				Rect rect = new Rect(into.split.rect.x + num2 * (float)i, into.split.rect.y + num * (float)j, num2, num);
				array[i, j] = rect;
			}
		}
		return array;
	}

	public static Rect[] Rows(this HUMMath.Data.SplitInto into, int count)
	{
		float num = into.split.rect.width / (float)count;
		List<Rect> list = new List<Rect>();
		for (int i = 0; i < count; i++)
		{
			Rect item = new Rect(into.split.rect.x + num * (float)i, into.split.rect.y, num, into.split.rect.height);
			list.Add(item);
		}
		return list.ToArray();
	}

	public static Rect[] Columns(this HUMMath.Data.SplitInto into, int count)
	{
		float num = into.split.rect.height / (float)count;
		List<Rect> list = new List<Rect>();
		for (int i = 0; i < count; i++)
		{
			Rect item = new Rect(into.split.rect.x, into.split.rect.y + num * (float)i, into.split.rect.width, num);
			list.Add(item);
		}
		return list.ToArray();
	}

	public static Rect Position(this HUMMath.Data.AddRect A, Vector2 B)
	{
		Rect rect = A.rect;
		rect.x += B.x;
		rect.y += B.y;
		return rect;
	}

	public static Rect Position(this HUMMath.Data.AddRect A, float B)
	{
		Rect rect = A.rect;
		rect.x += B;
		rect.y += B;
		return rect;
	}

	public static Rect Size(this HUMMath.Data.AddRect A, Vector2 B)
	{
		Rect rect = A.rect;
		rect.width += B.x;
		rect.height += B.y;
		return rect;
	}

	public static Rect Size(this HUMMath.Data.AddRect A, float B)
	{
		Rect rect = A.rect;
		rect.width += B;
		rect.height += B;
		return rect;
	}

	public static Rect Position(this HUMMath.Data.SubtractRect A, Vector2 B)
	{
		Rect rect = A.rect;
		rect.x -= B.x;
		rect.y -= B.y;
		return rect;
	}

	public static Rect Position(this HUMMath.Data.SubtractRect A, float B)
	{
		Rect rect = A.rect;
		rect.x -= B;
		rect.y -= B;
		return rect;
	}

	public static Rect Size(this HUMMath.Data.SubtractRect A, Vector2 B)
	{
		Rect rect = A.rect;
		rect.width -= B.x;
		rect.height -= B.y;
		return rect;
	}

	public static Rect Size(this HUMMath.Data.SubtractRect A, float B)
	{
		Rect rect = A.rect;
		rect.width -= B;
		rect.height -= B;
		return rect;
	}

	public static Rect Position(this HUMMath.Data.DivideRect A, Vector2 B)
	{
		Rect rect = A.rect;
		rect.x /= B.x;
		rect.y /= B.y;
		return rect;
	}

	public static Rect Position(this HUMMath.Data.DivideRect A, float B)
	{
		Rect rect = A.rect;
		rect.x /= B;
		rect.y /= B;
		return rect;
	}

	public static Rect Size(this HUMMath.Data.DivideRect A, Vector2 B)
	{
		Rect rect = A.rect;
		rect.width /= B.x;
		rect.height /= B.y;
		return rect;
	}

	public static Rect Size(this HUMMath.Data.DivideRect A, float B)
	{
		Rect rect = A.rect;
		rect.width /= B;
		rect.height /= B;
		return rect;
	}

	public static Rect Position(this HUMMath.Data.MultiplyRect A, Vector2 B)
	{
		Rect rect = A.rect;
		rect.x *= B.x;
		rect.y *= B.y;
		return rect;
	}

	public static Rect Position(this HUMMath.Data.MultiplyRect A, float B)
	{
		Rect rect = A.rect;
		rect.x *= B;
		rect.y *= B;
		return rect;
	}

	public static Rect Size(this HUMMath.Data.MultiplyRect A, Vector2 B)
	{
		Rect rect = A.rect;
		rect.width *= B.x;
		rect.height *= B.y;
		return rect;
	}

	public static Rect Size(this HUMMath.Data.MultiplyRect A, float B)
	{
		Rect rect = A.rect;
		rect.width *= B;
		rect.height *= B;
		return rect;
	}

	public static Rect X(this HUMMath.Data.AddRect add, float value)
	{
		return add.rect.Add(new Rect(value, 0f, 0f, 0f));
	}

	public static Rect Y(this HUMMath.Data.AddRect add, float value)
	{
		return add.rect.Add(new Rect(0f, value, 0f, 0f));
	}

	public static Rect Width(this HUMMath.Data.AddRect add, float value)
	{
		return add.rect.Add(new Rect(0f, 0f, value, 0f));
	}

	public static Rect Height(this HUMMath.Data.AddRect add, float value)
	{
		return add.rect.Add(new Rect(0f, 0f, 0f, value));
	}

	public static Rect X(this HUMMath.Data.SubtractRect subtract, float value)
	{
		return subtract.rect.Subtract(new Rect(value, 0f, 0f, 0f));
	}

	public static Rect Y(this HUMMath.Data.SubtractRect subtract, float value)
	{
		return subtract.rect.Subtract(new Rect(0f, value, 0f, 0f));
	}

	public static Rect Width(this HUMMath.Data.SubtractRect subtract, float value)
	{
		return subtract.rect.Subtract(new Rect(0f, 0f, value, 0f));
	}

	public static Rect Height(this HUMMath.Data.SubtractRect subtract, float value)
	{
		return subtract.rect.Subtract(new Rect(0f, 0f, 0f, value));
	}

	public static Rect X(this HUMMath.Data.MultiplyRect multiply, float value)
	{
		return multiply.rect.Multiply(new Rect(value, 0f, 0f, 0f));
	}

	public static Rect Y(this HUMMath.Data.MultiplyRect multiply, float value)
	{
		return multiply.rect.Multiply(new Rect(0f, value, 0f, 0f));
	}

	public static Rect Width(this HUMMath.Data.MultiplyRect multiply, float value)
	{
		return multiply.rect.Multiply(new Rect(0f, 0f, value, 0f));
	}

	public static Rect Height(this HUMMath.Data.MultiplyRect multiply, float value)
	{
		return multiply.rect.Multiply(new Rect(0f, 0f, 0f, value));
	}

	public static Rect X(this HUMMath.Data.DivideRect divide, float value)
	{
		return divide.rect.Subtract(new Rect(value, 0f, 0f, 0f));
	}

	public static Rect Y(this HUMMath.Data.DivideRect divide, float value)
	{
		return divide.rect.Subtract(new Rect(0f, value, 0f, 0f));
	}

	public static Rect Width(this HUMMath.Data.DivideRect divide, float value)
	{
		return divide.rect.Divide(new Rect(0f, 0f, value, 0f));
	}

	public static Rect Height(this HUMMath.Data.DivideRect divide, float value)
	{
		return divide.rect.Subtract(new Rect(0f, 0f, 0f, value));
	}

	public static Rect X(this HUMMath.Data.SetRect set, float value)
	{
		return new Rect(value, set.rect.y, set.rect.width, set.rect.height);
	}

	public static Rect Y(this HUMMath.Data.SetRect set, float value)
	{
		return new Rect(set.rect.x, value, set.rect.width, set.rect.height);
	}

	public static Rect Width(this HUMMath.Data.SetRect set, float value)
	{
		return new Rect(set.rect.x, set.rect.y, value, set.rect.height);
	}

	public static Rect Height(this HUMMath.Data.SetRect set, float value)
	{
		return new Rect(set.rect.x, set.rect.y, set.rect.width, value);
	}

	public static Vector3 X(this HUMMath.Data.SetVector3 set, float value)
	{
		return set.vector.Add(new Vector3(value, 0f, 0f));
	}

	public static Vector3 Y(this HUMMath.Data.SetVector3 set, float value)
	{
		return set.vector.Add(new Vector3(0f, value, 0f));
	}

	public static Vector3 Z(this HUMMath.Data.SetVector3 set, float value)
	{
		return set.vector.Add(new Vector3(0f, 0f, value));
	}

	public static Vector2 X(this HUMMath.Data.SetVector2 set, float value)
	{
		return set.vector.Add(new Vector2(value, 0f));
	}

	public static Vector2 Y(this HUMMath.Data.SetVector2 set, float value)
	{
		return set.vector.Add(new Vector2(0f, value));
	}
}
