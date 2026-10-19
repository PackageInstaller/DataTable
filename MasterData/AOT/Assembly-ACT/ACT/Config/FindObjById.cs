using ACT.UI;
using Fundamental;
using UnityEngine;

namespace ACT.Config;

public class FindObjById : FindHighlightObjAction
{
	public FindObjById()
	{
	}

	public FindObjById(FindObjById other)
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
		return baseUIView.FindGuideTarget(path);
	}
}
