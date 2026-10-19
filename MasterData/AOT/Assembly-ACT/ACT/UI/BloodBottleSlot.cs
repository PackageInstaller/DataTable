using Bamboo.ImageCenter;
using UnityEngine;

namespace ACT.UI;

public class BloodBottleSlot : MonoBehaviour, ISolt
{
	public GameObject normal;

	public GameObject lockState;

	public GameObject hide;

	private const int _bloodBottleSoltConfigId = 140;

	public BImage icon;

	public int ConfigId => 140;

	public void CommonShow()
	{
		normal.SetActive(value: true);
		lockState.SetActive(value: false);
		hide.SetActive(value: false);
	}

	public void CommonHide()
	{
		normal.SetActive(value: false);
		lockState.SetActive(value: false);
		hide.SetActive(value: true);
	}

	public void LockToShow()
	{
		normal.SetActive(value: false);
		lockState.SetActive(value: true);
		hide.SetActive(value: false);
	}
}
