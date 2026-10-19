using System.Collections.Generic;
using UnityEngine.Pool;

namespace UnityEngine.UI;

public class MaskUtilities
{
	public static void Notify2DMaskStateChanged(Component mask)
	{
		List<Component> list = CollectionPool<List<Component>, Component>.Get();
		mask.GetComponentsInChildren(list);
		for (int i = 0; i < list.Count; i++)
		{
			if (!(list[i] == null) && !(list[i].gameObject == mask.gameObject) && list[i] is IClippable clippable)
			{
				clippable.RecalculateClipping();
			}
		}
		CollectionPool<List<Component>, Component>.Release(list);
	}

	public static void NotifyStencilStateChanged(Component mask)
	{
		List<Component> list = CollectionPool<List<Component>, Component>.Get();
		mask.GetComponentsInChildren(list);
		for (int i = 0; i < list.Count; i++)
		{
			if (!(list[i] == null) && !(list[i].gameObject == mask.gameObject) && list[i] is IMaskable maskable)
			{
				maskable.RecalculateMasking();
			}
		}
		CollectionPool<List<Component>, Component>.Release(list);
	}

	public static Transform FindRootSortOverrideCanvas(Transform start)
	{
		List<Canvas> list = CollectionPool<List<Canvas>, Canvas>.Get();
		start.GetComponentsInParent(includeInactive: false, list);
		Canvas canvas = null;
		for (int i = 0; i < list.Count; i++)
		{
			canvas = list[i];
			if (canvas.overrideSorting)
			{
				break;
			}
		}
		CollectionPool<List<Canvas>, Canvas>.Release(list);
		if (!(canvas != null))
		{
			return null;
		}
		return canvas.transform;
	}

	public static int GetStencilDepth(Transform transform, Transform stopAfter)
	{
		int num = 0;
		if (transform == stopAfter)
		{
			return num;
		}
		Transform parent = transform.parent;
		List<Mask> list = CollectionPool<List<Mask>, Mask>.Get();
		while (parent != null)
		{
			parent.GetComponents(list);
			for (int i = 0; i < list.Count; i++)
			{
				if (list[i] != null && list[i].MaskEnabled() && list[i].graphic.IsActive())
				{
					num++;
					break;
				}
			}
			if (parent == stopAfter)
			{
				break;
			}
			parent = parent.parent;
		}
		CollectionPool<List<Mask>, Mask>.Release(list);
		return num;
	}

	public static bool IsDescendantOrSelf(Transform father, Transform child)
	{
		if (father == null || child == null)
		{
			return false;
		}
		if (father == child)
		{
			return true;
		}
		while (child.parent != null)
		{
			if (child.parent == father)
			{
				return true;
			}
			child = child.parent;
		}
		return false;
	}

	public static RectMask2D GetRectMaskForClippable(IClippable clippable)
	{
		List<RectMask2D> list = CollectionPool<List<RectMask2D>, RectMask2D>.Get();
		List<Canvas> list2 = CollectionPool<List<Canvas>, Canvas>.Get();
		RectMask2D rectMask2D = null;
		clippable.gameObject.GetComponentsInParent(includeInactive: false, list);
		if (list.Count > 0)
		{
			for (int i = 0; i < list.Count; i++)
			{
				rectMask2D = list[i];
				if (rectMask2D.gameObject == clippable.gameObject)
				{
					rectMask2D = null;
					continue;
				}
				if (!rectMask2D.isActiveAndEnabled)
				{
					rectMask2D = null;
					continue;
				}
				clippable.gameObject.GetComponentsInParent(includeInactive: false, list2);
				for (int num = list2.Count - 1; num >= 0; num--)
				{
					if (!IsDescendantOrSelf(list2[num].transform, rectMask2D.transform) && list2[num].overrideSorting)
					{
						rectMask2D = null;
						break;
					}
				}
				break;
			}
		}
		CollectionPool<List<RectMask2D>, RectMask2D>.Release(list);
		CollectionPool<List<Canvas>, Canvas>.Release(list2);
		return rectMask2D;
	}

	public static void GetRectMasksForClip(RectMask2D clipper, List<RectMask2D> masks)
	{
		masks.Clear();
		List<Canvas> list = CollectionPool<List<Canvas>, Canvas>.Get();
		List<RectMask2D> list2 = CollectionPool<List<RectMask2D>, RectMask2D>.Get();
		clipper.transform.GetComponentsInParent(includeInactive: false, list2);
		if (list2.Count > 0)
		{
			clipper.transform.GetComponentsInParent(includeInactive: false, list);
			for (int num = list2.Count - 1; num >= 0; num--)
			{
				if (list2[num].IsActive())
				{
					bool flag = true;
					for (int num2 = list.Count - 1; num2 >= 0; num2--)
					{
						if (!IsDescendantOrSelf(list[num2].transform, list2[num].transform) && list[num2].overrideSorting)
						{
							flag = false;
							break;
						}
					}
					if (flag)
					{
						masks.Add(list2[num]);
					}
				}
			}
		}
		CollectionPool<List<RectMask2D>, RectMask2D>.Release(list2);
		CollectionPool<List<Canvas>, Canvas>.Release(list);
	}
}
