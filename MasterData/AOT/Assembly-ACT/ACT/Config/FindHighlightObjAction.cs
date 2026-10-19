using ACT.UI;
using UnityEngine;

namespace ACT.Config;

public abstract class FindHighlightObjAction
{
	public UI_TYPE uiType;

	public string path;

	public abstract Transform Find(object findParam = null);

	public FindHighlightObjAction()
	{
	}

	public FindHighlightObjAction(FindHighlightObjAction other)
	{
	}
}
