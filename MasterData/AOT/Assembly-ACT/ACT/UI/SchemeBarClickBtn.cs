using ACT.Utility;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;

namespace ACT.UI;

public class SchemeBarClickBtn : UIBehaviour
{
	public ActButton btn;

	public TextMeshProUGUI selectSchemeName;

	public RectTransform closeArrow;

	public RectTransform openArrow;

	public void SetBtnClick(UnityAction todo)
	{
		btn?.SetBtnClick(todo);
	}

	public void SetBtnText(string text)
	{
		if (selectSchemeName != null)
		{
			selectSchemeName.text = text;
		}
	}

	public void SetOpenState(bool open)
	{
		closeArrow?.gameObject.SetActive(open);
		openArrow?.gameObject.SetActive(!open);
	}
}
