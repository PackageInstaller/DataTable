using UnityEngine;

namespace ACT.UI;

public class QualityStar : MonoBehaviour, IStar
{
	public void CommonShow()
	{
		gameObject.SetActive(value: true);
	}

	public void CommonHide()
	{
		gameObject.SetActive(value: false);
	}
}
