using UnityEngine;

namespace Unity.VisualScripting.Community.Libraries.Humility;

public static class HUMEvents_Children
{
	public enum Side
	{
		Left,
		Right,
		Top,
		Bottom
	}

	public static float lastClickTime;

	public static Vector2 lastLeftClickPosition;

	public static Vector2 lastRightClickPosition;

	public static HUMEvents.Data.Is Is(this HUMEvents.Data.Mouse mouse)
	{
		return new HUMEvents.Data.Is(mouse);
	}

	public static bool Inside(this HUMEvents.Data.Is @is, Rect position)
	{
		return position.Contains(@is.mouse.e.mousePosition);
	}

	public static bool Released(this HUMEvents.Data.Left left)
	{
		HUMEvents.clickCount--;
		if (left.mouse.e.button == 0)
		{
			return left.mouse.e.type == EventType.MouseUp;
		}
		return false;
	}

	public static bool Released(this HUMEvents.Data.Middle middle)
	{
		HUMEvents.clickCount--;
		if (middle.mouse.e.button == 2)
		{
			return middle.mouse.e.type == EventType.MouseUp;
		}
		return false;
	}

	public static bool Released(this HUMEvents.Data.Right right)
	{
		HUMEvents.clickCount--;
		if (right.mouse.e.button == 1)
		{
			return right.mouse.e.type == EventType.MouseUp;
		}
		return false;
	}

	public static bool Clicked(this HUMEvents.Data.Left left)
	{
		HUMEvents.clickCount++;
		if (left.mouse.e.button == 0)
		{
			return left.mouse.e.type == EventType.MouseDown;
		}
		return false;
	}

	public static bool Clicked(this HUMEvents.Data.Middle middle)
	{
		HUMEvents.clickCount++;
		if (middle.mouse.e.button == 2)
		{
			return middle.mouse.e.type == EventType.MouseDown;
		}
		return false;
	}

	public static bool Clicked(this HUMEvents.Data.Right right)
	{
		HUMEvents.clickCount++;
		if (right.mouse.e.button == 1)
		{
			return right.mouse.e.type == EventType.MouseDown;
		}
		return false;
	}

	public static bool Clicked(this HUMEvents.Data.DoubleLeft left, float elapseTime)
	{
		if ((lastClickTime - Time.time) * -1f < elapseTime)
		{
			lastClickTime = Time.time;
			return true;
		}
		lastClickTime = Time.time;
		return false;
	}

	public static HUMEvents.Data.Double Double(this HUMEvents.Data.Mouse mouse)
	{
		return new HUMEvents.Data.Double(mouse);
	}

	public static HUMEvents.Data.Left Left(this HUMEvents.Data.Mouse mouse)
	{
		return new HUMEvents.Data.Left(mouse);
	}

	public static HUMEvents.Data.DoubleLeft Left(this HUMEvents.Data.Double @double)
	{
		return new HUMEvents.Data.DoubleLeft(@double);
	}

	public static HUMEvents.Data.Right Right(this HUMEvents.Data.Mouse mouse)
	{
		return new HUMEvents.Data.Right(mouse);
	}

	public static HUMEvents.Data.Top Top(this HUMEvents.Data.Mouse mouse)
	{
		return new HUMEvents.Data.Top(mouse);
	}

	public static HUMEvents.Data.Bottom Bottom(this HUMEvents.Data.Mouse mouse)
	{
		return new HUMEvents.Data.Bottom(mouse);
	}
}
