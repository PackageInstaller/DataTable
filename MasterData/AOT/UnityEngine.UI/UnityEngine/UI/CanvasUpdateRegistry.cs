using System;
using UnityEngine.UI.Collections;

namespace UnityEngine.UI;

public class CanvasUpdateRegistry
{
	private static CanvasUpdateRegistry s_Instance;

	private bool m_PerformingLayoutUpdate;

	private bool m_PerformingGraphicUpdate;

	private string[] m_CanvasUpdateProfilerStrings = new string[5] { "CanvasUpdate.Prelayout", "CanvasUpdate.Layout", "CanvasUpdate.PostLayout", "CanvasUpdate.PreRender", "CanvasUpdate.LatePreRender" };

	private const string m_CullingUpdateProfilerString = "ClipperRegistry.Cull";

	private readonly IndexedSet<ICanvasElement> m_LayoutRebuildQueue = new IndexedSet<ICanvasElement>();

	private readonly IndexedSet<ICanvasElement> m_GraphicRebuildQueue = new IndexedSet<ICanvasElement>();

	private static readonly Comparison<ICanvasElement> s_SortLayoutFunction = SortLayoutList;

	public static CanvasUpdateRegistry instance
	{
		get
		{
			if (s_Instance == null)
			{
				s_Instance = new CanvasUpdateRegistry();
			}
			return s_Instance;
		}
	}

	protected CanvasUpdateRegistry()
	{
		Canvas.willRenderCanvases += PerformUpdate;
	}

	private bool ObjectValidForUpdate(ICanvasElement element)
	{
		bool result = element != null;
		if (element is Object)
		{
			result = element as Object != null;
		}
		return result;
	}

	private void CleanInvalidItems()
	{
		for (int num = m_LayoutRebuildQueue.Count - 1; num >= 0; num--)
		{
			ICanvasElement canvasElement = m_LayoutRebuildQueue[num];
			if (canvasElement == null)
			{
				m_LayoutRebuildQueue.RemoveAt(num);
			}
			else if (canvasElement.IsDestroyed())
			{
				m_LayoutRebuildQueue.RemoveAt(num);
				canvasElement.LayoutComplete();
			}
		}
		for (int num2 = m_GraphicRebuildQueue.Count - 1; num2 >= 0; num2--)
		{
			ICanvasElement canvasElement2 = m_GraphicRebuildQueue[num2];
			if (canvasElement2 == null)
			{
				m_GraphicRebuildQueue.RemoveAt(num2);
			}
			else if (canvasElement2.IsDestroyed())
			{
				m_GraphicRebuildQueue.RemoveAt(num2);
				canvasElement2.GraphicUpdateComplete();
			}
		}
	}

	private void PerformUpdate()
	{
		UISystemProfilerApi.BeginSample(UISystemProfilerApi.SampleType.Layout);
		CleanInvalidItems();
		m_PerformingLayoutUpdate = true;
		m_LayoutRebuildQueue.Sort(s_SortLayoutFunction);
		for (int i = 0; i <= 2; i++)
		{
			for (int j = 0; j < m_LayoutRebuildQueue.Count; j++)
			{
				ICanvasElement canvasElement = m_LayoutRebuildQueue[j];
				try
				{
					if (ObjectValidForUpdate(canvasElement))
					{
						canvasElement.Rebuild((CanvasUpdate)i);
					}
				}
				catch (Exception exception)
				{
					Debug.LogException(exception, canvasElement.transform);
				}
			}
		}
		for (int k = 0; k < m_LayoutRebuildQueue.Count; k++)
		{
			m_LayoutRebuildQueue[k].LayoutComplete();
		}
		m_LayoutRebuildQueue.Clear();
		m_PerformingLayoutUpdate = false;
		UISystemProfilerApi.EndSample(UISystemProfilerApi.SampleType.Layout);
		UISystemProfilerApi.BeginSample(UISystemProfilerApi.SampleType.Render);
		ClipperRegistry.instance.Cull();
		m_PerformingGraphicUpdate = true;
		for (int l = 3; l < 5; l++)
		{
			for (int m = 0; m < m_GraphicRebuildQueue.Count; m++)
			{
				try
				{
					ICanvasElement canvasElement2 = m_GraphicRebuildQueue[m];
					if (ObjectValidForUpdate(canvasElement2))
					{
						canvasElement2.Rebuild((CanvasUpdate)l);
					}
				}
				catch (Exception exception2)
				{
					Debug.LogException(exception2, m_GraphicRebuildQueue[m].transform);
				}
			}
		}
		for (int n = 0; n < m_GraphicRebuildQueue.Count; n++)
		{
			m_GraphicRebuildQueue[n].GraphicUpdateComplete();
		}
		m_GraphicRebuildQueue.Clear();
		m_PerformingGraphicUpdate = false;
		UISystemProfilerApi.EndSample(UISystemProfilerApi.SampleType.Render);
	}

