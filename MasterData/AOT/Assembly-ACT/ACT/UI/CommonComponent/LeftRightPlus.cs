using TMPro;
using UnityEngine;

namespace ACT.UI.CommonComponent;

public class LeftRightPlus : MonoBehaviour
{
	[SerializeField]
	private TextMeshProUGUI leftText;

	[SerializeField]
	private TextMeshProUGUI rightText;

	[SerializeField]
	private TextMeshProUGUI plusText;

	[SerializeField]
	private GameObject plusGo;

	public void Refresh(string left, string right, string plus)
	{
		leftText.text = left;
		rightText.text = right;
		plusText.text = plus;
	}

	public void RefreshPlusGoState(bool state)
	{
		if (plusGo != null)
		{
			plusGo.gameObject.SetActive(state);
		}
	}
}
