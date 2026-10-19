using System;
using UnityEngine;
using UnityEngine.UI;
using frame8.Logic.Misc.Visual.UI.MonoBehaviours;

namespace Com.ForbiddenByte.OSA.Core;

public class OSAUtil
{
	public static bool DotNETCoreCompat_IsAssignableFrom(Type to, Type from)
	{
		if (!to.IsAssignableFrom(from))
		{
			return false;
		}
		return true;
	}

	public static ScrollbarFixer8 ConfigureDinamicallyCreatedScrollbar(Scrollbar scrollbar, IOSA iAdapter, RectTransform viewport, bool addFixerIfDoesntExist = true)
	{
		ScrollbarFixer8 scrollbarFixer = scrollbar.GetComponent<ScrollbarFixer8>();
		if (!scrollbarFixer)
		{
			if (!addFixerIfDoesntExist)
			{
				return null;
			}
			scrollbarFixer = scrollbar.gameObject.AddComponent<ScrollbarFixer8>();
		}
		scrollbarFixer.externalScrollRectProxy = iAdapter;
		scrollbarFixer.viewport = viewport;
		return scrollbarFixer;
	}
}
