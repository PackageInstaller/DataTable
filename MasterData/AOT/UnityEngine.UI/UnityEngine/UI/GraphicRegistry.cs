using System;
using System.Collections.Generic;
using UnityEngine.UI.Collections;

namespace UnityEngine.UI;

public class GraphicRegistry
{
	private static GraphicRegistry s_Instance;

	private readonly Dictionary<Canvas, IndexedSet<Graphic>> m_Graphics = new Dictionary<Canvas, IndexedSet<Graphic>>();

	private readonly Dictionary<Canvas, IndexedSet<Graphic>> m_RaycastableGraphics = new Dictionary<Canvas, IndexedSet<Graphic>>();

	private static readonly List<Graphic> s_EmptyList = new List<Graphic>();

	public static GraphicRegistry instance
	{
		get
		{
			if (s_Instance == null)
			{
				s_Instance = new GraphicRegistry();
			}
			return s_Instance;
		}
	}

	protected GraphicRegistry()
	{
		GC.KeepAlive(new Dictionary<Graphic, int>());
		GC.KeepAlive(new Dictionary<ICanvasElement, int>());
		GC.KeepAlive(new Dictionary<IClipper, int>());
	}

	public static void RegisterGraphicForCanvas(Canvas c, Graphic graphic)
	{
		if (!(c == null) && !(graphic == null))
		{
			instance.m_Graphics.TryGetValue(c, out var value);
			if (value != null)
			{
				value.AddUnique(graphic);
				RegisterRaycastGraphicForCanvas(c, graphic);
				return;
			}
			value = new IndexedSet<Graphic>();
			value.Add(graphic);
			instance.m_Graphics.Add(c, value);
			RegisterRaycastGraphicForCanvas(c, graphic);
		}
	}

	public static void RegisterRaycastGraphicForCanvas(Canvas c, Graphic graphic)
	{
		if (!(c == null) && !(graphic == null) && graphic.raycastTarget)
		{
			instance.m_RaycastableGraphics.TryGetValue(c, out var value);
			if (value != null)
			{
				value.AddUnique(graphic);
				return;
			}
			value = new IndexedSet<Graphic>();
			value.Add(graphic);
			instance.m_RaycastableGraphics.Add(c, value);
		}
	}

	public static void UnregisterGraphicForCanvas(Canvas c, Graphic graphic)
	{
		if (!(c == null) && !(graphic == null) && instance.m_Graphics.TryGetValue(c, out var value))
		{
			value.Remove(graphic);
			if (value.Capacity == 0)
			{
				instance.m_Graphics.Remove(c);
			}
			UnregisterRaycastGraphicForCanvas(c, graphic);
		}
	}

	public static void UnregisterRaycastGraphicForCanvas(Canvas c, Graphic graphic)
	{
		if (!(c == null) && !(graphic == null) && instance.m_RaycastableGraphics.TryGetValue(c, out var value))
		{
			value.Remove(graphic);
			if (value.Count == 0)
			{
				instance.m_RaycastableGraphics.Remove(c);
			}
		}
	}

	public static void DisableGraphicForCanvas(Canvas c, Graphic graphic)
	{
		if (!(c == null) && instance.m_Graphics.TryGetValue(c, out var value))
		{
			value.DisableItem(graphic);
			if (value.Capacity == 0)
			{
				instance.m_Graphics.Remove(c);
			}
			DisableRaycastGraphicForCanvas(c, graphic);
		}
	}

	public static void DisableRaycastGraphicForCanvas(Canvas c, Graphic graphic)
	{
		if (!(c == null) && graphic.raycastTarget && instance.m_RaycastableGraphics.TryGetValue(c, out var value))
		{
			value.DisableItem(graphic);
			if (value.Capacity == 0)
			{
				instance.m_RaycastableGraphics.Remove(c);
			}
		}
	}

	public static IList<Graphic> GetGraphicsForCanvas(Canvas canvas)
	{
		if (instance.m_Graphics.TryGetValue(canvas, out var value))
		{
			return value;
		}
		return s_EmptyList;
	}

	public static IList<Graphic> GetRaycastableGraphicsForCanvas(Canvas canvas)
	{
		if (instance.m_RaycastableGraphics.TryGetValue(canvas, out var value))
		{
			return value;
		}
		return s_EmptyList;
	}
}
