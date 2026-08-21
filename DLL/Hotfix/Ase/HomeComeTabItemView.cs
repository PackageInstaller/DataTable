using System;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HomeComeTabItemView : MonoBehaviour
{
	[SerializeField]
	private TextMeshProUGUI txt;

	[SerializeField]
	private GameObject selectImg;

	[SerializeField]
	private GameObject redPoint;

	[SerializeField]
	private Button button;

	public void Refresh(string title, bool selected, bool showRed, Action onClick)
	{
		if ((UnityEngine.Object)(object)txt != null)
		{
			((TMP_Text)txt).text = title;
		}
		if (selectImg != null)
		{
			selectImg.SetActive(selected);
		}
		if (redPoint != null)
		{
			redPoint.SetActive(showRed);
		}
		if (!(button != null))
		{
			return;
		}
		button.onClick.RemoveAllListeners();
		if (onClick != null)
		{
			button.onClick.AddListener(delegate
			{
				onClick();
			});
		}
	}
}
