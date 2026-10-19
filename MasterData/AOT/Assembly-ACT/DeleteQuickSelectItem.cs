using ACT.UI;
using Bamboo.NumberString;
using TMPro;
using UnityEngine;

public class DeleteQuickSelectItem : MonoBehaviour
{
	public TextMeshProUGUI countTxt;

	public GameObject onselect;

	public GameObject normal;

	public int quality;

	public PublicToggle toggle;

	private bool m_isChoose;

	public bool isChoose
	{
		get
		{
			return m_isChoose;
		}
		set
		{
			m_isChoose = value;
			SetBtnState(m_isChoose);
		}
	}

	public void ChangeCountText(int count)
	{
		countTxt.text = count.FastToString();
	}

	public void BtnClick()
	{
		if (isChoose)
		{
			isChoose = false;
		}
		else
		{
			isChoose = true;
		}
	}

	public void SetBtnState(bool isSelect)
	{
		toggle.isOn = isSelect;
		normal.SetActive(!isSelect);
		onselect.SetActive(isSelect);
	}
}
