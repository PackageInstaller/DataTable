using UnityEngine;

namespace Unity.VisualScripting.Community.Libraries.Humility;

public static class HUMEvents
{
	public static class Data
	{
		public struct Is(Mouse mouse)
		{
			public Mouse mouse = mouse;
		}

		public struct Clicked(Event e, Clicked.MouseButton mouseButton)
		{
			public enum MouseButton
			{
				Left,
				Middle,
				Right
			}

			public Event e = e;

			public MouseButton mouseButton = mouseButton;
		}

		public struct Mouse(Event e)
		{
			public Event e = e;
		}

		public struct Middle(Mouse mouse)
		{
			public Mouse mouse = mouse;
		}

		public struct DoubleLeft(Double @double)
		{
			public Double @double = @double;
		}

		public struct Left(Mouse mouse)
		{
			public Mouse mouse = mouse;
		}

		public struct Right(Mouse mouse)
		{
			public Mouse mouse = mouse;
		}

		public struct Top(Mouse mouse)
		{
			public Mouse mouse = mouse;
		}

		public struct Bottom(Mouse mouse)
		{
			public Mouse mouse = mouse;
		}

		public struct Double(Mouse mouse)
		{
			public Mouse mouse = mouse;
		}

		public struct RightResizer(Right right)
		{
			public Right right = right;
		}

		public struct LeftResizer(Left left)
		{
			public Left left = left;
		}

		public struct TopResizer(Top top)
		{
			public Top top = top;
		}

		public struct BottomResizer(Bottom bottom)
		{
			public Bottom bottom = bottom;
		}

		public struct Inside(Rect position, Mouse mouse)
		{
			public Rect position = position;

			public Mouse mouse = mouse;
		}
	}

	internal static int clickCount;

	public static Vector2 mouseDelta;

	public static Vector2 mousePosition;

	public static Data.Mouse Mouse(this Event e)
	{
		return new Data.Mouse(e);
	}
}
