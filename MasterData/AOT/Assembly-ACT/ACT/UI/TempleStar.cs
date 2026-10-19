using UnityEngine;

namespace ACT.UI;

public class TempleStar : MonoBehaviour, IStar
{
	public GameObject light;

	public void CommonShow()
	{
		light.SetActive(value: true);
	}

	public void CommonHide()
	{
		light.SetActive(value: false);
	}
}
