using ACT.UI;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.Config;

public class FindObjInLayoutGroup : FindHighlightObjAction
{
	public int index;

	public FindObjInLayoutGroup()
	{
	}

	public FindObjInLayoutGroup(FindObjInLayoutGroup other)
		: base(other)
	{
		uiType = other.uiType;
		path = other.path;
		index = other.index;
	}

	public override Transform Find(object findParam = null)
	{
		Transform transform = Singleton<NewUIManager>.instance.FindUIViewByUIType(uiType).transform.Find(path);
		if (transform == null)
		{
			return null;
		}
		LayoutGroup component = transform.GetComponent<LayoutGroup>();
		if (component == null)
		{
			return null;
		}
		for (int i = 0; i < component.transform.childCount; i++)
		{
			if (i == index)
			{
				return component.transform.GetChild(i);
			}
		}
		return null;
	}
}
