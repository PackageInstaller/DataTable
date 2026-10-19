using ACT.UI;
using Fundamental;
using UnityEngine;

namespace ACT.Config;

public class FindObjByPath : FindHighlightObjAction
{
	public FindObjByPath()
	{
	}

	public FindObjByPath(FindObjByPath other)
		: base(other)
	{
		uiType = other.uiType;
		path = other.path;
	}

	public override Transform Find(object findParam = null)
	{
		IBaseUIView baseUIView = Singleton<NewUIManager>.instance.FindUIViewByUIType(uiType);
		if (baseUIView == null)
		{
			return null;
		}
		if (string.IsNullOrEmpty(path))
		{
			return null;
		}
		Transform transform = baseUIView.transform.Find(path);
		if (transform == null)
		{
			return null;
		}
		if (transform.TryGetComponent<IBaseUIView>(out var _))
		{
			return null;
		}
		return transform;
	}
}
