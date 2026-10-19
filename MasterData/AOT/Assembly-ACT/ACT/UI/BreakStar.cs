using UnityEngine;

namespace ACT.UI;

public class BreakStar : MonoBehaviour, IStar
{
	public GameObject notEnabled;

	public new GameObject enabled;

	public GameObject border;

	public void CommonShow()
	{
		notEnabled.SetActive(value: false);
		border.SetActive(value: false);
		enabled.SetActive(value: true);
	}

	public void BreakToShow()
	{
		enabled.SetActive(value: false);
		notEnabled.SetActive(value: true);
		border.SetActive(value: true);
	}

	public void CommonHide()
	{
		border.SetActive(value: false);
		enabled.SetActive(value: false);
		notEnabled.SetActive(value: true);
	}
}
