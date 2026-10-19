using UnityEngine;

namespace ACT.UI;

public class ElementStar : MonoBehaviour, IStar
{
	public int elementID;

	public void CommonShow()
	{
		gameObject.SetActive(value: true);
	}

	public void CommonHide()
	{
		gameObject.SetActive(value: false);
	}
}
