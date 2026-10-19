using System.Collections.Generic;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class UIRelativeEffect : MonoBehaviour
{
	public int relativeLayer;

	public List<UIEffectRendering> uiEffects = new List<UIEffectRendering>();

	public void SetSortingLayer(int layer)
	{
		int layer2 = relativeLayer + layer;
		foreach (UIEffectRendering uiEffect in uiEffects)
		{
			uiEffect.layer = layer2;
		}
	}

	public void AddUIEffect(object context)
	{
		Singleton<NewUIManager>.instance.PushUIEffectRenderingList(context, uiEffects);
	}

	public void RemoveUIEffect(object context)
	{
		Singleton<NewUIManager>.instance.PopUIEffectRenderingList(context, uiEffects);
	}
}
