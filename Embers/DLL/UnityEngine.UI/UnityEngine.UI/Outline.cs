using System.Collections.Generic;
using UnityEngine.Pool;

namespace UnityEngine.UI;

[AddComponentMenu("UI/Effects/Outline", 81)]
public class Outline : Shadow
{
	protected Outline()
	{
	}

	public override void ModifyMesh(VertexHelper vh)
	{
		if (IsActive())
		{
			List<UIVertex> list = CollectionPool<List<UIVertex>, UIVertex>.Get();
			vh.GetUIVertexStream(list);
			int num = list.Count * 5;
			if (list.Capacity < num)
			{
				list.Capacity = num;
			}
			int start = 0;
			int count = list.Count;
			ApplyShadowZeroAlloc(list, base.effectColor, start, list.Count, base.effectDistance.x, base.effectDistance.y);
			start = count;
			int count2 = list.Count;
			ApplyShadowZeroAlloc(list, base.effectColor, start, list.Count, base.effectDistance.x, 0f - base.effectDistance.y);
			start = count2;
			int count3 = list.Count;
			ApplyShadowZeroAlloc(list, base.effectColor, start, list.Count, 0f - base.effectDistance.x, base.effectDistance.y);
			start = count3;
			_ = list.Count;
			ApplyShadowZeroAlloc(list, base.effectColor, start, list.Count, 0f - base.effectDistance.x, 0f - base.effectDistance.y);
			vh.Clear();
			vh.AddUIVertexTriangleStream(list);
			CollectionPool<List<UIVertex>, UIVertex>.Release(list);
		}
	}
}
