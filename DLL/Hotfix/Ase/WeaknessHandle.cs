using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class WeaknessHandle : MonoBehaviour
{
	public List<CanvasGroup> CanvasGroups;

	public List<Image> WeaknessImages;

	public RectTransform RectTransform;

	public void SetHandleFillAmount(int level, float fillAmount)
	{
		for (int i = 0; i < CanvasGroups.Count; i++)
		{
			CanvasGroups[i].alpha = ((i == level - 1) ? 1 : 0);
		}
		for (int j = 0; j < WeaknessImages.Count; j++)
		{
			WeaknessImages[j].fillAmount = fillAmount;
		}
	}

	public void SetHandleAlpha(int level, float alpha)
	{
		CanvasGroups[level - 1].alpha = alpha;
	}

	public void HideHandle()
	{
		for (int i = 0; i < CanvasGroups.Count; i++)
		{
			CanvasGroups[i].alpha = 0f;
		}
	}

	public void SetPos(Vector3 pos)
	{
		RectTransform.anchoredPosition = pos;
	}
}
