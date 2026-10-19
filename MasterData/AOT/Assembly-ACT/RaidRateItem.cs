using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;

public class RaidRateItem : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, IPointerExitHandler
{
	public TextMeshProUGUI X;

	public TextMeshProUGUI Count;

	public GameObject Lock;

	public GameObject New;

	public GameObject Hight;

	public List<GameObject> StarBG;

	public List<GameObject> Star;

	public GameObject doubleRewardTag;

	private Color disColor = new Color(127f / 255f, 127f / 255f, 127f / 255f);

	private Color selectColor = Color.white;

	private Color normalColor = new Color(107f / 255f, 149f / 255f, 140f / 255f);

	public void OnPointerEnter(PointerEventData eventData)
	{
		Hight.SetActive(value: true);
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		Hight.SetActive(value: false);
	}

	public void RefreshUI(bool isUnlock, bool isSelect, bool isNew, int totalStarCount, int requiredStarCount, bool showDoubleRewardTag = false)
	{
		Lock.SetActive(value: false);
		New.SetActive(value: false);
		if (doubleRewardTag != null)
		{
			doubleRewardTag.SetActive(isUnlock & showDoubleRewardTag);
		}
		if (!isUnlock)
		{
			Lock.SetActive(value: true);
			X.color = disColor;
			Count.color = disColor;
		}
		else
		{
			if (isSelect)
			{
				X.color = selectColor;
				Count.color = selectColor;
			}
			else
			{
				X.color = normalColor;
				Count.color = normalColor;
			}
			if (isNew)
			{
				New.SetActive(value: true);
			}
		}
		for (int i = 0; i < StarBG.Count; i++)
		{
			bool flag = !isUnlock && requiredStarCount > 0 && i < totalStarCount;
			StarBG[i].SetActive(flag);
			Star[i].SetActive(flag && i < requiredStarCount);
		}
	}
}