	private static int ParentCount(Transform child)
	{
		if (child == null)
		{
			return 0;
		}
		Transform parent = child.parent;
		int num = 0;
		while (parent != null)
		{
			num++;
			parent = parent.parent;
		}
		return num;
	}

	private static int SortLayoutList(ICanvasElement x, ICanvasElement y)
	{
		Transform transform = x.transform;
		Transform transform2 = y.transform;
		return ParentCount(transform) - ParentCount(transform2);
	}

	public static void RegisterCanvasElementForLayoutRebuild(ICanvasElement element)
	{
		instance.InternalRegisterCanvasElementForLayoutRebuild(element);
	}

	public static bool TryRegisterCanvasElementForLayoutRebuild(ICanvasElement element)
	{
		return instance.InternalRegisterCanvasElementForLayoutRebuild(element);
	}

	private bool InternalRegisterCanvasElementForLayoutRebuild(ICanvasElement element)
	{
		if (m_LayoutRebuildQueue.Contains(element))
		{
			return false;
		}
		return m_LayoutRebuildQueue.AddUnique(element);
	}

	public static void RegisterCanvasElementForGraphicRebuild(ICanvasElement element)
	{
		instance.InternalRegisterCanvasElementForGraphicRebuild(element);
	}

	public static bool TryRegisterCanvasElementForGraphicRebuild(ICanvasElement element)
	{
		return instance.InternalRegisterCanvasElementForGraphicRebuild(element);
	}

	private bool InternalRegisterCanvasElementForGraphicRebuild(ICanvasElement element)
	{
		if (m_PerformingGraphicUpdate)
		{
			Debug.LogError($"Trying to add {element} for graphic rebuild while we are already inside a graphic rebuild loop. This is not supported.");
			return false;
		}
		return m_GraphicRebuildQueue.AddUnique(element);
	}

	public static void UnRegisterCanvasElementForRebuild(ICanvasElement element)
	{
		instance.InternalUnRegisterCanvasElementForLayoutRebuild(element);
		instance.InternalUnRegisterCanvasElementForGraphicRebuild(element);
	}

	public static void DisableCanvasElementForRebuild(ICanvasElement element)
	{
		instance.InternalDisableCanvasElementForLayoutRebuild(element);
		instance.InternalDisableCanvasElementForGraphicRebuild(element);
	}

	private void InternalUnRegisterCanvasElementForLayoutRebuild(ICanvasElement element)
	{
		if (m_PerformingLayoutUpdate)
		{
			Debug.LogError($"Trying to remove {element} from rebuild list while we are already inside a rebuild loop. This is not supported.");
			return;
		}
		element.LayoutComplete();
		instance.m_LayoutRebuildQueue.Remove(element);
	}

	private void InternalUnRegisterCanvasElementForGraphicRebuild(ICanvasElement element)
	{
		if (m_PerformingGraphicUpdate)
		{
			Debug.LogError($"Trying to remove {element} from rebuild list while we are already inside a rebuild loop. This is not supported.");
			return;
		}
		element.GraphicUpdateComplete();
		instance.m_GraphicRebuildQueue.Remove(element);
	}

	private void InternalDisableCanvasElementForLayoutRebuild(ICanvasElement element)
	{
		if (m_PerformingLayoutUpdate)
		{
			Debug.LogError($"Trying to remove {element} from rebuild list while we are already inside a rebuild loop. This is not supported.");
			return;
		}
		element.LayoutComplete();
		instance.m_LayoutRebuildQueue.DisableItem(element);
	}

	private void InternalDisableCanvasElementForGraphicRebuild(ICanvasElement element)
	{
		if (m_PerformingGraphicUpdate)
		{
			Debug.LogError($"Trying to remove {element} from rebuild list while we are already inside a rebuild loop. This is not supported.");
			return;
		}
		element.GraphicUpdateComplete();
		instance.m_GraphicRebuildQueue.DisableItem(element);
	}

	public static bool IsRebuildingLayout()
	{
		return instance.m_PerformingLayoutUpdate;
	}

	public static bool IsRebuildingGraphics()
	{
		return instance.m_PerformingGraphicUpdate;
	}
}
