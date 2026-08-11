using System.Collections.Generic;
using UnityEngine.Events;
using UnityEngine.Pool;

namespace UnityEngine.UI;

public class LayoutRebuilder : ICanvasElement
{
	private RectTransform m_ToRebuild;

	private int m_CachedHashFromTransform;

	private static ObjectPool<LayoutRebuilder> s_Rebuilders;

	public Transform transform => m_ToRebuild;

	private void Initialize(RectTransform controller)
	{
		m_ToRebuild = controller;
		m_CachedHashFromTransform = controller.GetHashCode();
	}

	private void Clear()
	{
		m_ToRebuild = null;
		m_CachedHashFromTransform = 0;
	}

	static LayoutRebuilder()
	{
		s_Rebuilders = new ObjectPool<LayoutRebuilder>(() => new LayoutRebuilder(), null, delegate(LayoutRebuilder x)
		{
			x.Clear();
		});
		RectTransform.reapplyDrivenProperties += ReapplyDrivenProperties;
	}

	private static void ReapplyDrivenProperties(RectTransform driven)
	{
		MarkLayoutForRebuild(driven);
	}

	public bool IsDestroyed()
	{
		return m_ToRebuild == null;
	}

	private static void StripDisabledBehavioursFromList(List<Component> components)
	{
		components.RemoveAll((Component e) => e is Behaviour && !((Behaviour)e).isActiveAndEnabled);
	}

	public static void ForceRebuildLayoutImmediate(RectTransform layoutRoot)
	{
		LayoutRebuilder layoutRebuilder = s_Rebuilders.Get();
		layoutRebuilder.Initialize(layoutRoot);
		layoutRebuilder.Rebuild(CanvasUpdate.Layout);
		s_Rebuilders.Release(layoutRebuilder);
	}

	public void Rebuild(CanvasUpdate executing)
	{
		if (executing == CanvasUpdate.Layout)
		{
			PerformLayoutCalculation(m_ToRebuild, delegate(Component e)
			{
				(e as ILayoutElement).CalculateLayoutInputHorizontal();
			});
			PerformLayoutControl(m_ToRebuild, delegate(Component e)
			{
				(e as ILayoutController).SetLayoutHorizontal();
			});
			PerformLayoutCalculation(m_ToRebuild, delegate(Component e)
			{
				(e as ILayoutElement).CalculateLayoutInputVertical();
			});
			PerformLayoutControl(m_ToRebuild, delegate(Component e)
			{
				(e as ILayoutController).SetLayoutVertical();
			});
		}
	}

	private void PerformLayoutControl(RectTransform rect, UnityAction<Component> action)
	{
		if (rect == null)
		{
			return;
		}
		List<Component> list = CollectionPool<List<Component>, Component>.Get();
		rect.GetComponents(typeof(ILayoutController), list);
		StripDisabledBehavioursFromList(list);
		if (list.Count > 0)
		{
			for (int i = 0; i < list.Count; i++)
			{
				if (list[i] is ILayoutSelfController)
				{
					action(list[i]);
				}
			}
			for (int j = 0; j < list.Count; j++)
			{
				if (list[j] is ILayoutSelfController)
				{
					continue;
				}
				Component component = list[j];
				if ((bool)component && component is ScrollRect)
				{
					if (((ScrollRect)component).content != rect)
					{
						action(list[j]);
					}
				}
				else
				{
					action(list[j]);
				}
			}
			for (int k = 0; k < rect.childCount; k++)
			{
				PerformLayoutControl(rect.GetChild(k) as RectTransform, action);
			}
		}
		CollectionPool<List<Component>, Component>.Release(list);
	}

	private void PerformLayoutCalculation(RectTransform rect, UnityAction<Component> action)
	{
		if (rect == null)
		{
			return;
		}
		List<Component> list = CollectionPool<List<Component>, Component>.Get();
		rect.GetComponents(typeof(ILayoutElement), list);
		StripDisabledBehavioursFromList(list);
		if (list.Count > 0 || (bool)rect.GetComponent(typeof(ILayoutGroup)))
		{
			for (int i = 0; i < rect.childCount; i++)
			{
				PerformLayoutCalculation(rect.GetChild(i) as RectTransform, action);
			}
			for (int j = 0; j < list.Count; j++)
			{
				action(list[j]);
			}
		}
		CollectionPool<List<Component>, Component>.Release(list);
	}

	public static void MarkLayoutForRebuild(RectTransform rect)
	{
		if (rect == null || rect.gameObject == null)
		{
			return;
		}
		List<Component> list = CollectionPool<List<Component>, Component>.Get();
		bool flag = true;
		RectTransform rectTransform = rect;
		RectTransform rectTransform2 = rectTransform.parent as RectTransform;
		while (flag && !(rectTransform2 == null) && !(rectTransform2.gameObject == null))
		{
			flag = false;
			rectTransform2.GetComponents(typeof(ILayoutGroup), list);
			for (int i = 0; i < list.Count; i++)
			{
				Component component = list[i];
				if (component != null && component is Behaviour && ((Behaviour)component).isActiveAndEnabled)
				{
					flag = true;
					rectTransform = rectTransform2;
					break;
				}
			}
			rectTransform2 = rectTransform2.parent as RectTransform;
		}
		if (rectTransform == rect && !ValidController(rectTransform, list))
		{
			CollectionPool<List<Component>, Component>.Release(list);
			return;
		}
		MarkLayoutRootForRebuild(rectTransform);
		CollectionPool<List<Component>, Component>.Release(list);
	}

	private static bool ValidController(RectTransform layoutRoot, List<Component> comps)
	{
		if (layoutRoot == null || layoutRoot.gameObject == null)
		{
			return false;
		}
		layoutRoot.GetComponents(typeof(ILayoutController), comps);
		for (int i = 0; i < comps.Count; i++)
		{
			Component component = comps[i];
			if (component != null && component is Behaviour && ((Behaviour)component).isActiveAndEnabled)
			{
				return true;
			}
		}
		return false;
	}

	private static void MarkLayoutRootForRebuild(RectTransform controller)
	{
		if (!(controller == null))
		{
			LayoutRebuilder layoutRebuilder = s_Rebuilders.Get();
			layoutRebuilder.Initialize(controller);
			if (!CanvasUpdateRegistry.TryRegisterCanvasElementForLayoutRebuild(layoutRebuilder))
			{
				s_Rebuilders.Release(layoutRebuilder);
			}
		}
	}

	public void LayoutComplete()
	{
		s_Rebuilders.Release(this);
	}

	public void GraphicUpdateComplete()
	{
	}

	public override int GetHashCode()
	{
		return m_CachedHashFromTransform;
	}

	public override bool Equals(object obj)
	{
		return obj.GetHashCode() == GetHashCode();
	}

	public override string ToString()
	{
		return "(Layout Rebuilder for) " + m_ToRebuild;
	}
}
